import 'package:freezed_annotation/freezed_annotation.dart';
part 'child_info_state.freezed.dart';

@freezed
class ChildInfoState with _$ChildInfoState {
  const factory ChildInfoState({
    String? docId,
    String? name,
    int? gender,
    int? age,
    @Default(false) bool isEditable,
  }) = _ChildInfoState;

  const ChildInfoState._();
}
