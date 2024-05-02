import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopPage extends StatelessWidget {
  TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Top Page'),
        ),
      ),
    );
  }
}
