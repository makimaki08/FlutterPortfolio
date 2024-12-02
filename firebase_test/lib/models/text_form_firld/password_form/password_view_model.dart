import 'package:firebase_test/models/text_form_firld/password_form/password_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_view_model.g.dart';

@riverpod
class PasswordViewModel extends _$PasswordViewModel {
  @override
  PasswordState build() {
    return PasswordState();
  }

  // パスワードの表示/非表示をトグル
  void toggleVisibility() {
    state = state.copyWith(isVisible: !state.isVisible);
  }
}
