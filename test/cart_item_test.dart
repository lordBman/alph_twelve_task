import 'dart:convert';

import 'package:alpha_twelve_task/models/cart_item.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    const item = Item(id: "dgrgththhhghgdf", name: 'Google Pixel 9A 128GB', imageUrl: "google_pixels.png", price: 499, variant: 'Pearl', details: ["it is good", "it is nice"]);

    group('CartItem', () {
        group('Constructor', () {
            test('returns an instance CartItem object from default Constructor', () {
                expect(const CartItem(item: item),
                    isA<CartItem>()
                        .having((w) => w.count, 'count', 1)
                        .having((w) => w.item.name, 'item.name', 'Google Pixel 9A 128GB')
                        .having((w) => w.item.id, 'item.id', 'dgrgththhhghgdf')
                        .having((w) => w.item.imageUrl, 'item.imageUrl', "google_pixels.png")
                        .having((w) => w.item.price, 'item.price', 499)
                        .having((w) => w.item.variant, 'item.variant', 'Pearl')
                        .having((w) => w.item.details, 'item.details', ["it is good", "it is nice"])
                );
            });
            test('returns an instance CartItem object from default Constructor with count specified', () {
                expect(const CartItem(item: item, count: 3),
                    isA<CartItem>()
                        .having((w) => w.count, 'count', 3)
                        .having((w) => w.item.name, 'item.name', 'Google Pixel 9A 128GB')
                        .having((w) => w.item.id, 'item.id', 'dgrgththhhghgdf')
                        .having((w) => w.item.imageUrl, 'item.imageUrl', "google_pixels.png")
                        .having((w) => w.item.price, 'item.price', 499)
                        .having((w) => w.item.variant, 'item.variant', 'Pearl')
                        .having((w) => w.item.details, 'item.details', ["it is good", "it is nice"])
                );
            });
        });

        group('fromJson', () {
            test('returns correct CartItem object from json map', () {
                expect(CartItem.fromJson(<String, dynamic>{ "count": 3, "item": { "id": "dgrgththhhghgdf", "name": 'Google Pixel 9A 128GB', "imageUrl": "google_pixels.png", "price": 499, "variant": 'Pearl', "details": ["it is good", "it is nice"] } }),
                    isA<CartItem>()
                        .having((w) => w.count, 'count', 3)
                        .having((w) => w.item.name, 'item.name', 'Google Pixel 9A 128GB')
                        .having((w) => w.item.id, 'item.id', 'dgrgththhhghgdf')
                        .having((w) => w.item.imageUrl, 'item.imageUrl', "google_pixels.png")
                        .having((w) => w.item.price, 'item.price', 499)
                        .having((w) => w.item.variant, 'item.variant', 'Pearl')
                        .having((w) => w.item.details, 'item.details', ["it is good", "it is nice"]));
            });
            test('returns correct CartItem object from json String', () {
                expect(CartItem.fromJson(jsonDecode('{ "count": 3, "item": { "id": "dgrgththhhghgdf", "name": "Google Pixel 9A 128GB", "imageUrl": "google_pixels.png", "price": 499, "variant": "Pearl", "details": ["it is good", "it is nice"]}}')),
                    isA<CartItem>()
                        .having((w) => w.count, 'count', 3)
                        .having((w) => w.item.name, 'item.name', 'Google Pixel 9A 128GB')
                        .having((w) => w.item.id, 'item.id', 'dgrgththhhghgdf')
                        .having((w) => w.item.imageUrl, 'item.imageUrl', "google_pixels.png")
                        .having((w) => w.item.price, 'item.price', 499)
                        .having((w) => w.item.variant, 'item.variant', 'Pearl')
                        .having((w) => w.item.details, 'item.details', ["it is good", "it is nice"]));
            });
        });

        group('toJson', () {
            test('returns a map json of CartItem object', () {
                expect(const CartItem(item: item, count: 10).toJson(),
                    isA<Map<String, dynamic>>()
                        .having((c) => c["count"], "count", 10)
                        .having((c) => c["item"]["id"], "id", "dgrgththhhghgdf")
                        .having((c) => c["item"]["name"], "name", "Google Pixel 9A 128GB")
                        .having((c) => c["item"]["imageUrl"], "imageUrl", "google_pixels.png")
                        .having((c) => c["item"]["price"], "price", 499)
                        .having((c) => c["item"]["variant"], "variant", "Pearl")
                        .having((c) => c["item"]["details"], "details", ["it is good", "it is nice"]));
            });
        });
    });
}
