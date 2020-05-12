
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:Eliverd/main.dart';

void main() {
  testWidgets('Main Test', (WidgetTester tester) async {
    await tester.pumpWidget(EliverdStore());

    expect(find.text('Eliverd'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Eliverd'), findsOneWidget);
  });
}
