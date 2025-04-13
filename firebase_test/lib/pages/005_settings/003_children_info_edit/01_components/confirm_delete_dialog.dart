import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final ChildrenInfoEditController controller;
  final int index;

  const ConfirmDeleteDialog(
      {super.key, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("確認"),
      content: const Text("削除する情報を確認してください。"),
      actions: [
        ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text("キャンセル"),
        ),
        ElevatedButton(
          onPressed: () async {
            await controller.deleteChildInfo(index);
            Navigator.of(context).pop();
            controller.fetchChildrenInfo();
          },
          child: const Text("削除"),
        )
      ],
    );
  }
}
