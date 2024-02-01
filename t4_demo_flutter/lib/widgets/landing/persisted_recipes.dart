import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/providers/saved_data_provider.dart';
import 'package:t4_demo_flutter/services/recipes_service.dart';
import 'package:t4_demo_flutter/widgets/components/recipe_card.dart';

import '../../dto_s/recipe.dart';

class PersistedRecipes extends ConsumerStatefulWidget {
  @override
  PersistedRecipesState createState()=> PersistedRecipesState();
}

class PersistedRecipesState extends ConsumerState<PersistedRecipes> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
      Flexible(child: getPersistedRecipes()),
    ],);
  }


  getPersistedRecipes() {
    return FutureBuilder(
        future: RecipesService().getSavedRecipes(),
        builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
          if(snapshot.hasError) {
            return const Text("There was an issue retrieving your data");
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return RecipeCard(snapshot.data![index], true);
                }
            );
          }
          return const CircularProgressIndicator();
        }
    );
  }

}