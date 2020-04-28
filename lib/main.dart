import 'package:flutter/material.dart';

import 'package:Eliverd/common/theme.dart';
import 'package:Eliverd/common/string.dart';

import 'package:Eliverd/ui/pages/home.dart';

void main() {
  runApp(EliverdStore());
}

class EliverdStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: appTheme,
      home: HomePage(title: homeTitle),
    );
  }
}
