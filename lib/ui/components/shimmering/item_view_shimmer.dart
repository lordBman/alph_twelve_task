import 'package:alpha_twelve_task/ui/components/shimmering/shimmering_wraper.dart';
import 'package:flutter/material.dart';

class ItemViewShimmer extends StatelessWidget{
    const ItemViewShimmer({ super.key });

    @override
    Widget build(BuildContext context) {
        return ShimmerWrapper(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, spacing: 10, children: [
            Container(height: 160, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, spacing: 6, children: [
                Container(height: 14, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                Container(height: 14, width: 90, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
            ]),
            Container(height: 20, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
        ]));
    }
}