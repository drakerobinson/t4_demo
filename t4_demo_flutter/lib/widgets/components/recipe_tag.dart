import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/services/recipes_service.dart';

import '../../dto_s/recipe.dart';

class RecipeTag extends StatefulWidget {

  final Ingredient ingredient;

  RecipeTag(this.ingredient);

  @override
  RecipeTagState createState()=> RecipeTagState(this.ingredient);
}

class RecipeTagState extends State<RecipeTag> {

  final Ingredient ingredient;

  RecipeTagState(this.ingredient);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 30,
      child: FutureBuilder(
        future: RecipesService().getRecipesWithIngredient(ingredient.id),
        builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
          if(snapshot.hasError) {
            return const Text("There was an issue checking recipes for this ingredient");
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if(snapshot.hasData && snapshot.data!.isEmpty) {
            return const Text("No saved recipes contain this ingredient");
          }
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                      child: tagRecipe(snapshot.data![index]));
                }
            );
          }
          return const CircularProgressIndicator();
        },
    ));
  }

  tagRecipe(Recipe recipe) {
    return Container(
      padding: const EdgeInsets.all(6),

     // width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.brown
          ),
          child:  Text(recipe.recipeName!, maxLines: 2, overflow: TextOverflow.ellipsis,)
    );
  }

}