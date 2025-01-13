import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:flutter/material.dart';

class ChildrenInfoName extends StatelessWidget {
  const ChildrenInfoName({
    super.key,
    required this.nameController,
  });
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("名前"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUnfocus,
            decoration: const InputDecoration(
              hintText: '例：田中太郎',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
