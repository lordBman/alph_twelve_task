import 'dart:developer';

import 'package:alpha_twelve_task/cubits/states/shopping_state.dart';
import 'package:alpha_twelve_task/models/cart_item.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../repositories/items_repository.dart';

class ShoppingCubit extends HydratedCubit<ShoppingState>{
    final ItemRepository repository = ItemRepository();

    ShoppingCubit(): super(ShoppingState());
    
    Future<void> add(Item item) async{
        int index = state.cart.indexWhere((init)=> init.item.id == item.id);
        final cart = List<CartItem>.from(state.cart);
        if(index == -1){
            cart.add(CartItem(item: item));
            emit(state.copy(cart: cart, unseen: state.unseen + 1));
        }else{
            final cartItem = CartItem(item: item, count: cart.removeAt(index).count + 1);
            cart.insert(index, cartItem);
            emit(state.copy(cart: cart));
        }
    }

    Future<void> remove(Item item) async{
        int index = state.cart.indexWhere((init)=> init.item.id == item.id);
        final cart = List<CartItem>.from(state.cart);
        if(index != -1){
            cart.removeAt(index);
            emit(state.copy(cart: cart));
        }
    }

    Future<void> reduce(Item item) async{
        int index = state.cart.indexWhere((init)=> init.item.id == item.id);
        final cart = List<CartItem>.from(state.cart);
        if(index != -1){
            final cartItem = cart.removeAt(index);
            if(cartItem.count > 1) {
                cart.insert(index, CartItem(item: item, count: cartItem.count - 1));
            }
            emit(state.copy(cart: cart));
        }
    }

    bool isFavourite(String id) => state.favourites.contains(id);
    Future<void> toggleFavourite(String id) async{
        final favourites = List<String>.from(state.favourites);

        if(favourites.contains(id)){
            favourites.remove(id);
        }else{
            favourites.add(id);
        }
        emit(state.copy(favourites: favourites));
    }

    void clearSeen() => emit(state.copy(unseen: 0));

    @override
    ShoppingState? fromJson(Map<String, dynamic> json) {
        try{
            return ShoppingState.fromJson(json);
        }catch(err){
            log("Shopping State deserialization error", error: err);
        }
        return null;
    }
    
    @override
    Map<String, dynamic>? toJson(ShoppingState state) {
        try{
            return state.toJson();
        }catch(err){
            log("Shopping State deserialization error", error: err);
        }
        return null;
    }
}