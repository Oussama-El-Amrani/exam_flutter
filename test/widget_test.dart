// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exam_flutter/main.dart';

void main() {
  testWidgets('Chat app loads conversations list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ChatApp());

    // Verify that the app bar shows "Messages"
    expect(find.text('Messages'), findsOneWidget);

    // Verify that there's a floating action button for new conversations
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Wait for the conversations to load
    await tester.pump(const Duration(milliseconds: 600));

    // Verify that conversations are displayed
    expect(find.text('Alice Martin'), findsOneWidget);
    expect(find.text('Bob Dupont'), findsOneWidget);
  });

  testWidgets('Can open new conversation dialog', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatApp());

    // Wait for initial load
    await tester.pump(const Duration(milliseconds: 600));

    // Tap the floating action button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the dialog appears
    expect(find.text('Nouvelle conversation'), findsOneWidget);
    expect(find.text('Nom du contact'), findsOneWidget);

    // Tap cancel to close dialog
    await tester.tap(find.text('Annuler'));
    await tester.pump();

    // Verify dialog is closed
    expect(find.text('Nouvelle conversation'), findsNothing);
  });
}
