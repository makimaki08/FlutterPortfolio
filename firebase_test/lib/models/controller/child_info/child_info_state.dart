import 'package:freezed_annotation/freezed_annotation.dart';
part 'child_info_state.freezed.dart';

@freezed
class ChildInfoState with _$ChildInfoState {
  const factory ChildInfoState({
    String? name,
    int? gender,
    int? age,
  }) = _ChildInfoState;

  const ChildInfoState._();
}
