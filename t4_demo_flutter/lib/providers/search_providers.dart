import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/services/ingredients_service.dart';

final searchResultsProvider = FutureProvider<List<Ingredient>>((ref) async {
  ref.watch(queryProvider);
  return await IngredientsService().searchIngredients(ref.read(queryProvider));
});

final queryProvider = StateProvider<String>((ref) => '');