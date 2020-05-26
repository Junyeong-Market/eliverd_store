import 'dart:async';

import 'package:flutter/material.dart';

import 'package:Eliverd/ui/pages/splash_screen.dart';

import 'package:Eliverd/common/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(EliverdStore());
}

class EliverdStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: eliverdTheme,
      home: SplashScreenPage(),
    );
  }
}
