import 'package:t4_demo_flutter/dto_s/ingredients.dart';

class Recipe {

  final String? imageUrl;
  final String? sourceUrl;
  final String? recipeName;
  final List<Ingredient> ingredients;

  Recipe({
    this.imageUrl,
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
    'image': imageUrl,
    'sourceUrl': sourceUrl,
    'recipeName': recipeName,
    'ingredients': ingredients,
  };


  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is Recipe &&
              runtimeType == other.runtimeType &&
              imageUrl == other.imageUrl
              && sourceUrl == other.sourceUrl &&
              recipeName == other.recipeName;

}

parseIngredientsList(Map<String, dynamic> json) {
  if(json['extendedIngredients'] != null) {
    List<Ingredient> ingredientsList = [];
    json['extendedIngredients'].forEach((element) {
      ingredientsList.add(Ingredient.fromExpandedJSON(element));
    });
    return ingredientsList;
  }
  return [];
}