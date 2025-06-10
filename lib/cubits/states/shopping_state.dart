import 'dart:convert';

import 'package:alpha_twelve_task/models/cart_item.dart';
import 'package:equatable/equatable.dart';

class ShoppingState extends Equatable{
    final List<CartItem> cart;
    final List<String> favourites;
    final int unseen;

    const ShoppingState({ this.cart = const[], this.favourites = const[], this.unseen = 0 });

    ShoppingState copy({ List<CartItem>? cart, List<String>? favourites, int? unseen }){
        return ShoppingState(
            cart: cart ?? this.cart,
            unseen: unseen ?? this.unseen,
            favourites: favourites ?? this.favourites
        );
    }

    factory ShoppingState.fromJson(dynamic json){
        return ShoppingState(
            cart: (json["cart"] as List).map((init)=> CartItem.fromJson(init)).toList(), 
            favourites: (json["favourites"] as List).map((init)=> init.toString()).toList(), 
            unseen: json["unseen"]);
    }

    Map<String, dynamic> toJson() => {
        "cart": cart.map((init)=>init.toJson()).toList(), "favourites": favourites, "unseen": unseen
    };

    String serialize() => json.encode(toJson());

    @override
    List<Object?> get props => [ cart, favourites, unseen ];
}