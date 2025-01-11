import 'package:flutter/material.dart';
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
