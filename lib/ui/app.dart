import 'package:alpha_twelve_task/cubits/shopping_cubit.dart';
import 'package:alpha_twelve_task/ui/screens/details.dart';
import 'package:alpha_twelve_task/ui/screens/main.dart';
import 'package:alpha_twelve_task/ui/screens/splash.dart';
import 'package:alpha_twelve_task/cubits/items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        return MultiBlocProvider(
            providers: [
                BlocProvider(create: (context) => ShoppingCubit()),
                BlocProvider(create: (context) => ItemsCubit())
            ],
            child: MaterialApp(debugShowCheckedModeBanner: false,
                title: 'Alpha Twelve',
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF60B5FF)),
                    useMaterial3: true,
                ),
                initialRoute: "main",
                routes: {
                    "main": (context) => Main(),
                    "splash": (context) => Splash(),
                    "details": (context) => Details()
                },
        ));
    }
}