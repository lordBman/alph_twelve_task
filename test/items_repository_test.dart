import 'package:alpha_twelve_task/models/item.dart';
import 'package:alpha_twelve_task/repositories/items_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
    TestWidgetsFlutterBinding.ensureInitialized();

    group('ItemRepository', () {
        late ItemRepository repository;

        setUp(() {
            repository = ItemRepository();
        });

        group('constructor', () {
            test('does not require an Item Repository', () {
                expect(ItemRepository(), isNotNull);
            });
        });

        group('all', () {
            test('return list of available items', () async {
                final results = await repository.all();

                expect(results, isA<List<Item>>());
            });

            test('returns an it with named: Google Pixel 9A 128GB', () async {
                final result =  await repository.get("dgrgththhhghgdf");
                expect(result,
                    isA<Item>()
                        .having((w) => w.name, 'name', 'Google Pixel 9A 128GB')
                        .having((w) => w.id, 'id', 'dgrgththhhghgdf')
                        .having((w) => w.imageUrl, 'imageUrl', "google_pixels.png")
                        .having((w) => w.price, 'price', 499)
                        .having((w) => w.variant, 'variant', 'Pearl'));
            });

            test('returns a not found exception', () async {
                String id = "unknown";
                expect(() async => await repository.get("unknown"),
                    throwsA(isA<Exception>().having((w) => w.toString(), 'message', Exception('item with $id not found').toString())));
            });
        });
    });
}