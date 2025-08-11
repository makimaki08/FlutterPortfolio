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

              // 代表ドキュメント（イベントの表示情報用）
              final head = list.first.data();
              final start = head['start'] is Timestamp
                  ? (head['start'] as Timestamp).toDate()
                  : null;
              final end = head['end'] is Timestamp
                  ? (head['end'] as Timestamp).toDate()
                  : null;
              final summary = (head['summary'] as String?) ?? '(無題)';
              final description = (head['description'] as String?) ?? '';
              final eventId = (head['eventId'] ?? head['id'] ?? '') as String;

              // ステータスごとに分類
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

              // 件数チップ
              Widget counterChip(Color color, String label, int count) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Text('$label $count',
                      style: TextStyle(color: color, fontSize: 12)),
                );
              }

              // 子の表示行
              List<Widget> buildPeople(
                  List<Map<String, dynamic>> items, AttendanceStatus status) {
                if (items.isEmpty) {
                  return [
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8),
                      child: Text('該当者なし',
                          style: TextStyle(color: Colors.black54)),
                    )
                  ];
                }
                return items.map((m) {
                  final uid = (m['uid'] as String?) ?? '';
                  final name = childNameMap.value[uid] ?? uid;
                  final reason = (m['reason'] as String?)?.trim() ?? '';
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(left: 8, right: 8),
                    leading: Icon(
                      status == AttendanceStatus.absent
                          ? Icons.event_busy
                          : status == AttendanceStatus.late
                              ? Icons.schedule
                              : Icons.logout,
                      color: status == AttendanceStatus.absent
                          ? Colors.redAccent
                          : status == AttendanceStatus.late
                              ? Colors.orange
                              : Colors.blue,
                    ),
                    title: Text(name),
                    subtitle: reason.isNotEmpty ? Text('理由: $reason') : null,
                  );
                }).toList();
              }

              // CalendarDetailPage へ飛ぶためのイベント生成
              final event = CalendarEvent(
                id: eventId,
                summary: summary,
                description: description,
                start: start ?? DateTime.now(),
                end: end ?? DateTime.now(),
                duration: head['duration'],
              );

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                  title: Text(summary,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: start != null ? Text('${start.toLocal()}') : null,
                  trailing: Wrap(
                    spacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      counterChip(Colors.redAccent, '欠席', absent.length),
                      counterChip(Colors.orange, '遅刻', late.length),
                      counterChip(Colors.blue, '早退', early.length),
                    ],
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  children: [
                    // 欠席
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 4),
                      child: Text('欠席',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...buildPeople(absent, AttendanceStatus.absent),

                    // 遅刻
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 4),
                      child: Text('遅刻',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...buildPeople(late, AttendanceStatus.late),

                    // 早退
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 4),
                      child: Text('早退',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...buildPeople(early, AttendanceStatus.early),

                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('詳細ページを開く'),
                        onPressed: () =>
                            context.go('/calendar/detail', extra: event),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
