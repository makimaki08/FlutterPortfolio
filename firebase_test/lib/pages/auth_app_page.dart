import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthAppPage extends StatefulWidget {
  const AuthAppPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<AuthAppPage> createState() => _AuthAppPageState();
}

class _AuthAppPageState extends State<AuthAppPage> {
  final _controller = TextEditingController();

  String registerUserEmail = '';
  String registerUserPassword = '';
  String loginUserEmail = '';
  String loginUserPassword = '';
  String DebugText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'OREFFERENCES ACCESS.',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(10),
              TextField(
                controller: _controller,
                style: TextStyle(fontSize: 24),
                minLines: 1,
                maxLines: 5,
              ),
              Gap(10),
              ElevatedButton(
                onPressed: fire,
                child: Text('Button'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void fire() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('mydata').get();
    var msg = '';

    snapshot.docChanges.forEach((element) {
      final name = element.doc.get('name');
      final mail = element.doc.get('mail');
      final age = element.doc.get('age');
      msg += '${name} ($age) <$mail>\n';
    });

    _controller.text = msg;
  }
}
