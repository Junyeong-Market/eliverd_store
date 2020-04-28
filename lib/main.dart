import 'package:flutter/material.dart';

import 'package:eliverdstore/common/theme.dart';
import 'package:eliverdstore/common/string.dart';

import 'package:eliverdstore/ui/pages/home.dart';

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
