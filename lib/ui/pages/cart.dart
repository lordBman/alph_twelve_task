import 'package:alpha_twelve_task/cubits/shopping_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/shopping_state.dart';
import 'package:alpha_twelve_task/ui/components/cart_item_view.dart';
import 'package:alpha_twelve_task/ui/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget{
    const Cart({ super.key });

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            NavBar(title: "Your Cart"),
            Expanded(child: BlocBuilder<ShoppingCubit, ShoppingState>(builder: (context, state) {
                if(state.cart.isEmpty){
                    return Center(child: Text("Cart Empty"));
                }
                
                final total = state.cart.map((item)=> item.item.price * item.count).reduce((a, b) => a + b);
                return Column(children: [
                    Expanded(child: ListView.separated(itemCount: state.cart.length + 1, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        itemBuilder: (context, index){
                            if(index < state.cart.length){
                                return CartItemView(item: state.cart[index]);
                            }else{
                                return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, spacing: 15, children: [
                                    Text("Order Info", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text("Subtotal"),
                                        Text("\$$total.00")
                                    ]),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text("Shipping"),
                                        Text("\$10.00")
                                    ]),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text("Total:"),
                                        Text("\$${total + 10}.00", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
                                    ])
                                ]);
                            }
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 15)),
                    ),
                    Container(color: theme.surfaceContainerLowest,
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                        child: SizedBox(width: double.infinity,
                            child: MaterialButton(color: theme.primary,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                onPressed: (){  }, child: Text("Checkout(\$${total + 10}.00)", style: TextStyle(color: theme.onPrimary)))),
                    )
                ]);
            }))
        ]);
    }
}