import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:Eliverd/main.dart';

void main() {
  testWidgets('Main Test', (WidgetTester tester) async {
    final splashScreenPageKey = Key('SplashScreenPage');
    final loginPageKey = Key('LoginPage');

    await tester.pumpWidget(EliverdStore());

    expect(find.byKey(splashScreenPageKey), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byKey(loginPageKey), findsOneWidget);
  });
}
