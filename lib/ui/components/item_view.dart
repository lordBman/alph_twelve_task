import 'package:alpha_twelve_task/models/item.dart';
import 'package:flutter/material.dart';

class ItemView extends StatelessWidget{
    final Function(String)? clicked;
    final Item item;
    
    const ItemView({ super.key, required this.item, this.clicked });
    
    void onClicked() => clicked?.call(item.id);
    
    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return GestureDetector(onTap: onClicked, child: Column(spacing: 4, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Image.asset("assets/images/${item.imageUrl}", fit: BoxFit.fitWidth),
            SizedBox(width: 160, child: Text("${item.name}|${item.variant}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: theme.onSurface))),
            Text("\$${item.price}.00", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.onSurface))
        ]));
    }
  
}