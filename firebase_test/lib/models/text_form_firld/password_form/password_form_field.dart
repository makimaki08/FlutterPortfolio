import 'package:firebase_test/models/text_form_firld/password_form/password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordFormField extends HookConsumerWidget {
  const PasswordFormField({
    super.key,
    required this.controller,
  });

  final controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(passwordViewModelProvider.notifier);
    final state = ref.watch(passwordViewModelProvider);

    return TextFormField(
      controller: controller,
      obscureText: !state.isVisible,
      decoration: InputDecoration(
        labelText: "パスワード",
        suffixIcon: IconButton(
          onPressed: () {
            viewModel.toggleVisibility();
          },
          icon: Icon(state.isVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
