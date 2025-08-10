import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/controller/child_info/child_info_state.dart';
import 'package:firebase_test/models/controller/children_info/children_info_state.dart';
import 'package:firebase_test/widgets/loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final childrenInfoEditProvider =
    StateNotifierProvider<ChildrenInfoController, ChildrenInfoState>(
        ChildrenInfoController.new);

class ChildrenInfoController extends StateNotifier<ChildrenInfoState> {
  ChildrenInfoController(this._ref)
      : super(const ChildrenInfoState(children: [ChildInfoState()]));
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

  // childrenの名前を更新する
  void updateChildName(int index, String name) {
    final updateChild = state.children[index].copyWith(name: name);
    final updateChildren = [...state.children];

    updateChildren[index] = updateChild;

    state = state.copyWith(children: updateChildren);
  }

  // childrenの性別を更新する
  void updateChildGender(int index, int gender) {
    final updatedChild = state.children[index].copyWith(gender: gender);

    final updatedChildren = [...state.children];
    updatedChildren[index] = updatedChild;

    state = state.copyWith(children: updatedChildren);
  }

  // childrenの年齢を更新する
  void updateChildAge(int index, int value) {
    final updatedChild = state.children[index].copyWith(age: value);

    final updatedChildren = [...state.children];
    updatedChildren[index] = updatedChild;

    state = state.copyWith(children: updatedChildren);
  }

  // childrenのisEditableを更新する（isEditableは、編集可能かどうかを示すフラグ）
  void updateIsEditable(int index, bool value) {
    final updatedChild = state.children[index].copyWith(isEditable: value);
    final updatedChildren = [...state.children];
    updatedChildren[index] = updatedChild;

    state = state.copyWith(children: updatedChildren);
  }

  // childrenの情報を更新する
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

  // childrenの情報を削除する
  Future<void> deleteChildInfo(int index) async {
    Loading.show();

    final docId = state.children[index].docId;
    try {
      await FirebaseFirestore.instance
          .collection('children')
          .doc(docId)
          .delete();
      fetchChildrenInfo();
      print("TEST");
    } catch (e) {
      print(e);
    }
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
        /// usersコレクションのドキュメントIDを取得する
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
        haveRegistration: newChildren.isNotEmpty,
      );
    });
  }

  // 欠席情報を取得
  Future<List<Map<String, dynamic>>> fetchAbsenceInfo(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('collectionPath')
        .where('uid', isEqualTo: uid)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
