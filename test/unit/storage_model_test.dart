import 'package:flutter_app_first/my/models/storage_model.dart';
import 'package:test/test.dart';

void main() {
  group('StorageModel', () {
    test('starts empty', () {
      expect(StorageModel().items, isEmpty);
    });

    test('addItem adds an item', () {
      final model = StorageModel()..addItem(Item(id: 1, name: 'A'));

      expect(model.items, hasLength(1));
      expect(model.items.single.name, 'A');
    });

    test('removeItem removes only the item with the given id', () {
      final model = StorageModel()
        ..addItem(Item(id: 1, name: 'A'))
        ..addItem(Item(id: 2, name: 'B'))
        ..removeItem(1);

      expect(model.items.single.id, 2);
    });

    test('getItem returns the item with the given id', () {
      final model = StorageModel()
        ..addItem(Item(id: 1, name: 'A'))
        ..addItem(Item(id: 2, name: 'B'));

      final item = model.getItem(2);

      expect(item, isNotNull);
      expect(item!.id, 2);
      expect(item.name, 'B');
    });

    test('getItem returns null when there is no item with the given id', () {
      final model = StorageModel()..addItem(Item(id: 1, name: 'A'));

      expect(model.getItem(2), isNull);
    });

    test('getItem returns null for a removed item', () {
      final model = StorageModel()
        ..addItem(Item(id: 1, name: 'A'))
        ..removeItem(1);

      expect(model.getItem(1), isNull);
    });

    test('items returns a copy, changing it does not change the model', () {
      final model = StorageModel()..addItem(Item(id: 1, name: 'A'));
      final items = model.items
        ..add(Item(id: 2, name: 'B'))
        ..removeAt(0);

      expect(items.map((i) => i.id), [2]);
      expect(model.items.map((i) => i.id), [1]);
    });

    test('items returns a new list on every call', () {
      final model = StorageModel()..addItem(Item(id: 1, name: 'A'));

      expect(identical(model.items, model.items), isFalse);
    });

    test('from copies items without sharing the list', () {
      final original = StorageModel()..addItem(Item(id: 1, name: 'A'));
      final copy = StorageModel.from(original)..addItem(Item(id: 2, name: 'B'));

      expect(original.items, hasLength(1));
      expect(copy.items, hasLength(2));
    });
  });

  group('StorageCubit', () {
    test('addItem emits a new model instance with the item', () {
      final cubit = StorageCubit();
      final before = cubit.state;

      cubit.addItem(Item(id: 1, name: 'A'));

      expect(cubit.state, isNot(same(before)));
      expect(cubit.state.items.single.name, 'A');
      expect(before.items, isEmpty);
    });

    test('removeItem emits a new model without the item', () {
      final cubit = StorageCubit()
        ..addItem(Item(id: 1, name: 'A'))
        ..addItem(Item(id: 2, name: 'B'));

      cubit.removeItem(1);

      expect(cubit.state.items.map((i) => i.id), [2]);
    });
  });

  group('CartCubit', () {
    test('starts empty', () {
      expect(CartCubit().state, isEmpty);
    });

    test('addItem adds an item only once', () {
      final cubit = CartCubit();
      final item = Item(id: 1, name: 'A');

      cubit
        ..addItem(item)
        ..addItem(item);

      expect(cubit.state, hasLength(1));
    });

    test('removeItem removes the item with the given id', () {
      final cubit = CartCubit()
        ..addItem(Item(id: 1, name: 'A'))
        ..addItem(Item(id: 2, name: 'B'))
        ..removeItem(1);

      expect(cubit.state.map((i) => i.id), [2]);
    });

    test('state is unmodifiable', () {
      final cubit = CartCubit()..addItem(Item(id: 1, name: 'A'));

      expect(
        () => cubit.state.add(Item(id: 2, name: 'B')),
        throwsUnsupportedError,
      );
    });
  });
}
