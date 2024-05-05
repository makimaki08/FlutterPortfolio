import 'package:freezed_annotation/freezed_annotation.dart';
part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default(false) bool isAuth,
    @Default('') String uid,
  }) = _RegistrationState;

  const RegistrationState._();
}
