import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputSearchBar extends StatelessWidget{
    const InputSearchBar({ super.key });

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return DecoratedBox(decoration: BoxDecoration( border: Border.fromBorderSide(BorderSide(color: Color.fromRGBO(0xE2, 0xE8, 0xF0, 1), width: 2.0)), borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,  children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center( child: SvgPicture.asset("assets/vectors/search.svg", height: 20, width: 20)),
                ),
                Expanded(child: TextFormField(style: TextStyle(fontSize: 12), decoration: InputDecoration(hintText: "Search...", hintStyle: TextStyle(color: Color.fromRGBO(0xCB, 0xD5, 0xE1, 1)), contentPadding: EdgeInsets.zero, border: InputBorder.none),))
            ])
        );
    }
}