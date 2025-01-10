import 'package:firebase_test/models/controller/calendar/calendar_controller.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarPage extends HookConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: sampleEvents.length,
          itemBuilder: (context, index) {
            final event = sampleEvents[index];
            return ListTile(
              title: Text(event.id),
              // リストタイル押下時の処理
              onTap: () => context.go(
                '/calendar/detail',
                extra: event,
              ),
            );
          },
        ),
      ),
    );
  }
}

// TODO: Demo用のイベントのため、APIから情報を取得できるようになれば削除
final List<CalendarEvent> sampleEvents = [
  CalendarEvent(
    id: 'event1',
    description: 'Team meeting to discuss project updates.',
    start: DateTime(2025, 1, 10, 10, 0), // 2025-01-10 10:00 AM
    end: DateTime(2025, 1, 10, 11, 0), // 2025-01-10 11:00 AM
    summary: 'Project Update Meeting',
  ),
  CalendarEvent(
    id: 'event2',
    description: 'Planning session for the next sprint.',
    start: DateTime(2025, 1, 11, 14, 0), // 2025-01-11 2:00 PM
    end: DateTime(2025, 1, 11, 15, 30), // 2025-01-11 3:30 PM
    summary: 'Sprint Planning',
  ),
  CalendarEvent(
    id: 'event3',
    description: 'Review of current design prototypes.',
    start: DateTime(2025, 1, 12, 9, 30), // 2025-01-12 9:30 AM
    end: DateTime(2025, 1, 12, 10, 30), // 2025-01-12 10:30 AM
    summary: 'Design Review',
  ),
  CalendarEvent(
    id: 'event4',
    description: 'Monthly sync-up with the entire team.',
    start: DateTime(2025, 1, 15, 16, 0), // 2025-01-15 4:00 PM
    end: DateTime(2025, 1, 15, 17, 0), // 2025-01-15 5:00 PM
    summary: 'Monthly Team Sync',
  ),
  CalendarEvent(
    id: 'event5',
    description: 'Presentation for the client about the new product launch.',
    start: DateTime(2025, 1, 20, 13, 0), // 2025-01-20 1:00 PM
    end: DateTime(2025, 1, 20, 14, 0), // 2025-01-20 2:00 PM
    summary: 'Client Presentation',
  ),
];
