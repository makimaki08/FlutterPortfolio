import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info_edit/children_info_edit_state.dart';
import 'package:firebase_test/widgets/loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final childrenInfoEditProvider =
    StateNotifierProvider<ChildrenInfoEditController, ChildrenInfoEditState>(
        ChildrenInfoEditController.new);

class ChildrenInfoEditController extends StateNotifier<ChildrenInfoEditState> {
  ChildrenInfoEditController(this._ref)
      : super(const ChildrenInfoEditState(children: [ChildInfoState()]));
  final Ref _ref;

  Future<void> addNewChild(String uid, ChildInfoState value) async {
    Loading.show();
    FirebaseFirestore.instance.collection('children').add(
      {
        'uid': uid,
        'name': value.name,
        'gender': value.gender,
        'age': value.age,
      },
    );
    state = state.copyWith(
      haveRegistration: true,
      children: [...state.children, value],
    );
    await Future.delayed(const Duration(seconds: 1));
    Loading.dismiss();
  }

  void updateChildName(int index, String name) {
    final updateChild = state.children[index].copyWith(name: name);
    final updateChildren = [...state.children];

    updateChildren[index] = updateChild;

    state = state.copyWith(children: updateChildren);
  }

  void updateChildGender(int index, int gender) {
    final updatedChild = state.children[index].copyWith(gender: gender);

    final updatedChildren = [...state.children];
    updatedChildren[index] = updatedChild;

    state = state.copyWith(children: updatedChildren);
  }

  void updateChildAge(int index, int value) {
    final updatedChild = state.children[index].copyWith(age: value);

    final updatedChildren = [...state.children];
    updatedChildren[index] = updatedChild;

    state = state.copyWith(children: updatedChildren);
  }

  void updateIsEditable(int index, bool value) {
    final updatedChild = state.children[index].copyWith(isEditable: value);
    final updatedChildren = [...state.children];
    updatedChildren[index] = updatedChild;

    state = state.copyWith(children: updatedChildren);
  }

  Future<void> updateChildInfo(int index, ChildInfoState updatedChild) async {
    Loading.show();
    await Future.delayed(const Duration(seconds: 1));
    FirebaseFirestore.instance
        .collection('children')
        .doc(state.children[index].docId)
        .update(
      {
        'name': updatedChild.name,
        'gender': updatedChild.gender,
        'age': updatedChild.age,
      },
    );

    final updatedChildren = [...state.children];
    updatedChildren[index] = updatedChild;

    state = state.copyWith(children: updatedChildren);

    Loading.dismiss();
  }

  // memo: uidを元にして、firebaseから情報を取得する
  void fetchChildrenInfo() {
    FirebaseFirestore.instance
        .collection('children')
        .get()
        .then((QuerySnapshot snapshot) {
      List<ChildInfoState> newChildren = [];
      snapshot.docs.forEach((doc) {
        // /// usersコレクションのドキュメントIDを取得する
        var child = ChildInfoState(
          docId: doc.id,
          name: doc.get('name'),
          gender: doc.get('gender'),
          age: doc.get('age'),
        );

        newChildren.add(child);
      });
      state = state.copyWith(
        children: newChildren,
        haveRegistration: true,
      );
    });
  }
}
