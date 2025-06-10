import 'package:alpha_twelve_task/cubits/items_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/items_states.dart';
import 'package:alpha_twelve_task/cubits/states/status.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:alpha_twelve_task/repositories/items_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockItemRepository extends Mock implements ItemRepository {}

void main() {
    late MockItemRepository mockRepository;

    // Sample test data
    final testItems = [
        Item(id: '1', name: 'Item 1', imageUrl: 'url1', details: ['detail1'], price: 100),
        Item( id: '2', name: 'Item 2', imageUrl: 'url2', details: ['detail2'], price: 200),
    ];
    
    final testItem = Item( id: '1', name: 'Test Item', imageUrl: 'test_url', details: ['test_detail'], price: 150);

    setUp(() {
        mockRepository = MockItemRepository();
    });
    
    group('ItemsCubit', () {
        test('has [initial status] state is created', () async {
            final cubit = ItemsCubit(repository: mockRepository);

            expect(cubit.state.status, StateStatus.initial);
        });

        blocTest<ItemsCubit, ItemsState>('emits [loading, success] when loading items succeeds',
            setUp: () {
                when(() => mockRepository.all()).thenAnswer((_) async => testItems);
            },
            build: () => ItemsCubit(repository: mockRepository),
            act: (cubit) => cubit.init(),
            expect: () => [
                ItemsState(status: StateStatus.loading, items: []),
                ItemsState(status: StateStatus.success, items: testItems),
            ],
            verify: (_) {
                verify(() => mockRepository.all()).called(1);
            },
        );

        blocTest<ItemsCubit, ItemsState>('emits [loading, failure] when loading items fails',
            setUp: () {
                when(() => mockRepository.all()).thenThrow(Exception('Failed to load'));
            },
            build: () => ItemsCubit(repository: mockRepository),
            act: (cubit) => cubit.init(),
            expect: () => [
                ItemsState(status: StateStatus.loading, items: []),
                const ItemsState(status: StateStatus.failure, message: 'unable to fetch products'),
            ],
            verify: (_) {
                verify(() => mockRepository.all()).called(1);
        });
          
        blocTest<ItemsCubit, ItemsState>('emits [loading, success] when reloading items succeeds',
            setUp: () {
                when(() => mockRepository.all()).thenAnswer((_) async => testItems);
            },
            build: () => ItemsCubit(repository: mockRepository),
            act: (cubit) => cubit.reload(),
            expect: () => [
                ItemsState(status: StateStatus.loading),
                ItemsState(status: StateStatus.success, items: testItems),
            ],
            verify: (_) {
                verify(() => mockRepository.all()).called(1);
            });

        test('get() returns item from repository', () async {
            when(() => mockRepository.all()).thenAnswer((_) async => testItems);
            when(() => mockRepository.get('1')).thenAnswer((_) async => testItem);
            final cubit = ItemsCubit(repository: mockRepository);

            final item = await cubit.get('1');
            expect(item, testItem);
            verify(() => mockRepository.get('1')).called(1);
        });

        test('get() throws when repository throws', () async {
            when(() => mockRepository.all()).thenAnswer((_) async => testItems);
            when(() => mockRepository.get('1')).thenThrow(Exception('Not found'));
            final cubit = ItemsCubit(repository: mockRepository);

            expect(() => cubit.get('1'), throwsException);
            verify(() => mockRepository.get('1')).called(1);
        });
    });
}