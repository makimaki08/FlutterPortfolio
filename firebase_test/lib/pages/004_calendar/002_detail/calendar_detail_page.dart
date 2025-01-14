import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Detail"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(event.summary),
            const Gap(12),
            Text(event.duration.toString()),
            const Gap(40),
            ElevatedButton(
              onPressed: () {
                // TODO: 下記で登録できるようになったが、ユーザーと紐付けがうまくできていない。
                FirebaseFirestore.instance.collection('collectionPath').add(
                  {
                    'id': event.id,
                    'summary': event.summary,
                    'description': event.description,
                    'start': event.start,
                    'end': event.end,
                    'duration': event.duration,
                  },
                );
              },
              child: const Text("欠席登録"),
            ),
          ],
        ),
      ),
    );
  }
}
