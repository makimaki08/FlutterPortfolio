import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/s1.dart';

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s1 =
        ref.watch(s1NotifierProvider); // refを利用して、s1NotifierProviderをWatch
    return Text('$s1');
  }
}
