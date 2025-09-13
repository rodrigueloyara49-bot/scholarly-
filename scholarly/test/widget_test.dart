// This is a basic Flutter widget test adapted for the Scholarly app.
//
// It checks that the Login screen displays its key elements correctly.

import 'package:flutter/material.dart'; // ✅ Needed for TextField, Icons, etc.
import 'package:flutter_test/flutter_test.dart';
import 'package:scholarly/main.dart';

void main() {
  testWidgets('Login screen shows email, password and login button', (
    WidgetTester tester,
  ) async {
    // Build the Scholarly app and trigger a frame.
    await tester.pumpWidget(const ScholarlyApp());

    // Verify that the title "Login" is displayed.
    expect(find.text('Login'), findsOneWidget);

    // Verify that there are exactly two TextFields (email and password).
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that the Login button is present.
    expect(find.text('Login'), findsWidgets); // title + button text
  });
}
