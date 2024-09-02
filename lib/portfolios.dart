import 'package:flutter/material.dart';
import 'package:portfolio/ui/home/home_view.dart';

class Portfolios extends StatelessWidget {
  const Portfolios({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.light(primary: Colors.white,),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
              color: Colors.white
          ),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
