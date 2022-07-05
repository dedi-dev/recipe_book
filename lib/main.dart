import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/page/detail.dart';
import 'package:recipe_book/page/home.dart';
import 'package:recipe_book/page/landing_page.dart';
import 'package:recipe_book/provider/home_provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
        LandingPage.routeName: (context) => const LandingPage(),
        HomePage.routeName: (context) => const HomePage(),
        DetailRecipe.routeName: ((context) => const DetailRecipe()),
      },
    );
  }
}
