import 'package:flutter/material.dart';
import 'package:pokemon_guesser/pages/difficulty_select_page.dart';
import 'package:pokemon_guesser/pages/homepage.dart';
import 'package:pokemon_guesser/providers/game_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => GameProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/difficultySelect': (context) => const DifficultyPage(),
      },
      title: 'Flutter Demo',
      home: Homepage()
    );
  }
}


