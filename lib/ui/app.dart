import 'package:alpha_twelve_task/ui/screens/main.dart';
import 'package:alpha_twelve_task/ui/screens/splash.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        return MaterialApp(showSemanticsDebugger: false,
            title: 'Alpha Twelve',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF60B5FF)),
                useMaterial3: true,
            ),
            initialRoute: "main",
            routes: {
                "main": (context) => Main(),
                "splash": (context) => Splash()
            },
        );
    }
}