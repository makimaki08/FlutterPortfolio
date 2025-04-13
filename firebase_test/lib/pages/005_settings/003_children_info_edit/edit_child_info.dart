import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/models/entities/children_info/gender_enum.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/01_components/confirm_delete_dialog.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditChildInfo extends StatelessWidget {
  EditChildInfo({
    super.key,
    required this.state,
    required this.controller,
  });
  final ChildrenInfoEditState state;
  final ChildrenInfoEditController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.children.length,
      itemBuilder: (context, index) {
        return EditChild(context, index, controller, state.children[index]);
      },
    );
  }

  Widget EditChild(
    BuildContext context,
    int index,
    ChildrenInfoEditController controller,
    ChildInfoState state,
  ) {
    final nameController = TextEditingController(text: state.name);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /// TOP
            Container(
              padding: const EdgeInsets.only(bottom: 4.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: AppColors.darkgray,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(nameController.text),
                  Row(
                    children: [
                      Visibility(
                        visible: state.isEditable,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.updateIsEditable(index, false);
                          },
                          child: const Text("取消"),
                        ),
                      ),
                      Visibility(
                        visible: !state.isEditable,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.updateIsEditable(index, true);
                          },
                          child: const Text("編集"),
                        ),
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmDeleteDialog(
                                index: index, controller: controller),
                          );
                        },
                        child: const Text("削除"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Gap(8.0),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 名前
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("名前"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: state.isEditable
                              ? TextFormField(
                                  controller: nameController,
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode: AutovalidateMode.onUnfocus,
                                  decoration: const InputDecoration(
                                    hintText: '例：田中太郎',
                                    border: InputBorder.none,
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      nameController.text,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const Gap(16),

                    /// 性別
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("性別"),
                        ),
                        state.isEditable
                            ? Row(
                                children: [
                                  Flexible(
                                    child: RadioListTile(
                                      title: const Text('男'),
                                      value: Gender.man.value,
                                      groupValue: state.gender,
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.updateChildGender(
                                              index, value);
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
                                          controller.updateChildGender(
                                              index, value);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 8.0,
                                  ),
                                  child: Text(
                                    state.gender == 1 ? "男" : "女",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const Gap(16),

                    /// 年齢
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("年齢"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: state.isEditable
                              ? DropdownButton(
                                  items: List.generate(10, (index) {
                                    final age = 6 + index;
                                    return DropdownMenuItem(
                                      value: age,
                                      child: Text('$age歳'),
                                    );
                                  }),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.updateChildAge(index, value);
                                    }
                                  },
                                  value: state.age,
                                )
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "${state.age}歳",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),

                    /// 送信ボタン
                    Visibility(
                      visible: state.isEditable,
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            final uploadValue = ChildInfoState(
                              name: nameController.text,
                              gender: state.gender,
                              age: state.age,
                              isEditable: false,
                            );
                            controller.updateChildInfo(index, uploadValue);
                          },
                          child: const Text('更新'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
