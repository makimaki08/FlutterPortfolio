import 'package:firebase_test/models/controller/login/login_state.dart';
import 'package:firebase_test/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/controller/login/login_controller.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // コントローラ（hooksで再生成を防ぐ）
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // UI用の状態
    final showPassword = useState(false);
    final isSubmitting = useState(false);

    // 状態・コントローラ
    final loginController = ref.watch(loginProvider.notifier);

    Future<void> handleLogin() async {
      FocusScope.of(context).unfocus();
      if (isSubmitting.value) return;
      isSubmitting.value = true;
      try {
        await loginController.login(
          "login_address@test.com",
          // emailController.text.trim(),
          "Password1234",
          // passwordController.text,
        );
        final state = ref.read(loginProvider);
        if (state.isAuth) {
          if (context.mounted) context.go('/home');
        } else {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('エラー'),
                content: Text('ログインに失敗しました。\nもう一度お試しください。'),
              ),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('ログインに失敗: $e')),
          );
        }
      } finally {
        isSubmitting.value = false;
      }
    }

    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final isWide = media.size.width >= 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Firebase_Auto_app')),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(
                    top: 24,
                    bottom: 24 + media.viewInsets.bottom, // キーボード分の余白
                  ),
                  child: Card(
                    elevation: isWide ? 2 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AutofillGroup(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ログイン',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(20),

                            // メール
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'メールアドレス',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [
                                AutofillHints.username,
                                AutofillHints.email
                              ],
                              validator: ValidateText().emailValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            const Gap(12),

                            // パスワード
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'パスワード',
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      showPassword.value = !showPassword.value,
                                  tooltip: showPassword.value ? '非表示' : '表示',
                                ),
                              ),
                              obscureText: !showPassword.value,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => handleLogin(),
                              validator: ValidateText().passwordValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofillHints: const [AutofillHints.password],
                            ),
                            const Gap(20),

                            // ログインボタン
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.login),
                                label: isSubmitting.value
                                    ? const Text('処理中...')
                                    : const Text('ログイン'),
                                onPressed:
                                    isSubmitting.value ? null : handleLogin,
                              ),
                            ),
                            const Gap(12),

                            // 新規登録
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.person_add_alt),
                                label: const Text('新規登録'),
                                onPressed: isSubmitting.value
                                    ? null
                                    : () => context.push('/registration'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
