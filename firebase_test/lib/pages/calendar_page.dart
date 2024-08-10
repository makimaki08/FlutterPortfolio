import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/calendar/calendar_controller.dart';
import 'package:firebase_test/repositories/secure_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarPage extends HookConsumerWidget {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsyncValue = ref.watch(calendarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
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
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: ((error, stackTrace) => Center(
                child: Text('Error: $error'),
              )),
        ),
      ),
    );
  }
}
