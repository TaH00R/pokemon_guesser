import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeApiConnector {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  static Future<Pokemon> fetchRandomPokemon({required int maxId}) async {
    final randomId = Random().nextInt(maxId) + 1;

    final pokemonResponse = await http.get(
      Uri.parse('$_baseUrl/pokemon/$randomId'),
    );

    if (pokemonResponse.statusCode != 200) {
      throw Exception('Failed to fetch Pokémon');
    }

    final pokemonJson = jsonDecode(pokemonResponse.body);

    final speciesUrl = pokemonJson['species']['url'];

    final speciesResponse = await http.get(
      Uri.parse(speciesUrl),
    );

    if (speciesResponse.statusCode != 200) {
      throw Exception('Failed to fetch Pokémon species');
    }

    final speciesJson = jsonDecode(speciesResponse.body);

    return Pokemon.fromApi(
      pokemonJson: pokemonJson,
      speciesJson: speciesJson,
    );
  }
}
