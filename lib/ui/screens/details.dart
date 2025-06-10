import 'package:alpha_twelve_task/cubits/items_cubit.dart';
import 'package:alpha_twelve_task/cubits/shopping_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/shopping_state.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:alpha_twelve_task/ui/components/bullet_list.dart';
import 'package:alpha_twelve_task/ui/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

class Details extends StatefulWidget{
    const Details({ super.key });

    @override
    State<StatefulWidget> createState() => __DetailsState();
}

class __DetailsState extends State<Details>{
    void selected(Item item){
        context.read<ShoppingCubit>().add(item).whenComplete((){
            toastification.show(context: context,
                description: Text('Item has been added to cart'),
                type: ToastificationType.success,
                style: ToastificationStyle.minimal,
                autoCloseDuration: const Duration(seconds: 5),
            );
        });
    }

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        final args = ModalRoute.of(context)!.settings.arguments as String;

        return Scaffold(
            appBar: AppBar(elevation: 2, centerTitle: true, 
                title: Column(children: [
                    Text("DELIVERY ADDRESS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)), 
                    SizedBox(height: 4), 
                    Text("Umuezike Road, Oyo State", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
                ]), 
                actions: [
                    IconButton(onPressed: (){},
                        icon: SvgPicture.asset("assets/vectors/hugeicons_notification-02.svg"))
                ],
            ),
            body: Column(children: [
                Row(children: [
                    Expanded(child: NavBar(title: "Go Back", back: ()=> Navigator.pop(context)))
                ]),
                Expanded(child: BlocBuilder<ShoppingCubit, ShoppingState>(builder: (context, state){
                    return FutureBuilder(future: context.read<ItemsCubit>().get(args), builder: (context, snapshot){
                        if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()));
                        }else if(snapshot.hasData){
                            return Column(children: [
                                Expanded(child:ListView(padding: EdgeInsets.all(20), children: [
                                        Stack(children: [
                                            Row(children: [
                                                Expanded(child: Image.asset("assets/images/${snapshot.data!.imageUrl}", fit: BoxFit.fitWidth))
                                            ]),
                                            Container(alignment: Alignment.topRight,
                                                child: Padding(padding: const EdgeInsets.all(20.0),
                                                    child: InkWell(onTap: (){ context.read<ShoppingCubit>().toggleFavourite(snapshot.data!.id); },
                                                        child: DecoratedBox(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                            child: Padding(padding: const EdgeInsets.all(10.0),
                                                                child: IndexedStack(index: state.favourites.contains(snapshot.data!.id) ? 1 : 0, children: [
                                                                    SvgPicture.asset("assets/vectors/hugeicons_favourite.svg", width: 24, height: 24),
                                                                    SvgPicture.asset("assets/vectors/favourite_fill.svg", width: 24, height: 24),
                                                                ]),
                                                            )),
                                                    ),
                                                )
                                            )
                                        ]),
                                        SizedBox(height: 10),
                                        Text(snapshot.data!.name, style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 10),
                                        Text("\$${snapshot.data!.price}.00", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: theme.onSurface)),
                                        SizedBox(height: 20),
                                        BulletList(title: "About this item", list: snapshot.data!.details)
                                    ])
                                ),
                                Container(color: theme.surfaceContainerLowest,
                                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                                    child: SizedBox(width: double.infinity,
                                        child: MaterialButton(color: theme.primary,
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            onPressed: () => selected(snapshot.data!), child: Text("Add to Cart", style: TextStyle(color: theme.onPrimary)))),
                                )
                            ]);
                        }
                        return Center(child: Text("Loading..."));
                    });
                }))
            ])
        );
    }
}