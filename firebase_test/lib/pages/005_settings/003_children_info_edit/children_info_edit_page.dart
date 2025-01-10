import 'package:firebase_test/models/controller/calendar/calendar_controller.dart';
import 'package:firebase_test/models/entities/event/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChildrenInfoEditPage extends HookConsumerWidget {
  const ChildrenInfoEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お子様情報変更'),
      ),
      body: const SafeArea(
        child: Text("TEST"),
      ),
    );
  }
}
