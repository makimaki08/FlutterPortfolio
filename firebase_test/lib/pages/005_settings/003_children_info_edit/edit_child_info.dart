import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/models/entities/children_info/gender_enum.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditChildInfo extends StatelessWidget {
  EditChildInfo({
    super.key,
    required this.name,
    required this.state,
    required this.controller,
  });
  final String name;
  final ChildrenInfoEditState state;
  final ChildrenInfoEditController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.children.length,
      itemBuilder: (context, index) {
        return EditChild(state.children[index]);
      },
    );
  }

  Widget EditChild(ChildInfoState state) {
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
                  Text(name),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("削除"),
                  )
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
                          child: TextFormField(
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            decoration: InputDecoration(
                              hintText: '例：田中太郎',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),

                    /// 性別
                    //FIXME: stateの持ち方直す。。
                    // このままだとstateは子供単体しか見ておらず、複数名の子供Stateに対して、正しく修正をすることができない。
                    // Column(
                    //   children: [
                    //     const Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Text("性別"),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Flexible(
                    //           child: RadioListTile(
                    //             title: const Text('男'),
                    //             value: Gender.man.value,
                    //             groupValue: state.gender,
                    //             onChanged: (value) {
                    //               if (value != null) {
                    //                 childInfoController
                    //                     .onChangedGender(Gender.man.value);
                    //               }
                    //             },
                    //           ),
                    //         ),
                    //         Flexible(
                    //           child: RadioListTile(
                    //             title: const Text('女'),
                    //             value: Gender.woman.value,
                    //             groupValue: state.gender,
                    //             onChanged: (value) {
                    //               if (value != null) {
                    //                 childInfoController
                    //                     .onChangedGender(Gender.woman.value);
                    //               }
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    const Gap(16),

                    /// 年齢
                    // ChildrenInfoAge(state: state, controller: controller),

                    /// 送信ボタン
                    //　TODO: 新規追加のWidgetとは別で、更新する処理を追加する
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('送信'),
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
