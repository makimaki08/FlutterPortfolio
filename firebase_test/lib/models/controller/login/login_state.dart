import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isAuth,
    @Default('') String token,
  }) = _LoginState;

  const LoginState._();
}
