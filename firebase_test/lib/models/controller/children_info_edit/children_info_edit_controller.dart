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

  void addNewChild(String uid, ChildInfoState value) {
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
        // print(doc.id);
        var child = ChildInfoState(
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
