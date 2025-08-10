import 'package:firebase_test/models/controller/child_info/child_info_controller.dart';
import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/models/entities/children_info/gender_enum.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';

class AddChildInfo extends HookConsumerWidget {
  AddChildInfo({
    super.key,
    required this.uid,
    required this.childrenInfoController,
  });
  final String uid;
  final nameController = TextEditingController();
  final ChildrenInfoController childrenInfoController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildInfoState state = ref.watch(childInfoProvider);
    final ChildInfoController childInfoController =
        ref.watch(childInfoProvider.notifier);

    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'お子様の情報を登録してください',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 名前
                      Text.rich(
                        TextSpan(
                          text: "お子様のお名前",
                          children: [
                            TextSpan(
                                text: " *",
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: '例：田中太郎',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? '名前を入力してください'
                            : null,
                        textInputAction: TextInputAction.next,
                      ),
                      const Gap(20),

                      // 性別
                      Text.rich(
                        TextSpan(
                          text: "性別",
                          children: [
                            TextSpan(
                                text: " *",
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.male, color: Colors.blue),
                              label: Text('男の子'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    state.gender == Gender.man.value
                                        ? Colors.blue[100]
                                        : Colors.white,
                                foregroundColor: Colors.black,
                                side: BorderSide(color: Colors.blue),
                              ),
                              onPressed: () => childInfoController
                                  .onChangedGender(Gender.man.value),
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.female, color: Colors.pink),
                              label: Text('女の子'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    state.gender == Gender.woman.value
                                        ? Colors.pink[100]
                                        : Colors.white,
                                foregroundColor: Colors.black,
                                side: BorderSide(color: Colors.pink),
                              ),
                              onPressed: () => childInfoController
                                  .onChangedGender(Gender.woman.value),
                            ),
                          ),
                        ],
                      ),
                      if (state.gender == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text('性別を選択してください',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                        ),
                      const Gap(20),

                      // 年齢
                      Text.rich(
                        TextSpan(
                          text: "年齢",
                          children: [
                            TextSpan(
                                text: " *",
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        hint: Text('年齢を選択してください'),
                        items: List.generate(10, (index) {
                          final age = 6 + index;
                          return DropdownMenuItem(
                            value: age,
                            child: Text('$age歳'),
                          );
                        }),
                        value: state.age,
                        onChanged: (value) {
                          if (value != null) {
                            childInfoController.onChangedAge(value);
                          }
                        },
                        validator: (v) => v == null ? '年齢を選択してください' : null,
                      ),
                      const Gap(32),

                      // 送信ボタン
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.save, color: Colors.white),
                          label: Text('登録する', style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            if (formKey.currentState?.validate() != true ||
                                state.gender == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('未入力項目があります')),
                              );
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('内容を確認してください'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('名前：${nameController.text}'),
                                      Text(
                                          '性別：${state.gender == 1 ? "男の子" : "女の子"}'),
                                      Text('年齢：${state.age}歳'),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        final value = ChildInfoState(
                                          name: nameController.text,
                                          gender: state.gender,
                                          age: state.age,
                                        );
                                        await childrenInfoController
                                            .addNewChild(uid, value);
                                        Navigator.of(context).pop();
                                        context.pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text('登録が完了しました')),
                                        );
                                      },
                                      child: Text('登録する'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('キャンセル'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
