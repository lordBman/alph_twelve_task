import 'package:alpha_twelve_task/cubits/shopping_cubit.dart';
import 'package:alpha_twelve_task/ui/screens/details.dart';
import 'package:alpha_twelve_task/ui/screens/main.dart';
import 'package:alpha_twelve_task/ui/screens/splash.dart';
import 'package:alpha_twelve_task/cubits/items_cubit.dart';
import 'package:alpha_twelve_task/utils/theme.dart';
import 'package:alpha_twelve_task/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        TextTheme textTheme = createTextTheme(context, "IBM Plex Sans", "IBM Plex Mono");

        MaterialTheme theme = MaterialTheme(textTheme);

        return MultiBlocProvider(
            providers: [
                BlocProvider(create: (context) => ShoppingCubit()),
                BlocProvider(create: (context) => ItemsCubit())
            ],
            child: MaterialApp(debugShowCheckedModeBanner: false,
                title: 'Alpha Twelve',
                theme: theme.light(),
                darkTheme: theme.dark(),
                initialRoute: "main",
                routes: {
                    "main": (context) => Main(),
                    "splash": (context) => Splash(),
                    "details": (context) => Details()
                },
        ));
    }
}