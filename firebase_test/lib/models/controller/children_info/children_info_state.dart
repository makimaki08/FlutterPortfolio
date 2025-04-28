import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'children_info_state.freezed.dart';

@freezed
class ChildrenInfoState with _$ChildrenInfoState {
  const factory ChildrenInfoState({
    @Default(false) bool haveRegistration,
    required List<ChildInfoState> children,
  }) = _ChildrenInfoState;

  const ChildrenInfoState._();
}
