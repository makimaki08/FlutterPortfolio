import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/pages/auth_app_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authAppPageProvider =
    StateNotifierProvider<AuthAppPageNotifier, AuthAppPageState>(
        (ref) => AuthAppPageNotifier());

class AuthAppPageState {
  final String text;

  AuthAppPageState(this.text);
}

class AuthAppPageNotifier extends StateNotifier<AuthAppPageState> {
  AuthAppPageNotifier() : super(AuthAppPageState(''));

  void fire() async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('mydata').get();
    var msg = '';

    snapshot.docChanges.forEach((element) {
      final name = element.doc.get('name');
      final mail = element.doc.get('mail');
      final age = element.doc.get('age');
      msg += '${name} ($age) <$mail>\n';
    });

    state = AuthAppPageState(msg);
  }
}
