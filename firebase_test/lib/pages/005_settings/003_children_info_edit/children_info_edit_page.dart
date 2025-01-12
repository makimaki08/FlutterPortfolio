import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChildrenInfoEditPage extends HookConsumerWidget {
  const ChildrenInfoEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childrenInfoEditState = ref.watch(childrenInfoEditProvider);
    final childrenInfoEditController =
        ref.watch(childrenInfoEditProvider.notifier);
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('お子様情報変更'),
      ),
      body: SafeArea(
          child: (childrenInfoEditState.haveRegistration)
              ? const InPut(
                  name: '田中太郎',
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Card(
                    child: Container(
                      color: AppColors.darkgray,
                      height: 200,
                      width: 300,
                      child: const Center(
                        child: Text(
                          "登録されている情報がありません",
                          style: TextStyle(color: AppColors.whitesmoke),
                        ),
                      ),
                    ),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.burlywood,
        onPressed: () => childrenInfoEditController.addNewChild,
        child: const Icon(Icons.add_sharp),
      ),
    );
  }
}

// TODO: 名前は後でかえる
class InPut extends StatelessWidget {
  final String name;
  const InPut({
    super.key,
    required this.name,
  });

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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("名前"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('田中太郎'),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                      ),
                    ),
                    const Gap(16),

                    /// 性別
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("性別"),
                    ),
                    Row(
                      children: [
                        /// 男
                        Radio(
                          value: 0,
                          groupValue: 1,
                          onChanged: (value) {},
                        ),
                        const Gap(4),
                        const Text('男'),

                        /// 女
                        Radio(
                          value: 0,
                          groupValue: 1,
                          onChanged: (value) {},
                        ),
                        const Gap(4),
                        const Text('女'),
                      ],
                    ),
                    const Gap(16),

                    /// 年齢
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("年齢"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            value: 10,
                            child: Text('10歳'),
                          ),
                          DropdownMenuItem(
                            value: 11,
                            child: Text('11歳'),
                          ),
                        ],
                        onChanged: (value) {},
                        value: 11,
                      ),
                    ),

                    /// 送信ボタン
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
