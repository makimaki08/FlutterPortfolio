import 'package:firebase_test/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/controller/registration/registration_controller.dart';

class RegistrationPage extends HookConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationController = ref.watch(registrationProvider.notifier);

    // Controllers
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmController = useTextEditingController();

    // UI state
    final showPassword = useState(false);
    final showConfirm = useState(false);
    final isSubmitting = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    Future<void> handleRegister() async {
      FocusScope.of(context).unfocus();
      if (isSubmitting.value) return;
      if (!(formKey.currentState?.validate() ?? false)) return;

      isSubmitting.value = true;
      try {
        await registrationController.register(
          emailController.text.trim(),
          passwordController.text,
        );
        if (context.mounted) context.go('/home');
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('新規登録に失敗: $e')),
          );
        }
      } finally {
        isSubmitting.value = false;
      }
    }

    final media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('新規登録')),
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
                    bottom: 24 + media.viewInsets.bottom,
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: AutofillGroup(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'アカウント作成',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),

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
                              const SizedBox(height: 12),

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
                                    onPressed: () => showPassword.value =
                                        !showPassword.value,
                                    tooltip: showPassword.value ? '非表示' : '表示',
                                  ),
                                ),
                                obscureText: !showPassword.value,
                                textInputAction: TextInputAction.next,
                                validator: ValidateText().passwordValidator,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofillHints: const [
                                  AutofillHints.newPassword
                                ],
                              ),
                              const SizedBox(height: 12),

                              // パスワード（確認）
                              TextFormField(
                                controller: confirmController,
                                decoration: InputDecoration(
                                  labelText: 'パスワード（確認）',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      showConfirm.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () =>
                                        showConfirm.value = !showConfirm.value,
                                    tooltip: showConfirm.value ? '非表示' : '表示',
                                  ),
                                ),
                                obscureText: !showConfirm.value,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => handleRegister(),
                                validator: (v) {
                                  if ((v ?? '').isEmpty)
                                    return '確認用パスワードを入力してください';
                                  if (v != passwordController.text)
                                    return 'パスワードが一致しません';
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofillHints: const [AutofillHints.password],
                              ),
                              const SizedBox(height: 20),

                              // 新規登録
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.person_add_alt),
                                  label: isSubmitting.value
                                      ? const Text('作成中...')
                                      : const Text('新規登録'),
                                  onPressed: isSubmitting.value
                                      ? null
                                      : handleRegister,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // ログインへ
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.login),
                                  label: const Text('ログインに戻る'),
                                  onPressed: isSubmitting.value
                                      ? null
                                      : () => context.pop(),
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
      ),
    );
  }
}
