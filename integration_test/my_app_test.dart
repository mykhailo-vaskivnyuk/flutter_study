import 'package:flutter_app_first/my/my_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';

Future<void> _goToPage(WidgetTester tester, String page) async {
  expect(find.text(page), findsOneWidget);
  await tester.tap(find.text(page));
  await tester.pumpAndSettle();
  expect(find.text(page), findsOneWidget);
}

Future<void> _goBack(WidgetTester tester) async {
  await tester.pageBack();
  await tester.pumpAndSettle();
}

Future<void> _goToPageAndBack(WidgetTester tester, String page) async {
  await _goToPage(tester, page);
  await _goBack(tester);
  expect(find.text('Home Page'), findsOneWidget);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await _goToPage(tester, 'Counter Page');

      expect(find.text('0'), findsOneWidget);
      final incrementButton = find.byKey(const ValueKey('increment'));
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      await _goBack(tester);

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('verify routing from the home bage and back', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await _goToPageAndBack(tester, 'Counter Page');
      await _goToPageAndBack(tester, 'Json Placeholder Page');
      // await _goToPageAndBack(tester, 'Ws Echo Page');
      await _goToPageAndBack(tester, 'Storage Page');

      await _goToPage(tester, 'Drawer Page');
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();
      expect(find.text('Home Page'), findsOneWidget);

      await _goToPage(tester, 'Storage Page');
      await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Cart'), findsOneWidget);
      await _goBack(tester);
      expect(find.text('Storage Page'), findsOneWidget);
      await _goBack(tester);
      expect(find.text('Home Page'), findsOneWidget);
    });
  });
}
