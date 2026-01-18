import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/text.png'),
              SizedBox(height:20),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/difficultySelect');
                },
                child: Image.asset('assets/pokeball.png', height: 150, width: 150,)),
              SizedBox(height: 20),
              Text('Guess the Pokémon!', style: GoogleFonts.cinzel(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 40),
              Text('Tap the Pokéball to start', style: GoogleFonts.openSans(fontSize: 16, color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}