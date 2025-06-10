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

    @override
    List<Object?> get props => [ cart, favourites, unseen ];
}