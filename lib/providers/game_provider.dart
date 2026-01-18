import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../utils/pokeapi_connector.dart';

enum Difficulty { easy, medium, hard }

class GameProvider extends ChangeNotifier {
  Pokemon? _currentPokemon;
  Difficulty? _difficulty;
  bool _isLoading = false;
  int _revealedHints = 0;

  // getters 
  Pokemon? get currentPokemon => _currentPokemon;
  Difficulty? get difficulty => _difficulty;
  bool get isLoading => _isLoading;
  int get revealedHints => _revealedHints;

  // Game Control
  Future<void> startNewGame(Difficulty difficulty) async {
    _difficulty = difficulty;
    _isLoading = true;
    _revealedHints = 0;
    notifyListeners();

    int maxId;
    switch (difficulty) {
      case Difficulty.easy:
        maxId = 151;
        break;
      case Difficulty.medium:
        maxId = 386;
        break;
      case Difficulty.hard:
        maxId = 721;
        break;
    }

    try {
      _currentPokemon =
          await PokeApiConnector.fetchRandomPokemon(maxId: maxId);
    } catch (e) {
      _currentPokemon = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  //Hint System
  void revealNextHint(Difficulty difficulty) {
    if (_currentPokemon == null) return;
    if (_revealedHints >= maxHints) return;

    _revealedHints++;
    notifyListeners();
  }

  int get maxHints{
    switch (_difficulty) {
      case Difficulty.easy:
        return 4;
      case Difficulty.medium:
        return 3;
      case Difficulty.hard:
        return 2;
      default:
        return 0;
    }
  }

  List<String> get availableHints {
    if (_currentPokemon == null) return [];

    final pokemon = _currentPokemon!;
    List<String> hints = [];

    if (_revealedHints >= 1) {
      hints.add('Type: ${pokemon.types.join(', ')}');
    }
    if (_revealedHints >= 2) {
      hints.add('Generation: ${pokemon.generation}');
    }
    if (_revealedHints >= 3) {
      hints.add('Starts with: ${pokemon.name[0].toUpperCase()}');
    }
    if (_revealedHints >= 4) {
      hints.add('Name length: ${pokemon.name.length}');
    }
    return hints;
  }

  // Guess Checking
  bool checkGuess(String guess) {
    if (_currentPokemon == null) return false;

    return guess.trim().toLowerCase() ==
        _currentPokemon!.name.toLowerCase();
  }
}
