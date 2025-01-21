import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
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

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    // ChildrenInfoName(nameController: nameController),
                    const Gap(16),

                    /// 性別
                    // ChildrenInfoGender(state: state, controller: controller),
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
