import 'package:alpha_twelve_task/cubits/states/items_states.dart';
import 'package:alpha_twelve_task/cubits/states/status.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:alpha_twelve_task/repositories/items_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsCubit extends Cubit<ItemsState>{
    final ItemRepository repository;

    ItemsCubit({ this.repository = const ItemRepository() }): super(const ItemsState()){
        if(state.status == StateStatus.initial){
            __load();
        }
    }

    void __load(){
        emit(state.copy(status: StateStatus.loading, message: ""));
        repository.all().then((results){
            emit(state.copy(status: StateStatus.success, items: results));
        }).catchError((error){
            emit(state.copy(status: StateStatus.failure, message: "unable to fetch products"));
        });
    }

    void reload() => __load();

    Future<Item> get(String id) async{
        return repository.get(id);
    }
}