import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info/children_info_controller.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/models/controller/home/home_controller.dart';
import 'package:firebase_test/style/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  // ログイン中userの情報取得
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChildrenInfoState state = ref.watch(childrenInfoEditProvider);
    final ChildrenInfoController controller =
        ref.watch(childrenInfoEditProvider.notifier);

    useEffect(() {
      controller.fetchChildrenInfo();
      return null;
    }, const []);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ホーム'),
        ),
        body: SafeArea(
            child: (!state.haveRegistration)
                ? Container(
                    alignment: Alignment.center,
                    child: const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                            "お子様の情報が登録されていません。\n設定タブから、お子様の情報を新規追加してください。")),
                  )
                : ListView.builder(
                    itemCount: state.children.length,
                    itemBuilder: (context, index) {
                      return Tmp(state.children[index]);
                    },
                  )),
      ),
    );
  }
}

Widget Tmp(
  ChildInfoState state,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 16.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            child: Text(state.name ?? ''),
          ),
          const Gap(8.0),

          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2025/04/28'),
                  Gap(4),
                  Text('男女4~6年'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
