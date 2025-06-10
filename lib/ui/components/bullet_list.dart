import 'package:flutter/material.dart';

class BulletList extends StatelessWidget{
    final List<String> list;
    final String title;
    final TextStyle? style;
    
    const BulletList({ super.key, required this.title, required this.list, this.style });
    
    @override 
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        TextStyle initStyle = style ?? TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: theme.onSurface.withAlpha(167), height: 1.4
        );
        
        return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: initStyle),
            ...list.map((init)=> Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("  \u2022  ", style: initStyle),
                Expanded(child: Text(init, style: initStyle))
            ]))
        ]);
    }
}