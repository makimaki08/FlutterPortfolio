import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/widgets/loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final childrenInfoEditProvider =
    StateNotifierProvider<ChildrenInfoEditController, ChildrenInfoEditState>(
        ChildrenInfoEditController.new);

class ChildrenInfoEditController extends StateNotifier<ChildrenInfoEditState> {
  ChildrenInfoEditController(this._ref) : super(const ChildrenInfoEditState());
  final Ref _ref;

  void addNewChild(String uid, String name) {
    Loading.show();
    FirebaseFirestore.instance.collection('children').add(
      {
        'uid': uid,
        'name': name,
        'gender': state.gender,
        'age': state.age,
      },
    );
    state = state.copyWith(haveRegistration: true);
    Loading.dismiss();
  }

  void onChangedGender(int value) {
    state = state.copyWith(gender: value);
  }

  void onChangedAge(int value) {
    state = state.copyWith(age: value);
  }
}
