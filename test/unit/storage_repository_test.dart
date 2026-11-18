import 'dart:convert';

import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_app_first/my/models/item_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/shared_preferences.dart';

Future<void> _seedStorageItems(List<Map<String, Object>> items) async {
  await SharedPreferencesAsync().setString(
    'storageItems',
    jsonEncode(items),
  );
}

void main() {
  group('StorageRepository', () {
    late StorageRepository repository;

    setUp(() {
      setUpSharedPreferencesMock();
      repository = StorageRepository();
    });

    tearDown(() {
      repository.dispose();
      tearDownSharedPreferencesMock();
    });

    test('starts with no items', () {
      expect(repository.getItem(1), isNull);
    });

    test('initialize leaves repository empty when preferences are empty',
        () async {
      await repository.initialize();

      expect(repository.getAllItems(), isEmpty);
    });

    test('initialize loads items from shared preferences', () async {
      await _seedStorageItems([
        {'id': 1, 'name': 'A'},
        {'id': 2, 'name': 'B'},
      ]);

      await repository.initialize();

      expect(repository.getAllItems().map((i) => i.name), ['A', 'B']);
      expect(repository.getItem(1)?.name, 'A');
      expect(repository.getItem(2)?.name, 'B');
    });

    test('initialize continues ids after the last loaded item', () async {
      await _seedStorageItems([
        {'id': 1, 'name': 'A'},
        {'id': 5, 'name': 'B'},
      ]);

      await repository.initialize();
      final items = repository.createItem('C');

      expect(items.map((i) => i.id), [1, 5, 6]);
      expect(items.last.name, 'C');
    });

    test('initialize restores items after createItem persists them', () async {
      repository
        ..createItem('A')
        ..createItem('B');
      await pumpEventQueue();

      repository.dispose();
      repository = StorageRepository();
      await repository.initialize();

      expect(repository.getAllItems().map((i) => i.name), ['A', 'B']);
      expect(repository.createItem('C').map((i) => i.id), [1, 2, 3]);
    });

    test('createItem adds an item and returns the list', () {
      repository.createItem('A');
      final items = repository.createItem('B');

      expect(items.map((i) => i.name), ['A', 'B']);
    });

    test('createItem assigns increasing ids', () {
      repository.createItem('A');
      final items = repository.createItem('B');

      expect(items.map((i) => i.id), [1, 2]);
    });

    test('removeItem removes only the item with the given id', () {
      repository
        ..createItem('A')
        ..createItem('B')
        ..removeItem(1);

      final items = repository.removeItem(3);

      expect(repository.getItem(1), isNull);
      expect(items.single.id, 2);
      expect(items.single.name, 'B');
    });

    test('getItem returns the item with the given id', () {
      repository
        ..createItem('A')
        ..createItem('B');

      final item = repository.getItem(2);

      expect(item!.id, 2);
      expect(item.name, 'B');
    });

    test('getItem returns null when there is no item with the given id', () {
      repository.createItem('A');

      final item = repository.getItem(2);

      expect(item, isNull);
    });

    test('createItem and removeItem return a copy of the items', () {
      final created = repository.createItem('A')..removeAt(0);

      expect(created, isEmpty);
      expect(repository.getItem(1)?.name, 'A');
    });

    test('deletedItems emits the removed item', () async {
      repository
        ..createItem('A')
        ..createItem('B');

      final expectation = expectLater(
        repository.deletedItems,
        emits(
          predicate<Item>((item) => item.id == 1 && item.name == 'A'),
        ),
      );
      repository.removeItem(1);

      await expectation;
    });

    test('deletedItems does not emit when the id is missing', () async {
      repository.createItem('A');

      final events = <Item>[];
      final subscription = repository.deletedItems.listen(events.add);

      repository.removeItem(2);
      await Future<void>.delayed(Duration.zero);

      expect(events, isEmpty);
      await subscription.cancel();
    });
  });
}
