import 'package:flutter/material.dart';
import 'package:flutter_app_first/my/router.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpStoragePage(WidgetTester tester) async {
  routerConfig.go('/storage');
  final app = MaterialApp.router(routerConfig: routerConfig);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

Future<void> _addItem(WidgetTester tester, String name) async {
  final createButton = find.byType(FloatingActionButton);
  await tester.tap(createButton);
  await tester.pumpAndSettle();

  final nameField = find.byType(TextFormField);
  await tester.enterText(nameField, name);

  final saveButton = find.text('Save');
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
}

const _icons = {
  'storage': Icons.inventory_2_outlined,
  'cart': Icons.shopping_cart_outlined,
  'add_to_cart': Icons.add_shopping_cart,
  'delete': Icons.delete_outline,
};

IconData _icon(String icon) => _icons[icon]!;

Badge _badgeOf(WidgetTester tester, String icon) {
  final badge = find.ancestor(
    of: find.byIcon(_icon(icon)),
    matching: find.byType(Badge),
  );
  return tester.widget<Badge>(badge);
}

String? _badgeCount(Badge badge) => (badge.label! as Text).data;

void main() {
  group('StoragePage', () {
    testWidgets('shows an empty message when there are no items', (
      WidgetTester tester,
    ) async {
      await _pumpStoragePage(tester);

      expect(find.text('Storage Page'), findsOneWidget);
      expect(find.text('No items yet'), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('adds an item through the create item form', (
      WidgetTester tester,
    ) async {
      await _pumpStoragePage(tester);

      var storageBadge = _badgeOf(tester, 'storage');
      expect(storageBadge.isLabelVisible, isFalse);
      expect(_badgeCount(storageBadge), '0');

      await _addItem(tester, 'Milk');

      expect(find.text('Storage Page'), findsOneWidget);
      expect(find.text('No items yet'), findsNothing);
      expect(find.text('Milk'), findsOneWidget);
      expect(find.text('"Milk" added to storage'), findsOneWidget);

      storageBadge = _badgeOf(tester, 'storage');
      expect(storageBadge.isLabelVisible, isTrue);
      expect(_badgeCount(storageBadge), '1');
    });

    testWidgets('does not save an empty name', (WidgetTester tester) async {
      await _pumpStoragePage(tester);

      await _addItem(tester, '');

      expect(find.text('Create Item'), findsOneWidget);
      expect(find.text('Please enter a name'), findsOneWidget);
    });

    testWidgets('highlights an item that is added to the cart', (
      WidgetTester tester,
    ) async {
      await _pumpStoragePage(tester);
      await _addItem(tester, 'Milk');

      var listTile = tester.widget<ListTile>(find.byType(ListTile));
      var cartBadge = _badgeOf(tester, 'cart');

      expect(listTile.selected, isFalse);
      expect(cartBadge.isLabelVisible, isFalse);
      expect(_badgeCount(cartBadge), '0');

      final addToCartButton = find.byIcon(_icon('add_to_cart'));
      await tester.tap(addToCartButton);

      await tester.pumpAndSettle();

      listTile = tester.widget<ListTile>(find.byType(ListTile));
      cartBadge = _badgeOf(tester, 'cart');

      expect(listTile.selected, isTrue);
      expect(cartBadge.isLabelVisible, isTrue);
      expect(_badgeCount(cartBadge), '1');
      expect(find.text('"Milk" added to cart'), findsOneWidget);
    });

    testWidgets('deletes an item', (WidgetTester tester) async {
      await _pumpStoragePage(tester);
      await _addItem(tester, 'Milk');

      final deleteButton = find.byIcon(_icon('delete'));
      await tester.tap(deleteButton);
      await tester.pump();

      expect(find.text('Milk'), findsNothing);
      expect(find.text('No items yet'), findsOneWidget);
    });
  });
}
