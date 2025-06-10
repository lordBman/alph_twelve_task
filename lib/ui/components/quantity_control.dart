import 'package:flutter/material.dart';

class __QuantityButton extends StatelessWidget{
    final IconData symbol;
    final void Function() clicked;
    final bool enabled;

    const __QuantityButton({ required this.symbol, this.enabled = true, required this.clicked });

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;
        final borderColor = theme.onSurface.withAlpha(40);

        return MaterialButton(
            color: theme.surface,
            disabledColor: borderColor,
            padding: EdgeInsets.all(4),
            onPressed: enabled ? clicked : null, shape: CircleBorder(side: BorderSide(color: borderColor, width: 1)),
            minWidth: 36, height: 36 , child: Icon(symbol, size: 20));
    }
}

class QuantityControl extends StatelessWidget{
    final int value;
    final void Function() increase, decrease;

    const QuantityControl({ super.key, required this.value, required this.increase, required this.decrease });

    @override
    Widget build(BuildContext context) {
        return  Row(crossAxisAlignment: CrossAxisAlignment.center, spacing: 16, children: [
            __QuantityButton(symbol: Icons.remove, clicked: decrease, enabled: value > 1),
            Text(value.toString(), style: TextStyle(fontSize: 12)),
            __QuantityButton(symbol: Icons.add, clicked: increase)
        ]);
    }
}