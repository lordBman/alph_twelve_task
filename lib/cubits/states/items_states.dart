import 'package:alpha_twelve_task/cubits/states/status.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:equatable/equatable.dart';

class ItemsState extends Equatable{
    final List<Item> items;
    final StateStatus  status;
    final String? message;

    const ItemsState({ this.items = const [], this.status = StateStatus.initial, this.message });

    ItemsState copy({ List<Item>? items, StateStatus? status, String? message}){
        return ItemsState(
            items: items ?? this.items,
            status: status ?? this.status,
            message: message ?? this.message);
    }

    @override
    List<Object?> get props => [ items, status, message ];
}