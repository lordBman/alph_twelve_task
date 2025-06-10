import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget{
    final Widget child;
    final bool enabled;

    const ShimmerWrapper({ super.key, this.enabled = true, required this.child });

    @override
    Widget build(BuildContext context) {
        final ThemeData mode = Theme.of(context);
        final baseColor = mode.brightness == Brightness.light ? Colors.blueGrey.shade200 : Color(
            0xFF36393A);
        final highlightColor = mode.brightness == Brightness.light ? Colors.blueGrey.shade50 : Color(
            0xFF5C6A70);

        return Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            enabled: enabled,
            child: child);
    }
}