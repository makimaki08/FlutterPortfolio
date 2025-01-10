import 'package:firebase_test/models/controller/calendar/calendar_controller.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarPage extends HookConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(calendarProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: asyncValue.value?.length,
          itemBuilder: (context, index) {
            return asyncValue.when(
              data: (calendarEvent) {
                if (calendarEvent.isEmpty) {
                  return const Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sports_basketball),
                        Gap(4),
                        Text("データが取得できませんでした")
                      ],
                    ),
                  );
                }
                final event = calendarEvent[index];
                return Card(
                  child: ListTile(
                    title: Text('''${event.duration}\n${event.summary}'''),
                    onTap: () => context.go(
                      '/calendar/detail',
                      extra: event,
                    ),
                  ),
                );
              },
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.burlywood,
        onPressed: () => ref.refresh(calendarProvider),
        child: const Icon(Icons.replay_outlined),
      ),
    );
  }
}
