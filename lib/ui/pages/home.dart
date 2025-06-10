import 'package:after_layout/after_layout.dart';
import 'package:alpha_twelve_task/cubits/items_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/items_states.dart';
import 'package:alpha_twelve_task/cubits/states/status.dart';
import 'package:alpha_twelve_task/ui/components/item_view.dart';
import 'package:alpha_twelve_task/ui/components/navbar.dart';
import 'package:alpha_twelve_task/ui/components/shimmering/item_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Home extends StatefulWidget {
    const Home({ super.key });

    @override
    State<StatefulWidget> createState() => __Home();
}

class __Home extends State<Home> with AfterLayoutMixin<Home>{
    @override
    void afterFirstLayout(BuildContext context) {
        context.read<ItemsCubit>().init();
    }

    @override
    Widget build(BuildContext context) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            NavBar(title: "Technology"),
            Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(width: 250, child: Text("Smartphones, Laptops & Accessories", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18))),
            ),
            Expanded(child: BlocBuilder<ItemsCubit, ItemsState>(builder: (context, state) {
                if(state.status == StateStatus.loading){
                    return Padding(
                        padding: const EdgeInsets.all(20),
                        child: GridView.count(padding: EdgeInsets.zero,
                            childAspectRatio: 0.7, crossAxisCount: 2, crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: List.generate(6, (index) => ItemViewShimmer())),
                    );
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