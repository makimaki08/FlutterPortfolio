import 'package:firebase_test/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class MailPasswordEditPage extends ConsumerWidget {
  const MailPasswordEditPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: ダミーで利用している固定値を設定しているため、Firebaseに登録しているアドレスとパスワードを表示させるようにする。
    /* --- コントローラー --- */
    /// ユーザーID
    TextEditingController inputEmailController =
        TextEditingController(text: 'login_address@test.com');

    /// パスワード
    TextEditingController inputPasswordController =
        TextEditingController(text: 'Password1234');

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント情報変更')),
      body: SafeArea(
        child: Center(
          child: Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // メールアドレス入力
                  TextFormField(
                    controller: inputEmailController,
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    textInputAction: TextInputAction.next,
                    validator: ValidateText().emailValidator,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                  ),
                  const Gap(8),

                  // パスワード入力
                  TextFormField(
                    controller: inputPasswordController,
                    decoration: const InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                    validator: ValidateText().passwordValidator,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                  ),
                  const Gap(16),

                  // 送信ボタン
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('送信'),
                      // TODO: 送信ボタン押下時に、メールアドレスとパスワードを記載された内容で更新する処理を追加
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
