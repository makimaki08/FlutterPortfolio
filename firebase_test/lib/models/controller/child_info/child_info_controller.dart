import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_controller.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final childInfoProvider =
    StateNotifierProvider<ChildInfoController, ChildInfoState>(
        ChildInfoController.new);

class ChildInfoController extends StateNotifier<ChildInfoState> {
  ChildInfoController(this._ref) : super(const ChildInfoState());

  final Ref _ref;

  void onChangedGender(int value) {
    state = state.copyWith(gender: value);
  }

  void onChangedAge(int value) {
    state = state.copyWith(age: value);
  }
}
