import 'package:flutter/material.dart';

import 'package:Eliverd/ui/pages/splash_screen.dart';

import 'package:Eliverd/common/theme.dart';

void main() {
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
