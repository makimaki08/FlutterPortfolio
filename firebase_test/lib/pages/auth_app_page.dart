import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../models/auth_app_page_provider.dart';

class AuthAppPage extends ConsumerWidget {
  const AuthAppPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authAppPageProvider);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'OREFFERENCES ACCESS.',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(10),
              Text(
                state.text,
                style: TextStyle(fontSize: 24),
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () => ref.read(authAppPageProvider.notifier).fire(),
                child: const Text('Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
