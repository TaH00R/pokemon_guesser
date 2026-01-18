import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_guesser/pages/game_page.dart';
import 'package:pokemon_guesser/widgets/difficulty_card.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_guesser/providers/game_provider.dart';

class DifficultyPage extends StatelessWidget {
  const DifficultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1B2E), Color(0xFF2B1E4A), Color(0xFF3A235F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose Difficulty',
                style: GoogleFonts.pacifico(fontSize: 34, color: Colors.white),
              ),
              const SizedBox(height: 40),
              DifficultyCard(
                title: 'Easy',
                subtitle: 'More hints, chill vibes',
                emoji: '🟢',
                onTap: () async {
                  await context.read<GameProvider>().startNewGame(
                    Difficulty.easy,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GamePage()),
                  );
                },
              ),

              DifficultyCard(
                title: 'Medium',
                subtitle: 'Balanced challenge',
                emoji: '🟡',
                onTap: () async {
                  await context.read<GameProvider>().startNewGame(
                    Difficulty.medium,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GamePage()),
                  );
                },
              ),

              DifficultyCard(
                title: 'Hard',
                subtitle: 'No mercy',
                emoji: '🔴',
                onTap: () async {
                  await context.read<GameProvider>().startNewGame(
                    Difficulty.hard,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GamePage())
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
