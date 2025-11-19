import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/rso_list_page.dart';
import 'package:helloworld/application_form_page.dart';
import 'package:helloworld/rso.dart';

void main() {
  group('RSO List Page Switch Tests', () {
    testWidgets('Switch ON navigates to ApplicationFormPage when user not in RSO',
        (WidgetTester tester) async {
      // Build the app with RsoListPage
      await tester.pumpWidget(
        const MaterialApp(
          home: RsoListPage(),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Find the first switch (for first RSO)
      final firstSwitch = find.byType(Switch).first;
      expect(firstSwitch, findsOneWidget);

      // Verify switch is initially OFF
      Switch switchWidget = tester.widget(firstSwitch);
      expect(switchWidget.value, false);

      // Tap the switch to turn it ON
      await tester.tap(firstSwitch);
      await tester.pumpAndSettle();

      // Verify that ApplicationFormPage is now displayed
      expect(find.byType(ApplicationFormPage), findsOneWidget);
      expect(find.text('Application Form - Coming Soon'), findsOneWidget);
    });

    testWidgets('ApplicationFormPage receives correct RSO',
        (WidgetTester tester) async {
      // Create a test RSO
      final testRSO = RSO(
        name: "Test RSO",
        description: "Test Description",
        events: [],
      );

      // Build ApplicationFormPage directly with test RSO
      await tester.pumpWidget(
        MaterialApp(
          home: ApplicationFormPage(rso: testRSO),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the app bar title contains the RSO name
      expect(find.text('Apply to Test RSO'), findsOneWidget);
    });

    testWidgets('ApplicationFormPage has back button',
        (WidgetTester tester) async {
      // Create a test RSO
      final testRSO = RSO(
        name: "Test RSO",
        description: "Test Description",
        events: [],
      );

      // Build ApplicationFormPage with a navigation stack
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplicationFormPage(rso: testRSO),
                    ),
                  );
                },
                child: const Text('Navigate'),
              ),
            ),
          ),
        ),
      );

      // Navigate to ApplicationFormPage
      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      // Verify ApplicationFormPage is displayed
      expect(find.byType(ApplicationFormPage), findsOneWidget);

      // Find and tap the back button
      final backButton = find.byType(BackButton);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify we're back at the original page
      expect(find.byType(ApplicationFormPage), findsNothing);
      expect(find.text('Navigate'), findsOneWidget);
    });

    testWidgets('RsoListPage displays RSOs', (WidgetTester tester) async {
      // Build the app with RsoListPage
      await tester.pumpWidget(
        const MaterialApp(
          home: RsoListPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that RSO names are displayed (check top ones visible on screen)
      expect(find.text('Society of Women Engineers (SWE)'), findsOneWidget);
      expect(find.text('Open Source @ Illinois'), findsOneWidget);
      expect(find.text('WCS: Women in Computer Science'), findsOneWidget);

      // Verify that switches are displayed (at least the visible ones)
      expect(find.byType(Switch), findsWidgets);
    });

    testWidgets('Multiple switches can navigate to ApplicationFormPage',
        (WidgetTester tester) async {
      // Build the app with RsoListPage
      await tester.pumpWidget(
        const MaterialApp(
          home: RsoListPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the first switch
      await tester.tap(find.byType(Switch).first);
      await tester.pumpAndSettle();

      // Verify ApplicationFormPage is shown
      expect(find.byType(ApplicationFormPage), findsOneWidget);

      // Go back
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Verify we're back at RsoListPage
      expect(find.byType(RsoListPage), findsOneWidget);

      // Tap the second switch
      await tester.tap(find.byType(Switch).at(1));
      await tester.pumpAndSettle();

      // Verify ApplicationFormPage is shown again
      expect(find.byType(ApplicationFormPage), findsOneWidget);
    });
  });

  group('User Class Tests', () {
    test('User can be created with joined RSOs', () {
      final rso1 = RSO(
        name: "RSO 1",
        description: "Description 1",
        events: [],
      );

      final rso2 = RSO(
        name: "RSO 2",
        description: "Description 2",
        events: [],
      );

      final user = User(
        username: "testuser@illinois.edu",
        passkey: "password",
        joinedRsos: [rso1, rso2],
      );

      expect(user.username, "testuser@illinois.edu");
      expect(user.passkey, "password");
      expect(user.joinedRsos.length, 2);
      expect(user.joinedRsos.contains(rso1), true);
      expect(user.joinedRsos.contains(rso2), true);
    });

    test('User can be created with empty joined RSOs', () {
      final user = User(
        username: "testuser@illinois.edu",
        passkey: "password",
      );

      expect(user.joinedRsos, isEmpty);
    });
  });
}
