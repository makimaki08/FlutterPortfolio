import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'children_info_edit_state.freezed.dart';

@freezed
class ChildrenInfoEditState with _$ChildrenInfoEditState {
  const factory ChildrenInfoEditState({
    @Default(false) bool haveRegistration,
    required List<ChildInfoState> children,
  }) = _ChildrenInfoEditState;

  const ChildrenInfoEditState._();
}
