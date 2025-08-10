import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
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
  final ChildrenInfoState state;
  final ChildrenInfoController controller;

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
    ChildrenInfoController controller,
    ChildInfoState state,
  ) {
    final nameController = TextEditingController(text: state.name);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // タイトルと操作ボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nameController.text,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: state.isEditable,
                        child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.orange),
                          tooltip: "取消",
                          onPressed: () =>
                              controller.updateIsEditable(index, false),
                        ),
                      ),
                      Visibility(
                        visible: !state.isEditable,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          tooltip: "編集",
                          onPressed: () =>
                              controller.updateIsEditable(index, true),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        tooltip: "削除",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmDeleteDialog(
                              index: index,
                              controller: controller,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(8.0),

              // 名前
              Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: "お子様のお名前",
                    children: [
                      TextSpan(text: " *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4),
              state.isEditable
                  ? TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: '例：田中太郎',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? '名前を入力してください'
                          : null,
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
              const Gap(16),

              // 性別
              Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: "性別",
                    children: [
                      TextSpan(text: " *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4),
              state.isEditable
                  ? Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.male, color: Colors.blue),
                            label: Text('男の子'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.gender == Gender.man.value
                                  ? Colors.blue[100]
                                  : Colors.white,
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () => controller.updateChildGender(
                                index, Gender.man.value),
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
                            onPressed: () => controller.updateChildGender(
                                index, Gender.woman.value),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          state.gender == 1 ? "男の子" : "女の子",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
              const Gap(16),

              // 年齢
              Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: "年齢",
                    children: [
                      TextSpan(text: " *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4),
              state.isEditable
                  ? DropdownButtonFormField<int>(
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
                          controller.updateChildAge(index, value);
                        }
                      },
                      validator: (v) => v == null ? '年齢を選択してください' : null,
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
              const Gap(32),

              // 更新ボタン
              Visibility(
                visible: state.isEditable,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text('更新する', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      final uploadValue = ChildInfoState(
                        name: nameController.text,
                        gender: state.gender,
                        age: state.age,
                        isEditable: false,
                      );
                      controller.updateChildInfo(index, uploadValue);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('更新が完了しました')),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
