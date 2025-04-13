import 'package:firebase_test/models/controller/child_info/child_info_controller.dart';
import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/models/entities/children_info/gender_enum.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddChildInfo extends HookConsumerWidget {
  AddChildInfo({
    super.key,
    required this.uid,
    required this.childrenInfoEditController,
  });
  final String uid;

  final nameController = TextEditingController();
  final ChildrenInfoEditController childrenInfoEditController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildInfoState state = ref.watch(childInfoProvider);
    final ChildInfoController childInfoController =
        ref.watch(childInfoProvider.notifier);

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
                            decoration: const InputDecoration(
                              hintText: '例：田中太郎',
                              border: InputBorder.none,
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
                        Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                title: const Text('男'),
                                value: Gender.man.value,
                                groupValue: state.gender,
                                onChanged: (value) {
                                  if (value != null) {
                                    childInfoController
                                        .onChangedGender(Gender.man.value);
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
                                    childInfoController
                                        .onChangedGender(Gender.woman.value);
                                  }
                                },
                              ),
                            ),
                          ],
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
                                childInfoController.onChangedAge(value);
                              }
                            },
                            value: state.age,
                          ),
                        ),
                      ],
                    ),

                    /// 送信ボタン
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('内容を確認してください'),
                                  content: SizedBox(
                                    height: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('名前：${nameController.text}'),
                                          Text('性別：${state.gender}'),
                                          Text('年齢：${state.age}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (state.gender != null &&
                                            state.age != null) {
                                          final value = ChildInfoState(
                                            name: nameController.text,
                                            gender: state.gender,
                                            age: state.age,
                                          );
                                          await childrenInfoEditController
                                              .addNewChild(
                                            uid,
                                            value,
                                          );
                                        }
                                        Navigator.of(context).pop();
                                        context.pop();
                                      },
                                      child: const Text('送信'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('キャンセル'),
                                    ),
                                  ],
                                );
                              });
                        },
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
