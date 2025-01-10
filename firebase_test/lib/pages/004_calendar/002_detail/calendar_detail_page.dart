import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            Text(event.id),
            const Gap(12),
            Text(event.description),
            const Gap(40),
            ElevatedButton(
              // TODO: ボタン押下で、このイベントに対して欠席情報を登録できるようにする
              onPressed: () {},
              child: const Text("欠席登録"),
            ),
          ],
        ),
      ),
    );
  }
}
