import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/models/entities/children_info/gender_enum.dart';
import 'package:flutter/material.dart';

class ChildrenInfoGender extends StatelessWidget {
  const ChildrenInfoGender({
    super.key,
    required this.state,
    required this.controller,
  });
  final ChildrenInfoEditState state;
  final ChildrenInfoEditController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("性別"),
        ),
        Row(
          children: [
            Flexible(
              child: RadioListTile(
                title: const Text('男'),
                value: Gender.man.value,
                groupValue: state.gender,
                onChanged: (value) {
                  if (value != null) {
                    controller.onChangedGender(Gender.man.value);
                  }
                },
              ),
            ),
            Flexible(
              child: RadioListTile(
                title: const Text('女'),
                value: Gender.woman.value,
                groupValue: state.gender,
                onChanged: (value) {
                  if (value != null) {
                    controller.onChangedGender(Gender.woman.value);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
