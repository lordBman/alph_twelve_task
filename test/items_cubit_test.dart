import 'package:alpha_twelve_task/cubits/items_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/items_states.dart';
import 'package:alpha_twelve_task/cubits/states/status.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:alpha_twelve_task/repositories/items_repository.dart';

import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

//const List<CityState> cities = [];
const String message = "";
const dynamic error = null;

const StateStatus status = StateStatus.initial;

class MockItemRepository extends Mock implements ItemRepository {}

class MockItem extends Mock implements Item {}

const sampleItem = Item(id: "dgrgththhhghgdf", name: 'Google Pixel 9A 128GB', imageUrl: "google_pixels.png", price: 499, variant: 'Pearl', details: ["it is good", "it is nice"]);

void main(){
    initHydratedStorage();

    group('ItemsCubit', () {
        late Item item;
        late ItemRepository itemRepository;
        late ItemsCubit itemsCubit;

        setUpAll(() async{
            registerFallbackValue(MockItem());
        });

        setUp((){
            item = MockItem();
            itemRepository = MockItemRepository();

            when(() => item.id).thenReturn(sampleItem.id);
            when(() => item.name).thenReturn(sampleItem.name);
            when(() => item.imageUrl).thenReturn(sampleItem.imageUrl);
            when(() => item.variant).thenReturn(sampleItem.variant);
            when(() => item.price).thenReturn(sampleItem.price);
            when(() => item.details).thenReturn(sampleItem.details);

            when(() => itemRepository.all(any())).thenAnswer((_) async => [item]);
            when(() => itemRepository.get(any())).thenAnswer((_) async => item);
            itemsCubit = ItemsCubit(repository: itemRepository);
        });

        test('initial state is correct', () {
            final itemCubit = ItemsCubit(repository: itemRepository);

            expect(itemCubit.state, const ItemsState());
        });

        group('fetchAllItems', () {
            blocTest<ItemsCubit, ItemsState>('emits nothing when city is null',
                build: () => itemsCubit,
                act: (cubit) => cubit.requestCity(null),
                expect: () => <ItemsState>[],
            );

      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when city is empty',
        build: () => weatherCubit,
        act: (cubit) => cubit.requestCity(''),
        expect: () => <WeatherState>[],
      );

      /*blocTest<WeatherCubit, WeatherState>(
              'calls getWeather with correct city',
              build: () => weatherCubit,
              act: (cubit) => cubit.forecast(citySample),
              verify: (_) {
                  verify(() => forecastRepository.getWeather(citySample)).called(1);
              },
          );

          blocTest<WeatherCubit, WeatherState>(
              'emits [loading, failure] when getWeather throws',
              setUp: () {
                  when(
                          () => weatherRepository.getWeather(any()),
                  ).thenThrow(Exception('oops'));
              },
              build: () => weatherCubit,
              act: (cubit) => cubit.fetchWeather(weatherLocation),
              expect: () => <WeatherState>[
                  WeatherState(status: WeatherStatus.loading),
                  WeatherState(status: WeatherStatus.failure),
              ],
          );

          blocTest<WeatherCubit, WeatherState>(
              'emits [loading, success] when getWeather returns (celsius)',
              build: () => weatherCubit,
              act: (cubit) => cubit.fetchWeather(weatherLocation),
              expect: () => <dynamic>[
                  WeatherState(status: WeatherStatus.loading),
                  isA<WeatherState>()
                      .having((w) => w.status, 'status', WeatherStatus.success)
                      .having(
                          (w) => w.weather,
                      'weather',
                      isA<Weather>()
                          .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                          .having((w) => w.condition, 'condition', weatherCondition)
                          .having(
                              (w) => w.temperature,
                          'temperature',
                          Temperature(value: weatherTemperature),
                      )
                          .having((w) => w.location, 'location', weatherLocation),
                  ),
              ],
          );

          blocTest<WeatherCubit, WeatherState>(
              'emits [loading, success] when getWeather returns (fahrenheit)',
              build: () => weatherCubit,
              seed: () => WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
              act: (cubit) => cubit.fetchWeather(weatherLocation),
              expect: () => <dynamic>[
                  WeatherState(
                      status: WeatherStatus.loading,
                      temperatureUnits: TemperatureUnits.fahrenheit,
                  ),
                  isA<WeatherState>()
                      .having((w) => w.status, 'status', WeatherStatus.success)
                      .having(
                          (w) => w.weather,
                      'weather',
                      isA<Weather>()
                          .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                          .having((w) => w.condition, 'condition', weatherCondition)
                          .having(
                              (w) => w.temperature,
                          'temperature',
                          Temperature(value: weatherTemperature.toFahrenheit()),
                      )
                          .having((w) => w.location, 'location', weatherLocation),
                  ),
              ],
          );*/
    });

  });
}