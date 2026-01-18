import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/game_provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _controller = TextEditingController();
  String? resultMessage;

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E1B2E),
              Color(0xFF2B1E4A),
              Color(0xFF3A235F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: game.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : game.currentPokemon == null
                  ? const Center(
                      child: Text(
                        'Failed to load Pokémon',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                icon: Icon(Icons.arrow_back,),
                                  color: Colors.white,),
                              const SizedBox(width: 10),
                              Text(
                                'Who\'s that Pokémon?',
                                style: GoogleFonts.pacifico(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(
                                game.revealedHints >= game.maxHints ? 0 : 0.85,
                              ),
                              BlendMode.srcATop,
                            ),
                            child: Image.network(
                              game.currentPokemon!.imageUrl,
                              height: 220,
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter Pokémon name',
                              hintStyle:
                                  TextStyle(color: Colors.white.withOpacity(0.6)),
                              filled: true,
                              fillColor: Colors.black26,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          ElevatedButton(
                            onPressed: () {
                              final correct =
                                  game.checkGuess(_controller.text);

                              setState(() {
                                resultMessage = correct
                                    ? 'Correct! '
                                    : 'Wrong guess . Try again!';
                              });

                              if (correct) {
                                game.revealNextHint(Difficulty.easy);
                                game.revealNextHint(Difficulty.easy);
                                game.revealNextHint(Difficulty.easy);
                                game.revealNextHint(Difficulty.easy);
                              }
                            },
                            child: const Text('Guess'),
                          ),

                          if (resultMessage != null) ...[
                            const SizedBox(height: 10),
                            Text(
                              resultMessage!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: game.revealedHints < game.maxHints
                                ? () => game.revealNextHint(Difficulty.easy)
                                : null,
                            child: const Text('Reveal Hint'),
                          ),

                          const SizedBox(height: 12),

                          ...game.availableHints.map(
                            (hint) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                hint,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
