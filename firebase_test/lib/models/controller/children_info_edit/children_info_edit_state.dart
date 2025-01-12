import 'package:freezed_annotation/freezed_annotation.dart';
part 'children_info_edit_state.freezed.dart';

@freezed
class ChildrenInfoEditState with _$ChildrenInfoEditState {
  const factory ChildrenInfoEditState({
    @Default(false) bool haveRegistration,
  }) = _ChildrenInfoEditState;

  const ChildrenInfoEditState._();
}
