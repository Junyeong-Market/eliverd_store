import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('LoginPage'),
      body: ListView(
        padding: EdgeInsets.all(50.0),
        children: <Widget>[
          SizedBox(height: height / 8.0),
          Image(
            width: width / 1.5,
            height: width / 1.5,
            image: AssetImage('assets/images/logo/eliverd_logo_original.png'),
          ),
          SizedBox(height: height / 32.0),
          TextField(
            key: Key('IdField'),
            obscureText: false,
            controller: idController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ),
              labelText: idText,
            ),
          ),
          SizedBox(height: height / 80.0),
          TextField(
            key: Key('PasswordField'),
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ),
              labelText: passwordText,
            ),
          ),
          SizedBox(height: height / 80.0),
          CupertinoButton(
            key: Key('SignInButton'),
            child: Text(
              login,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            color: eliverdColor,
            borderRadius: BorderRadius.circular(15.0),
            padding: EdgeInsets.symmetric(vertical: 15.0),
            onPressed: () => {
              // TO-DO: 로그인 BLOC 구현하기

              Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()))
            },
          ),
          FlatButton(
            key: Key('SignUpButton'),
            child: Text(
              notSignUp,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            onPressed: () => {
              // TO-DO: 회원가입 BLOC 구현하기
            },
          )
        ],
      ),
    );
  }
}
