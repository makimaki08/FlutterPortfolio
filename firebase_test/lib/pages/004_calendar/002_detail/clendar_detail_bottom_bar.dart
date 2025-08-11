// BottomNavigation 分割（更新ボタン＋差分反映）
import 'package:firebase_test/constants/attendance_status.dart';
import 'package:firebase_test/models/controller/calendar_detail/calendar_detail_controller.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/entities/event/calendar_event.dart';

class CalendarDetailBottomBar extends HookConsumerWidget {
  const CalendarDetailBottomBar({
    super.key,
    required this.event,
    required this.selections,
    required this.initialSelectionsRef,
    required this.reasons,
  });

  final CalendarEvent event;
  final ValueNotifier<Map<String, AttendanceStatus>> selections;
  final ValueNotifier<Map<String, AttendanceStatus>> initialSelectionsRef;
  final ValueNotifier<Map<String, String>> reasons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(calendarDetailProvider);
    final insetsBottom = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: insetsBottom), // キーボードに追従
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                // 差分を算出
                final current = selections.value;
                final original = initialSelectionsRef.value;
                final reasonMap = reasons.value;

                final currentUids = current.keys.toSet();
                final originalUids = original.keys.toSet();
                final toDelete = originalUids.difference(currentUids).toList();

                final absentUids = current.entries
                    .where((e) => e.value == AttendanceStatus.absent)
                    .map((e) => e.key)
                    .toList();
                final lateUids = current.entries
                    .where((e) => e.value == AttendanceStatus.late)
                    .map((e) => e.key)
                    .toList();
                final earlyUids = current.entries
                    .where((e) => e.value == AttendanceStatus.early)
                    .map((e) => e.key)
                    .toList();

                // 上書き保存（ステータスごとに呼び分け）
                if (absentUids.isNotEmpty) {
                  await controller.addAttendanceInfo(
                    event: event,
                    uids: absentUids,
                    status: AttendanceStatus.absent,
                    reasons: reasonMap,
                  );
                }
                if (lateUids.isNotEmpty) {
                  await controller.addAttendanceInfo(
                    event: event,
                    uids: lateUids,
                    status: AttendanceStatus.late,
                    reasons: reasonMap,
                  );
                }
                if (earlyUids.isNotEmpty) {
                  await controller.addAttendanceInfo(
                    event: event,
                    uids: earlyUids,
                    status: AttendanceStatus.early,
                    reasons: reasonMap,
                  );
                }

                // 解除分は削除（理由も消しておくとUIが綺麗）
                if (toDelete.isNotEmpty) {
                  final nextReasons = Map<String, String>.from(reasonMap);
                  for (final uid in toDelete) {
                    nextReasons.remove(uid);
                  }
                  reasons.value = nextReasons;

                  await controller.clearAttendanceInfo(
                    event: event,
                    uids: toDelete,
                  );
                }

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('出欠を更新しました')),
                  );
                  context.pop();
                }
              },
              icon: const Icon(Icons.save, color: AppColors.whitesmoke),
              label: const Text('更新する'),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whitesmoke,
                backgroundColor: AppColors.blue,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
