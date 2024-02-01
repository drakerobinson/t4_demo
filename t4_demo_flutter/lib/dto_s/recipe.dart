import 'package:t4_demo_flutter/dto_s/ingredients.dart';

class Recipe {

  final String imageUrl;
  final String sourceUrl;
  final String recipeName;
  final List<Ingredients> ingredients;

  Recipe({
    required this.imageUrl,
    required this.sourceUrl,
    required this.recipeName,
    required this.ingredients,
  });

  factory Recipe.fromJSON(Map<String, dynamic> json) {
    return Recipe(
      imageUrl: json['image'],
      sourceUrl: json['sourceUrl'],
      recipeName: json['title'],
      ingredients: parseIngredientsList(json),
    );
  }

  Map<String, dynamic> toJson()=> {
    'imageUrl': imageUrl,
    'sourceUrl': sourceUrl,
    'recipeName': recipeName,
    'ingredients': ingredients,
  };

}

parseIngredientsList(Map<String, dynamic> json) {
  List<Ingredients> ingredientsList = [];
  json['extendedIngredients'].forEach((element) {
    ingredientsList.add(Ingredients.fromJSON(element));
  });
  return ingredientsList;
}