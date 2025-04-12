import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/add_child_info.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/edit_child_info.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChildrenInfoEditPage extends HookConsumerWidget {
  const ChildrenInfoEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoEditState state = ref.watch(childrenInfoEditProvider);
    final ChildrenInfoEditController controller =
        ref.watch(childrenInfoEditProvider.notifier);
    final LoginState loginState = ref.watch(loginProvider);

    useEffect(() {
      controller.fetchChildrenInfo();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('お子様情報変更'),
      ),
      body: SafeArea(
          child: (!state.haveRegistration)
              ? AddChildInfo(
                  uid: loginState.uid,
                  childrenInfoEditController: controller,
                )
              : EditChildInfo(
                  state: state,
                  controller: controller,
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.burlywood,
        // TODO:新規追加ようの動線追加
        onPressed: () => controller.fetchChildrenInfo(),
        child: const Icon(Icons.add_sharp),
      ),
    );
  }
}
