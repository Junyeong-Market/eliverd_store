import 'dart:async';

import 'package:flutter/material.dart';

import 'package:Eliverd/common/color.dart';
import './login.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: Key('SplashScreenPage'),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [eliverdDarkColor, eliverdLightColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Image(
            width: width / 1.5,
            height: width / 1.5,
            image: AssetImage('assets/images/logo/eliverd_logo_white.png'),
          ),
        ),
      ),
    );
  }
}