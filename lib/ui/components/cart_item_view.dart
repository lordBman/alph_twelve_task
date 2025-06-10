import 'package:alpha_twelve_task/cubits/shopping_cubit.dart';
import 'package:alpha_twelve_task/models/cart_item.dart';
import 'package:alpha_twelve_task/ui/components/cart_item_remove_btn.dart';
import 'package:alpha_twelve_task/ui/components/quantity_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemView extends StatelessWidget{
    final CartItem item;
    
    const CartItemView({ super.key, required this.item });
    
    @override 
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return InkWell(
            child: DecoratedBox(decoration: BoxDecoration(color: theme.surfaceContainerLowest, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, spacing: 10, children: [
                      Image.asset("assets/images/${item.item.imageUrl}", width: 110, height: 110, fit: BoxFit.fitHeight),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8, children: [
                          Text("${item.item.name}|${item.item.variant}",  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                          Text("\$${item.item.price}:00", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                          Text("In stock", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w400)),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              QuantityControl(value: item.count,
                                  increase: () => context.read<ShoppingCubit>().add(item.item),
                                  decrease: () => context.read<ShoppingCubit>().reduce(item.item)
                              ),
                              CartItemRemoveButton(clicked: ()=> context.read<ShoppingCubit>().remove(item.item))
                          ])
                      ]))
                  ]),
                )));
    }
}