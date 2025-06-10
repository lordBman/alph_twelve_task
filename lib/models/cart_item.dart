import 'dart:convert';

import 'package:alpha_twelve_task/models/item.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable{
    final Item item;
    final int count;

    const CartItem({ required this.item, this.count = 1 });

    factory CartItem.fromJson(dynamic json){
        return CartItem( item: Item.fromJson(json["item"]), count: json["count"]);
    }

    Map<String, dynamic> toJson() => { "item": item.toJson(), "count": count };

    String serialize() => json.encode(toJson());

    @override
    List<Object?> get props => [item, count];
}