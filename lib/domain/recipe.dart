class Recipe {
  final String id, name, imageUrl, source;
  final int totalIngredients;
  final double calories;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.source,
    required this.calories,
    required this.totalIngredients,
    required this.ingredients,
  });
}
