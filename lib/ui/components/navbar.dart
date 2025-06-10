import 'package:flutter/material.dart';

class NavBar extends StatelessWidget{
    final String title;
    final void Function()? back;

    const NavBar({ super.key, required this.title, this.back });

    void clicked() => back?.call();
    
    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return Container(padding: EdgeInsets.all(10), color: theme.surfaceContainerLowest,
            child: GestureDetector(onTap: clicked, child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.arrow_back_ios_new_rounded, size: 12,),
                SizedBox(width: 4),
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
            ]))
        );
    }
}