import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_first/my/cubits/cart_cubit.dart';
import 'package:flutter_app_first/my/data/cart_repository.dart';
import 'package:flutter_app_first/my/data/storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/shared_preferences.dart';

Matcher _hasItemIds(Object ids) =>
    isA<CartCubitState>().having((s) => s.itemIds, 'itemIds', ids);

void main() {
  group('CartCubit', () {
    late StorageRepository storageRepository;
    late CartCubit cubit;

    setUp(() {
      setUpSharedPreferencesMock();
      storageRepository = StorageRepository();
      cubit = CartCubit(
        storageRepository: storageRepository,
        cartRepository: CartRepository(),
      );
    });

    tearDown(() async {
      await cubit.close();
      storageRepository.dispose();
      tearDownSharedPreferencesMock();
    });

    test('starts empty', () {
      expect(cubit.state.itemIds, isEmpty);
      expect(cubit.state.items, isEmpty);
    });

    blocTest<CartCubit, CartCubitState>(
      'addItemId adds an id only once',
      build: () => cubit,
      act: (cubit) => cubit
        ..addItemId(1)
        ..addItemId(1),
      expect: () => [
        _hasItemIds([1]),
      ],
      verify: (cubit) => expect(cubit.state.itemIds, [1]),
    );

    blocTest<CartCubit, CartCubitState>(
      'removeItemId removes the id',
      build: () => cubit,
      act: (cubit) => cubit
        ..addItemId(1)
        ..addItemId(2)
        ..removeItemId(1),
      expect: () => [
        _hasItemIds([1]),
        _hasItemIds([1, 2]),
        _hasItemIds([2]),
      ],
    );

    blocTest<CartCubit, CartCubitState>(
      'mutating state.itemIds does not change the repository',
      build: () => cubit,
      act: (cubit) {
        cubit.addItemId(1);
        cubit.state.itemIds.add(2);
        cubit.addItemId(3);
      },
      expect: () => [
        _hasItemIds([1, 2]),
        _hasItemIds([1, 3]),
      ],
      verify: (cubit) => expect(cubit.state.itemIds, [1, 3]),
    );

    blocTest<CartCubit, CartCubitState>(
      'removes a cart id when storage deletes that item',
      build: () => cubit,
      act: (cubit) async {
        storageRepository.createItem('A');
        cubit.addItemId(1);
        storageRepository.removeItem(1);
      },
      wait: const Duration(milliseconds: 1),
      expect: () => [
        _hasItemIds([1]),
        _hasItemIds(isEmpty),
      ],
    );

    blocTest<CartCubit, CartCubitState>(
      'updateItems fills items from storage',
      build: () => cubit,
      act: (cubit) {
        storageRepository
          ..createItem('A')
          ..createItem('B');
        cubit
          ..addItemId(1)
          ..addItemId(2)
          ..updateItems();
      },
      expect: () => [
        _hasItemIds([1]),
        _hasItemIds([1, 2]),
        isA<CartCubitState>()
            .having((s) => s.itemIds, 'itemIds', [1, 2])
            .having(
              (s) => s.items.map((i) => i.name).toList(),
              'items',
              ['A', 'B'],
            ),
      ],
    );
  });
}
