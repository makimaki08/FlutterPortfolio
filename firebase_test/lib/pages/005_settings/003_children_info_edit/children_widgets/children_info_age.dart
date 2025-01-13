import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:flutter/material.dart';

class ChildrenInfoAge extends StatelessWidget {
  const ChildrenInfoAge({
    super.key,
    required this.state,
    required this.controller,
  });
  final ChildrenInfoEditState state;
  final ChildrenInfoEditController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("年齢"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton(
            items: List.generate(10, (index) {
              final age = 6 + index;
              return DropdownMenuItem(
                value: age,
                child: Text('$age歳'),
              );
            }),
            onChanged: (value) {
              if (value != null) {
                controller.onChangedAge(value);
              }
            },
            value: state.age,
          ),
        ),
      ],
    );
  }
}
