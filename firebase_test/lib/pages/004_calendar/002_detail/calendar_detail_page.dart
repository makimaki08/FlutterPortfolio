import 'package:firebase_test/pages/999_other/event/calendar_event.dart';
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
        children: [
          Text(event.id),
          const Gap(12),
          Text(event.description),
        ],
      )),
    );
  }
}
