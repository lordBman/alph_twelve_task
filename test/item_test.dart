import 'dart:convert';

import 'package:alpha_twelve_task/models/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    group('Item', () {
        group('Constructor', () {
            test('returns an instance Item object from Constructor', () {
                expect(const Item(id: "dgrgththhhghgdf", name: 'Google Pixel 9A 128GB', imageUrl: "google_pixels.png", price: 499, variant: 'Pearl', details: ["it is good", "it is nice"]),
                    isA<Item>()
                        .having((w) => w.name, 'name', 'Google Pixel 9A 128GB')
                        .having((w) => w.id, 'id', 'dgrgththhhghgdf')
                        .having((w) => w.imageUrl, 'imageUrl', "google_pixels.png")
                        .having((w) => w.price, 'price', 499)
                        .having((w) => w.variant, 'variant', 'Pearl')
                        .having((w) => w.details, 'details', ["it is good", "it is nice"])
                );
            });
        });
        group('fromJson', () {
            test('returns correct Item object from json map', () {
                expect(Item.fromJson(<String, dynamic>{ "id": "dgrgththhhghgdf", "name": 'Google Pixel 9A 128GB', "imageUrl": "google_pixels.png", "price": 499, "variant": 'Pearl', "details": ["it is good", "it is nice"] }),
                    isA<Item>()
                        .having((w) => w.id, 'id', 'dgrgththhhghgdf')
                        .having((w) => w.name, 'name', 'Google Pixel 9A 128GB')
                        .having((w) => w.imageUrl, 'imageUrl', "google_pixels.png")
                        .having((w) => w.price, 'price', 499)
                        .having((w) => w.variant, 'variant', 'Pearl')
                        .having((w) => w.details, 'details', ["it is good", "it is nice"]));
            });
            test('returns correct Item object from json String', () {
                expect(Item.fromJson(jsonDecode('{ "id": "dgrgththhhghgdf", "name": "Google Pixel 9A 128GB", "imageUrl": "google_pixels.png", "price": 499, "variant": "Pearl", "details": ["it is good", "it is nice"] }')),
                    isA<Item>()
                        .having((w) => w.id, 'id', 'dgrgththhhghgdf')
                        .having((w) => w.name, 'name', 'Google Pixel 9A 128GB')
                        .having((w) => w.imageUrl, 'imageUrl', "google_pixels.png")
                        .having((w) => w.price, 'price', 499)
                        .having((w) => w.variant, 'variant', 'Pearl')
                        .having((w) => w.details, 'details', ["it is good", "it is nice"]));
            });
        });
        group('toJson', () {
            test('returns a map json of Item object', () {
                expect(const Item(id: "dgrgththhhghgdf", name: 'Google Pixel 9A 128GB', imageUrl: "google_pixels.png", price: 499, variant: 'Pearl', details: ["it is good", "it is nice"]).toJson(),
                    isA<Map<String, dynamic>>()
                        .having((c) => c["id"], "id", "dgrgththhhghgdf")
                        .having((c) => c["name"], "name", "Google Pixel 9A 128GB")
                        .having((c) => c["imageUrl"], "imageUrl", "google_pixels.png")
                        .having((c) => c["price"], "price", 499)
                        .having((c) => c["variant"], "variant", "Pearl")
                        .having((c) => c["details"], "details", ["it is good", "it is nice"]));
            });
        });
    });
}
