// BottomNavigation 分割（更新ボタン＋差分反映）
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/constants/attendance_status.dart';
import 'package:firebase_test/models/controller/calendar_detail/calendar_detail_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Body 分割（詳細ヘッダー + ステータス切替 + リスト）
class CalendarDetailBody extends HookConsumerWidget {
  const CalendarDetailBody({
    super.key,
    required this.event,
    required this.users,
    required this.status,
    required this.selections,
    required this.initialSelectionsRef,
    required this.reasons,
  });

  final CalendarEvent event;
  final List<dynamic> users; // 型が定義されていれば置き換えてください
  final ValueNotifier<AttendanceStatus> status;
  final ValueNotifier<Map<String, AttendanceStatus>> selections;
  final ValueNotifier<Map<String, AttendanceStatus>> initialSelectionsRef;
  final ValueNotifier<Map<String, String>> reasons;

  AttendanceStatus _parseStatus(String s) {
    switch (s) {
      case 'late':
        return AttendanceStatus.late;
      case 'early':
        return AttendanceStatus.early;
      case 'absent':
      default:
        return AttendanceStatus.absent;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoController childrenInfoController =
        ref.watch(childrenInfoEditProvider.notifier);

    // 初期ロード（子ども情報 + 既存登録の復元）
    useEffect(() {
      childrenInfoController.fetchChildrenInfo();
      Future<void> fetchExisting() async {
        final snapshot = await FirebaseFirestore.instance
            .collection('collectionPath')
            .where('id', isEqualTo: event.id)
            .get();

        final map = <String, AttendanceStatus>{};
        final reasonMap = <String, String>{};
        for (final doc in snapshot.docs) {
          final uid = doc['uid'] as String?;
          final s = (doc['status'] as String?) ?? 'absent';
          final r = (doc.data()['reason'] as String?) ?? '';
          if (uid != null && uid.isNotEmpty) {
            map[uid] = _parseStatus(s);
            if (r.isNotEmpty) reasonMap[uid] = r;
          }
        }
        selections.value = Map<String, AttendanceStatus>.from(map);
        initialSelectionsRef.value = Map<String, AttendanceStatus>.from(map);
        reasons.value = reasonMap;
      }

      fetchExisting();
      return null;
    }, const []);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              event.summary,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  '${event.duration}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(event.description,
                style: Theme.of(context).textTheme.bodyMedium),
            const Divider(height: 32),

            // ステータス切替（このステータスでチェックを付ける）
            Text('登録ステータス', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('欠席'),
                  selected: status.value == AttendanceStatus.absent,
                  onSelected: (_) => status.value = AttendanceStatus.absent,
                ),
                ChoiceChip(
                  label: const Text('遅刻'),
                  selected: status.value == AttendanceStatus.late,
                  onSelected: (_) => status.value = AttendanceStatus.late,
                ),
                ChoiceChip(
                  label: const Text('早退'),
                  selected: status.value == AttendanceStatus.early,
                  onSelected: (_) => status.value = AttendanceStatus.early,
                ),
              ],
            ),
            const Gap(12),

            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                padding: const EdgeInsets.only(bottom: 160),
                itemBuilder: (context, index) {
                  final user = users[index];
                  final uid = user.docId;
                  final isSelected =
                      uid != null && selections.value.containsKey(uid);
                  final selectedStatus =
                      uid != null ? selections.value[uid] : null;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Column(
                      children: [
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: isSelected,
                          dense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          secondary: const CircleAvatar(
                            backgroundColor: AppColors.whitesmoke,
                            child:
                                Icon(Icons.person, color: AppColors.darkgray),
                          ),
                          title: Text(
                            user.name ?? '',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color:
                                  isSelected ? AppColors.blue : Colors.black87,
                            ),
                          ),
                          subtitle: isSelected && selectedStatus != null
                              ? Text('登録: ${selectedStatus.label}',
                                  style: const TextStyle(color: Colors.grey))
                              : null,
                          onChanged: (isChecked) {
                            if (uid == null) return;
                            HapticFeedback.selectionClick();
                            final next = Map<String, AttendanceStatus>.from(
                                selections.value);
                            final nextReasons =
                                Map<String, String>.from(reasons.value);
                            if (isChecked == true) {
                              next[uid] = status.value; // 現在のステータスで割当
                            } else {
                              next.remove(uid);
                              nextReasons.remove(uid); // 理由もクリア
                            }
                            selections.value = next;
                            reasons.value = nextReasons;
                          },
                        ),
                        // 選択中は理由入力欄を表示
                        if (isSelected && uid != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                            child: TextFormField(
                              key: ValueKey('reason-$uid'),
                              initialValue: reasons.value[uid] ?? '',
                              maxLines: 3,
                              minLines: 1,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                labelText: '理由（任意）',
                                hintText:
                                    '${selectedStatus?.label ?? '出欠'}の理由を入力',
                                border: const OutlineInputBorder(),
                                isDense: true,
                              ),
                              onChanged: (v) {
                                final next =
                                    Map<String, String>.from(reasons.value);
                                if (v.trim().isEmpty) {
                                  next.remove(uid);
                                } else {
                                  next[uid] = v;
                                }
                                reasons.value = next;
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
