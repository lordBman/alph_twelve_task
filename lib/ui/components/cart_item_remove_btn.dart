import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItemRemoveButton extends StatelessWidget{
    final void Function() clicked;

    const CartItemRemoveButton({ super.key, required this.clicked });

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;
        final borderColor = theme.onSurface.withAlpha(40);

        return MaterialButton(
            color: theme.surface,
            disabledColor: borderColor,
            padding: EdgeInsets.all(4),
            onPressed: clicked, shape: CircleBorder(side: BorderSide(color: borderColor, width: 1)),
            minWidth: 36, height: 36 ,
            child: SvgPicture.asset("assets/vectors/hugeicons_delete-02.svg", width: 20, height: 20, colorFilter: ColorFilter.mode(theme.onSurface, BlendMode.srcIn)));
    }
}