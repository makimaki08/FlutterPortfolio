import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/models/entities/children_info/gender_enum.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/children_widgets/children_info_age.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/children_widgets/children_info_gender.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/children_widgets/children_info_name.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChildrenInfoEditPage extends HookConsumerWidget {
  const ChildrenInfoEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoEditState childrenInfoEditState =
        ref.watch(childrenInfoEditProvider);
    final ChildrenInfoEditController childrenInfoEditController =
        ref.watch(childrenInfoEditProvider.notifier);
    final LoginState loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('お子様情報変更'),
      ),
      body: SafeArea(
          child: (!childrenInfoEditState.haveRegistration)
              ? AddInformation(
                  state: childrenInfoEditState,
                  controller: childrenInfoEditController,
                  uid: loginState.uid,
                )
              : ChangeInformation(
                  name: '田中太郎',
                  state: childrenInfoEditState,
                  controller: childrenInfoEditController,
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.burlywood,
        onPressed: () => childrenInfoEditController.addNewChild,
        child: const Icon(Icons.add_sharp),
      ),
    );
  }
}

class AddInformation extends StatelessWidget {
  AddInformation({
    super.key,
    required this.state,
    required this.controller,
    required this.uid,
  });
  final ChildrenInfoEditState state;
  final ChildrenInfoEditController controller;
  final String uid;

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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('お子様の情報を登録してください'),
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
                    ChildrenInfoName(nameController: nameController),
                    const Gap(16),

                    /// 性別
                    ChildrenInfoGender(state: state, controller: controller),
                    const Gap(16),

                    /// 年齢
                    ChildrenInfoAge(state: state, controller: controller),

                    /// 送信ボタン
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        // TODO: 登録できるようになったが、押下しただけだと反応がない
                        // 登録が本当にできたかわかるようにUIを修正する
                        onPressed: () =>
                            controller.addNewChild(uid, nameController.text),
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

class ChangeInformation extends StatelessWidget {
  ChangeInformation({
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
                    ChildrenInfoName(nameController: nameController),
                    const Gap(16),

                    /// 性別
                    ChildrenInfoGender(state: state, controller: controller),
                    const Gap(16),

                    /// 年齢
                    ChildrenInfoAge(state: state, controller: controller),

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
