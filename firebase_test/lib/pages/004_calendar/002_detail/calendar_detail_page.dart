import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/calendar_detail/calendar_detail_controller.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:firebase_test/widgets/calendar_event_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarDetailPage extends HookConsumerWidget {
  const CalendarDetailPage({
    super.key,
    required this.event,
  });
  final CalendarEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(calendarDetailProvider);
    final LoginState loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Detail"),
        centerTitle: true,
      ),
      body: SafeArea(
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
              Text(
                event.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Divider(height: 32),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => controller.addAttendanceInfo(
                    event,
                    loginState.uid,
                  ),
                  // onPressed: () async {
                  //   await FirebaseFirestore.instance
                  //       .collection('absences')
                  //       .add({
                  //     // 'scheduleId': scheduleId,
                  //     // 'title': title,
                  //     // 'start': startTime,
                  //     // 'end': endTime,
                  //     // 'createdAt': DateTime.now(),
                  //   });

                  //   if (context.mounted) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('欠席を登録しました')),
                  //     );
                  //   }
                  // },
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.whitesmoke,
                  ),
                  label: const Text('欠席する'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.whitesmoke,
                    backgroundColor: AppColors.firebrick,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
