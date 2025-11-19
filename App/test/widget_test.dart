// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:helloworld/main.dart';
import 'package:helloworld/rso_list_page.dart';

void main() {
  testWidgets('RSO app loads and shows sign-in page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for animations to complete
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that sign-in page elements are present
    expect(find.text('Login'), findsNWidgets(2)); // Title and button
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // Email and password fields
  });

  testWidgets('RSO list page shows RSOs and membership status', (WidgetTester tester) async {
    // Import and build the RSO list page directly
    await tester.pumpWidget(
      MaterialApp(
        home: RsoListPage(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify RSO list page is shown
    expect(find.text('All RSOs'), findsOneWidget);

    // Verify some RSOs are displayed
    expect(find.text('Society of Women Engineers (SWE)'), findsOneWidget);
    expect(find.text('Open Source @ Illinois'), findsOneWidget);
    expect(find.text('WCS: Women in Computer Science'), findsOneWidget);

    // Verify Apply buttons are shown for non-member RSOs
    expect(find.text('Apply'), findsWidgets);

    // Verify that user has joined some RSOs (they should have a switch, not Apply button)
    // Open Source @ Illinois and WCS should be members
    expect(find.byType(Switch), findsNWidgets(2));

    // Verify calendar button is present
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);

    // Verify My RSOs button is present
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('User has joined RSOs shown in My RSOs page', (WidgetTester tester) async {
    // Import necessary dependencies
    await tester.pumpWidget(
      MaterialApp(
        home: RsoListPage(),
      ),
    );
    await tester.pumpAndSettle();

    // Navigate to My RSOs page
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();

    // Verify My RSOs page is shown
    expect(find.text('My RSOs'), findsOneWidget);

    // Verify the user's joined RSOs are displayed
    expect(find.text('Open Source @ Illinois'), findsOneWidget);
    expect(find.text('WCS: Women in Computer Science'), findsOneWidget);

    // Verify non-joined RSOs are NOT displayed
    expect(find.text('Society of Women Engineers (SWE)'), findsNothing);
  });
}
