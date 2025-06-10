import 'package:alpha_twelve_task/cubits/states/items_states.dart';
import 'package:alpha_twelve_task/cubits/states/status.dart';
import 'package:alpha_twelve_task/models/item.dart';
import 'package:alpha_twelve_task/repositories/items_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ItemsCubit extends Cubit<ItemsState>{
    final ItemRepository repository;

    ItemsCubit({ this.repository = const ItemRepository() }): super(const ItemsState());

    Future<void> __load() async{
        emit(state.copy(status: StateStatus.loading, message: null));
        try{
            final results = await repository.all();

            emit(state.copy(status: StateStatus.success, items: results));
        }catch(error){
            emit(state.copy(status: StateStatus.failure, message: "unable to fetch products"));
        }
    }

    Future<void> reload() async => await __load();
    Future<void> init() async {
        if(state.status == StateStatus.initial){
            await __load();
        }
    }

    Future<Item> get(String id) async{
        return repository.get(id);
    }
}