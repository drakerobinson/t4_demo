import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/services/recipes_service.dart';
import 'package:t4_demo_flutter/widgets/recipe_card.dart';

import '../dto_s/recipe.dart';

class RecipesBrowser extends ConsumerStatefulWidget {
  @override
  RecipesBrowserState createState()=> RecipesBrowserState();
}

class RecipesBrowserState extends ConsumerState<RecipesBrowser> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder(
        future: RecipesService().getRandomRecipes(),
        builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return RecipeCard(snapshot.data![index]);
                }
            );
          }
          if(snapshot.hasError) {
            return const Text("There was an issue retrieving your data");
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}