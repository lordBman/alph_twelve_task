import 'dart:developer';

import 'package:alpha_twelve_task/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class SimpleBlocObserver extends BlocObserver {
    const SimpleBlocObserver();
    
    @override
    void onCreate(BlocBase<dynamic> bloc) {
        super.onCreate(bloc);
        log('onCreate -- bloc: ${bloc.runtimeType}');
    }
    
    @override
    void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
        super.onEvent(bloc, event);
        log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
    }
    
    @override
    void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
        super.onChange(bloc, change);
        log('onChange -- bloc: ${bloc.runtimeType}, change: $change');
    }
    
    @override
    void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
        super.onTransition(bloc, transition);
        log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
    }
    
    @override
    void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
        log('onError -- bloc: ${bloc.runtimeType}, error: $error');
        super.onError(bloc, error, stackTrace);
    }
    
    @override
    void onClose(BlocBase<dynamic> bloc) {
        super.onClose(bloc);
        log('onClose -- bloc: ${bloc.runtimeType}');
    }
}

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path));
    Bloc.observer = const SimpleBlocObserver();
    
    runApp(const App());
}
