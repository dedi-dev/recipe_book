import 'package:flutter/material.dart';
import 'package:recipe_book/page/home.dart';
import 'package:recipe_book/page/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Book App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'NunitoSans',
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const LandingPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
