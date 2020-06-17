import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('SignUpPage'),
      body: ListView(
        padding: EdgeInsets.all(height / 15.0),
        children: <Widget>[
          Text('회원가입'),
        ],
      ),
    );
  }
}
