import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Detail"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // 画面に余白を追加
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalendarEventCard(event: event),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       // TODO: ユーザー紐付けの処理をあとで直す
              //       FirebaseFirestore.instance.collection('collectionPath').add(
              //         {
              //           'id': event.id,
              //           'summary': event.summary,
              //           'description': event.description,
              //           'start': event.start,
              //           'end': event.end,
              //           'duration': event.duration,
              //         },
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.deepPurple,
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     icon: const Icon(Icons.cancel),
              //     label: const Text(
              //       "欠席登録",
              //       style: TextStyle(fontSize: 16),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
