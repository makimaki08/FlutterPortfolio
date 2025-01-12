import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final childrenInfoEditProvider =
    StateNotifierProvider<ChildrenInfoEditController, ChildrenInfoEditState>(
        ChildrenInfoEditController.new);

class ChildrenInfoEditController extends StateNotifier<ChildrenInfoEditState> {
  ChildrenInfoEditController(this._ref) : super(const ChildrenInfoEditState());
  final Ref _ref;

  void addNewChild() {
    state = state.copyWith(haveRegistration: true);
  }
}
