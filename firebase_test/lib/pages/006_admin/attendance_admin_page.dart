import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/constants/attendance_status.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AttendanceAdminPage extends HookWidget {
  const AttendanceAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 今日0:00
    final now = DateTime.now();
    final dayStart = DateTime(now.year, now.month, now.day);
    final dayStartTs = Timestamp.fromDate(dayStart);

    // 子ども名のキャッシュ: children の doc.id => name
    final childNameMap = useState<Map<String, String>>({});
    useEffect(() {
      Future<void> loadChildren() async {
        final snap =
            await FirebaseFirestore.instance.collection('children').get();
        childNameMap.value = {
          for (final d in snap.docs) d.id: (d.data()['name'] as String?) ?? '',
        };
      }

      loadChildren();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(title: const Text('出欠管理（今日以降）')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('attendances')
            .where('start', isGreaterThanOrEqualTo: dayStartTs)
            .orderBy('start') // 同一フィールドの範囲+並びは単一フィールドインデックスでOK
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '出欠の取得に失敗しました\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('対象の出欠はありません'));
          }

          // eventId でグルーピング
          final Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>
              grouped = {};
          for (final d in docs) {
            final eid = (d.data()['eventId'] ?? d.data()['id'] ?? '') as String;
            if (eid.isEmpty) continue;
            grouped.putIfAbsent(eid, () => []).add(d);
          }

          final groups = grouped.entries.toList()
            ..sort((a, b) {
              // グループの代表 start で並び替え
              final da = a.value.first.data();
              final db = b.value.first.data();
              final ta = da['start'] is Timestamp
                  ? (da['start'] as Timestamp).toDate()
                  : now;
              final tb = db['start'] is Timestamp
                  ? (db['start'] as Timestamp).toDate()
                  : now;
              return ta.compareTo(tb);
            });

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final entry = groups[index];
              final list = entry.value;

              final head = list.first.data();
              final start = head['start'] is Timestamp
                  ? (head['start'] as Timestamp).toDate()
                  : null;
              final end = head['end'] is Timestamp
                  ? (head['end'] as Timestamp).toDate()
                  : null;
              final summary = (head['summary'] as String?) ?? '(無題)';
              final description = (head['description'] as String?) ?? '';

              final absent = <Map<String, dynamic>>[];
              final late = <Map<String, dynamic>>[];
              final early = <Map<String, dynamic>>[];
              for (final d in list) {
                final data = d.data();
                switch (data['status']) {
                  case 'absent':
                    absent.add(data);
                    break;
                  case 'late':
                    late.add(data);
                    break;
                  case 'early':
                    early.add(data);
                    break;
                }
              }

              // 画面幅に応じてサイズ調整
              final width = MediaQuery.of(context).size.width;
              final compact = width < 360;

              String ellipsize(String s, {int max = 22}) {
                if (s.length <= max) return s;
                return s.substring(0, max) + '…';
              }

              Widget statusChips(String label, Color color, IconData icon,
                  List<Map<String, dynamic>> items) {
                if (items.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon,
                              size: compact ? 14 : 16,
                              color: color.withOpacity(.9)),
                          const SizedBox(width: 4),
                          Text(
                            '$label (${items.length})',
                            style: TextStyle(
                              fontSize: compact ? 11 : 12,
                              fontWeight: FontWeight.w600,
                              color: color.withOpacity(.9),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        spacing: 6,
                        runSpacing: -4,
                        children: items.map((m) {
                          final uid = (m['uid'] as String?) ?? '';
                          final name = childNameMap.value[uid] ?? uid;
                          final reason = (m['reason'] as String?)?.trim() ?? '';
                          final short = reason.isEmpty
                              ? name
                              : '$name (${ellipsize(reason, max: compact ? 10 : 16)})';
                          return Tooltip(
                            message:
                                reason.isEmpty ? name : '$name / 理由: $reason',
                            triggerMode: TooltipTriggerMode.longPress,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: compact ? 6 : 8,
                                vertical: compact ? 2 : 3,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(.08),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    color: color.withOpacity(.25), width: 0.7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(icon,
                                      size: compact ? 12 : 14,
                                      color: color.withOpacity(.9)),
                                  const SizedBox(width: 3),
                                  Text(
                                    short,
                                    style: TextStyle(
                                      fontSize: compact ? 10.5 : 11.5,
                                      height: 1.1,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 1.5,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      12, compact ? 8 : 10, 12, compact ? 8 : 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 上段: タイトル + 日時
                      Text(
                        summary,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: compact ? 14 : 15.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (start != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          '${start.month}/${start.day} '
                          '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}'
                          '${end != null ? ' 〜 ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}' : ''}',
                          style: TextStyle(
                            fontSize: compact ? 10.5 : 11,
                            color: Colors.black54,
                            height: 1.2,
                          ),
                        ),
                      ],
                      if (description.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          ellipsize(description, max: compact ? 40 : 70),
                          style: TextStyle(
                            fontSize: compact ? 10.5 : 11,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                      // ステータス別
                      statusChips(
                          '欠席', Colors.redAccent, Icons.event_busy, absent),
                      statusChips('遅刻', Colors.orange, Icons.schedule, late),
                      statusChips('早退', Colors.blue, Icons.logout, early),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
