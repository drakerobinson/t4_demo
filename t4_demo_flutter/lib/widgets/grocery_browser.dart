import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/constants/styles.dart';
import 'package:t4_demo_flutter/providers/search_providers.dart';
import 'package:t4_demo_flutter/widgets/components/ingredient_card.dart';
import 'package:t4_demo_flutter/widgets/search/search_box.dart';

import '../constants/strings.dart';
import '../dto_s/ingredients.dart';

class GroceryBrowser extends ConsumerStatefulWidget {
  @override
  GroceryBrowserState createState() => GroceryBrowserState();
}

class GroceryBrowserState extends ConsumerState<GroceryBrowser> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Column(
     children: [
       CustomSearchBar(Strings.ingredientsHint),
       Styles.t4Divider,
       getResults(),
     ],
   );
  }


  getResults() {
    final searchWatcher = ref.watch(ingredientResultsProvider);
    final queryWatcher = ref.watch(queryProvider);
    return searchWatcher.when(
        data: (data) => getIngredientsBuilder(data),
        error: (error, stackTrace) =>  Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
    );
  }

  getIngredientsBuilder(List<Ingredient> ingredients) {
    return Flexible(child: ListView.builder(
      itemCount: ingredients.length,
        itemBuilder: (context, index) => IngredientCard(ingredients[index], false),
    ));
  }


}