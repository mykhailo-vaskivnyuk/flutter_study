import 'package:flutter_app_first/my/cubits/cart_cubit.dart';
import 'package:flutter_app_first/my/data/cart_repository.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartCubit', () {
    late StorageRepository storageRepository;
    late CartCubit cubit;

    setUp(() {
      storageRepository = StorageRepository();
      cubit = CartCubit(
        storageRepository: storageRepository,
        cartRepository: CartRepository(),
      );
    });

    tearDown(() async {
      await cubit.close();
      storageRepository.dispose();
    });

    test('starts empty', () {
      expect(cubit.state.itemIds, isEmpty);
      expect(cubit.state.items, isEmpty);
    });

    test('addItemId adds an id only once', () {
      cubit
        ..addItemId(1)
        ..addItemId(1);

      expect(cubit.state.itemIds, [1]);
    });

    test('removeItemId removes the id', () {
      cubit
        ..addItemId(1)
        ..addItemId(2)
        ..removeItemId(1);

      expect(cubit.state.itemIds, [2]);
    });

    test('mutating state.itemIds does not change the repository', () {
      cubit.addItemId(1);
      cubit.state.itemIds.add(2);

      cubit.addItemId(3);

      expect(cubit.state.itemIds, [1, 3]);
    });

    test('removes a cart id when storage deletes that item', () async {
      storageRepository.createItem('A');
      cubit.addItemId(1);

      storageRepository.removeItem(1);
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.itemIds, isEmpty);
    });

    test('updateItems fills items from storage', () {
      storageRepository
        ..createItem('A')
        ..createItem('B');
      cubit
        ..addItemId(1)
        ..addItemId(2)
        ..updateItems();

      expect(cubit.state.items.map((i) => i.name), ['A', 'B']);
    });
  });
}
