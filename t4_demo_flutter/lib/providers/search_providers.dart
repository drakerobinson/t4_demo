import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/dto_s/recipe.dart';
import 'package:t4_demo_flutter/services/ingredients_service.dart';
import 'package:t4_demo_flutter/services/recipes_service.dart';

final ingredientResultsProvider = FutureProvider<List<Ingredient>>((ref) async {
  ref.watch(queryProvider);
  return await IngredientsService().searchIngredients(ref.read(queryProvider));
});

final queryProvider = StateProvider<String>((ref) => '');

final recipeResultsProvider = FutureProvider<List<Recipe>>((ref) async {
  ref.watch(queryProvider);
  return await RecipesService().searchRecipes(ref.read(queryProvider));
});