import 'package:flutter/material.dart';
import 'package:game_app/view/home.dart';
import 'package:game_app/view/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Game Store',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),

        '/detail': (context) {
          final gameId =
          ModalRoute.of(context)!.settings.arguments as int;

          return Detail(
            gameTerpilih: gameId,
          );
        },
      },
    );
  }
}
