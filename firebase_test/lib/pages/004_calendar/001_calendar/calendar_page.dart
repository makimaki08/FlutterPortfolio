import 'package:firebase_test/models/controller/calendar/calendar_controller.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:flutter/material.dart';
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
          itemBuilder: (context, index) {
            return asyncValue.when(
              data: (calendarEvent) {
                final event = calendarEvent[index];
                if (event.duration != null) {
                  return Card(
                    child: ListTile(
                      title: Text('''${event.duration}\n${event.summary}'''),
                      onTap: () => context.go(
                        '/calendar/detail',
                        extra: event,
                      ),
                    ),
                  );
                }
                ;
              },
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => const CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () => ref.refresh(calendarProvider),
        icon: const Icon(Icons.replay_outlined),
      ),
    );
  }
}
