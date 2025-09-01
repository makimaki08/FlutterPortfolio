import 'package:firebase_test/models/controller/child_info/child_info_controller.dart';
import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
    final now = DateTime.now();
    final nowYear = now.year;

    // 追加: 選択した生年月日を保持
    final birthDate = useState<DateTime?>(null);
    final df = DateFormat('yyyy/MM/dd');

    // 既存ageのみから推測できるのは「年」まで
    final selectedBirthYear =
        (state.age != null && state.age! > 0) ? nowYear - state.age! : null;

    int calcAge(DateTime birth, DateTime today) {
      var age = today.year - birth.year;
      if (DateTime(today.year, birth.month, birth.day).isAfter(today)) {
        age -= 1;
      }
      return age;
    }

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

                      // 年齢 -> 生年月日（yyyy/MM/dd 表示）に変更
                      Text.rich(
                        TextSpan(
                          text: "生年月日",
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
                      GestureDetector(
                        onTap: () async {
                          final initial = birthDate.value ??
                              DateTime(
                                  selectedBirthYear ?? (nowYear - 10), 1, 1);
                          final first = DateTime(nowYear - 30, 1, 1);
                          final last = DateTime(nowYear, 12, 31);
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: initial,
                            firstDate: first,
                            lastDate: last,
                            initialDatePickerMode: DatePickerMode.year,
                            helpText: '生年月日を選択',
                            cancelText: 'キャンセル',
                            confirmText: '決定',
                          );
                          if (picked != null) {
                            birthDate.value = picked;
                            childInfoController
                                .onChangedAge(calcAge(picked, now));
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              hintText: '生年月日を選択してください（例：2000/02/01）',
                            ),
                            controller: TextEditingController(
                              text: birthDate.value != null
                                  ? df.format(birthDate.value!)
                                  : (selectedBirthYear != null
                                      ? '$selectedBirthYear/01/01'
                                      : ''),
                            ),
                            validator: (_) => birthDate.value == null
                                ? '生年月日を選択してください'
                                : null,
                          ),
                        ),
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
                                state.age == null ||
                                birthDate.value == null) {
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
                                          '生年月日：${df.format(birthDate.value!)}'),
                                      Text('年齢：${state.age}歳'),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        final value = ChildInfoState(
                                          name: nameController.text,
                                          age: state.age, // 保存は従来通り age のみ
                                        );
                                        await childrenInfoController
                                            .addNewChild(uid, value);
                                        Navigator.of(context).pop();
                                        context.pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text('登録が完了しました')));
                                      },
                                      child: const Text('登録する'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('キャンセル'),
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
