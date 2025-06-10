import 'package:alpha_twelve_task/cubits/shopping_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/shopping_state.dart';
import 'package:alpha_twelve_task/models/cart_item.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:alpha_twelve_task/repositories/items_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/helpers.dart';

// Mock classes
class MockItemRepository extends Mock implements ItemRepository {}

// Sample test data
final testItem = Item(id: '1',name: 'Test Item',imageUrl: 'test_url', details: ['test_detail'], price: 150);
final testCartItem = CartItem(item: testItem, count: 1);

void main() {
    initHydratedStorage();

    group('ShoppingCubit', () {
        late ShoppingCubit shoppingCubit;

        setUp(()=> shoppingCubit = ShoppingCubit());
        tearDown(()=> shoppingCubit.close());

        blocTest<ShoppingCubit, ShoppingState>('emits state with new item when add() is called for new item',
            build: () => shoppingCubit,
            act: (cubit) => cubit.add(testItem),
            expect: () => [
               ShoppingState( cart: [testCartItem], unseen: 1),
            ]);

        blocTest<ShoppingCubit, ShoppingState>('increments count when add() is called for existing item',
            seed: () => ShoppingState(cart: [testCartItem]),
            build: () => shoppingCubit,
            act: (cubit) => cubit.add(testItem),
            expect: () => [
                ShoppingState(cart: [CartItem(item: testItem, count: 2)]),
            ]);

        blocTest<ShoppingCubit, ShoppingState>('removes item when remove() is called',
            seed: () => ShoppingState(cart: [testCartItem]),
            build: () => shoppingCubit,
            act: (cubit) => cubit.remove(testItem),
            expect: () => [
                const ShoppingState(cart: []),
            ]);

        blocTest<ShoppingCubit, ShoppingState>('reduces count when reduce() is called and count > 1',
            seed: () => ShoppingState(cart: [CartItem(item: testItem, count: 2)]),
            build: () => shoppingCubit,
            act: (cubit) => cubit.reduce(testItem),
            expect: () => [
                ShoppingState(cart: [testCartItem]),
            ]);

        blocTest<ShoppingCubit, ShoppingState>('removes item when reduce() is called and count == 1',
            seed: () => ShoppingState(cart: [testCartItem]),
            build: () => shoppingCubit,
            act: (cubit) => cubit.reduce(testItem),
            expect: () => [
                const ShoppingState(cart: []),
            ]);
            
        blocTest<ShoppingCubit, ShoppingState>('toggles favourite when toggleFavourite() is called',
            build: () => shoppingCubit,
            act: (cubit) => cubit.toggleFavourite('1'),
            expect: () => [
                const ShoppingState(favourites: ['1']),
            ],
            verify: (_) {
                expect(shoppingCubit.isFavourite('1'), true);
            });
                
        blocTest<ShoppingCubit, ShoppingState>('removes favourite when toggleFavourite() is called for existing favourite',
            seed: () => const ShoppingState(favourites: ['1']),
            build: () => shoppingCubit,
            act: (cubit) => cubit.toggleFavourite('1'),
            expect: () => [
                const ShoppingState(favourites: []),
            ],
            verify: (_) {
                expect(shoppingCubit.isFavourite('1'), false);
            });

        blocTest<ShoppingCubit, ShoppingState>('clears unseen count when clearSeen() is called',
            seed: () => ShoppingState(unseen: 3),
            build: () => shoppingCubit,
            act: (cubit) => cubit.clearSeen(),
            expect: () => [
                const ShoppingState(unseen: 0),
            ]);
            
        group('Hydration', () {
            final jsonState = {
                'cart': [
                    { 'item': { 'id': '1', 'imageUrl': 'test_url', 'name': 'Test Item', 'variant': '', 'details': ['test_detail'], 'price': 150 }, 'count': 1}
                ],
                'favourites': ['1'],
                'unseen': 1
            };

            test('fromJson returns correct state', () {
                final state = shoppingCubit.fromJson(jsonState);
                
                expect(state?.cart.length, 1);
                expect(state?.favourites.length, 1);
                expect(state?.unseen, 1);
            });

            test('toJson returns correct map', () {
                final state = ShoppingState(cart: [testCartItem], favourites: ['1'], unseen: 1);

                final json = shoppingCubit.toJson(state);
                expect(json?['cart'].length, 1);
                expect(json?['favourites'].length, 1);
                expect(json?['unseen'], 1);
            });
        });
    });
}