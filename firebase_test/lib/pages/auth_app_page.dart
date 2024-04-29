import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../models/auth_app_page_provider.dart';

class AuthAppPage extends ConsumerWidget {
  const AuthAppPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authAppPageProvider);
    // 画面幅を取得
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Center(
            widthFactor: screenWidth * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // メールアドレス入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'メールアドレス'),
                  onChanged: (String value) {
                    // setState(() {
                    //   email = value;
                    // });
                  },
                ),
                // パスワード入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    // setState(() {
                    //   password = value;
                    // });
                  },
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  // メッセージ表示
                  // child: Text(infoText),
                ),
                Container(
                  width: double.infinity,
                  // ユーザー登録ボタン
                  child: ElevatedButton(
                    child: Text('ユーザー登録'),
                    onPressed: () async {
                      // try {
                      //   // メール/パスワードでユーザー登録
                      //   final FirebaseAuth auth = FirebaseAuth.instance;
                      //   await auth.createUserWithEmailAndPassword(
                      //     email: email,
                      //     password: password,
                      //   );
                      //   // ユーザー登録に成功した場合
                      //   // チャット画面に遷移＋ログイン画面を破棄
                      //   await Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(builder: (context) {
                      //       return ChatPage();
                      //     }),
                      //   );
                      // } catch (e) {
                      // ユーザー登録に失敗した場合
                      // setState(() {
                      //   infoText = "登録に失敗しました：${e.toString()}";
                      // });
                      // }
                    },
                  ),
                )
                // Text(
                //   'OREFFERENCES ACCESS.',
                //   style: TextStyle(
                //     fontSize: 32,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // const Gap(10),
                // Text(
                //   state.text,
                //   style: TextStyle(fontSize: 24),
                // ),
                // const Gap(10),
                // ElevatedButton(
                //   onPressed: () =>
                //       ref.read(authAppPageProvider.notifier).fire(),
                //   child: const Text('Button'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
