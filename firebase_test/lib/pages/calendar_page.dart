import 'dart:math';

import 'package:firebase_test/models/controller/calendar/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarPage extends HookConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsyncValue = ref.watch(calendarProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: SafeArea(
        child: eventsAsyncValue.when(
          data: (events) {
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event.summary),
                  // リストタイル押下時の処理
                  onTap: () {},
                );
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: ((error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'エラーが発生しました: $error',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(calendarProvider),
                      child: const Text('リロード'),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
