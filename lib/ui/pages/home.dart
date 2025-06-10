import 'package:alpha_twelve_task/cubits/items_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/items_states.dart';
import 'package:alpha_twelve_task/cubits/states/status.dart';
import 'package:alpha_twelve_task/ui/components/item_view.dart';
import 'package:alpha_twelve_task/ui/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget{
    const Home({ super.key });

    @override
    Widget build(BuildContext context) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            NavBar(title: "Technology"),
            Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(width: 250, child: Text("Smartphones, Laptops & Accessories", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18))),
            ),
            Expanded(child: BlocBuilder<ItemsCubit, ItemsState>(builder: (context, state) {
                if(state.status == StateStatus.loading){
                    return Center(child: Text("loading..."));
                }else if(state.status == StateStatus.failure){
                  return Center(child: Text(state.message!));
                }
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(padding: EdgeInsets.zero, childAspectRatio: 0.7, crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, children: [
                      ...state.items.map((item)=> ItemView(item: item, clicked: (id)=> Navigator.pushNamed(context, "details", arguments: id  )))
                  ]),
                );
            }))
        ]);
    }
}