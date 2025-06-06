import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/models/controller/login/login_controller.dart';
import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/add_child_info.dart';
import 'package:firebase_test/pages/005_settings/003_children_info_edit/edit_child_info.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddChildInfoPage extends HookConsumerWidget {
  const AddChildInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoState state = ref.watch(childrenInfoEditProvider);
    final ChildrenInfoController controller =
        ref.watch(childrenInfoEditProvider.notifier);
    final LoginState loginState = ref.watch(loginProvider);

    useEffect(() {
      controller.fetchChildrenInfo();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('お子様情報追加'),
      ),
      body: SafeArea(
        child: AddChildInfo(
          uid: loginState.uid,
          childrenInfoController: controller,
        ),
      ),
    );
  }
}
