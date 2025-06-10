import 'dart:convert';

import 'package:equatable/equatable.dart';

class Item extends Equatable{
    final String id, imageUrl, name, variant;
    final List<String> details;
    final int price;

    const Item({ required this.id, required this.name, this.variant = "", required this.imageUrl, required this.details, required this.price });

    factory Item.fromJson(dynamic json){
        return Item(
            id: json["id"], imageUrl: json["imageUrl"], name: json["name"], variant: json["variant"],
            details: (json["details"] as List).map((init)=> init.toString()).toList(),
            price: json["price"]);
    }

    Map<String, dynamic> toJson() => {
        "id": id, "imageUrl": imageUrl, "name": name, "variant": variant, "details": details, "price": price
    };

    String serialize() => json.encode(toJson());

    @override
    List<Object?> get props => [ id, imageUrl, name, variant, details, price ];
}