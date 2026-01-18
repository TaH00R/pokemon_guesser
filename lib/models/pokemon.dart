class Pokemon {
  final String name;
  final List<String> types;
  final String imageUrl;
  final String generation;

  Pokemon({
    required this.name,
    required this.types,
    required this.imageUrl,
    required this.generation,
  });

  factory Pokemon.fromApi({
    required Map<String, dynamic> pokemonJson,
    required Map<String, dynamic> speciesJson,
  }) {
    return Pokemon(
      name: pokemonJson['name'],
      types: (pokemonJson['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
      imageUrl: pokemonJson['sprites']['other']['official-artwork']
          ['front_default'],
      generation: speciesJson['generation']['name'],
    );
  }
}
