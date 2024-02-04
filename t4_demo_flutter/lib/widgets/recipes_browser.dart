import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/constants/strings.dart';
import 'package:t4_demo_flutter/constants/styles.dart';
import 'package:t4_demo_flutter/providers/search_providers.dart';
import 'package:t4_demo_flutter/widgets/components/recipe_card.dart';
import 'package:t4_demo_flutter/widgets/search/search_box.dart';

import '../dto_s/recipe.dart';

class RecipesBrowser extends ConsumerStatefulWidget {
  @override
  RecipesBrowserState createState()=> RecipesBrowserState();
}

class RecipesBrowserState extends ConsumerState<RecipesBrowser> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(Strings.recipesHint),
        Styles.t4Divider,
        getResults(),
      ],);
  }

  getResults() {
    final searchWatcher = ref.watch(recipeResultsProvider);
    final queryWatcher = ref.watch(queryProvider);
    return searchWatcher.when(
      data: (data) => getRecipesBuilder(data),
      error: (error, stackTrace) =>  Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }

  getRecipesBuilder(List<Recipe> recipes) {
    return Flexible(
      child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) => RecipeCard(recipes[index], false)),
    );
  }

}