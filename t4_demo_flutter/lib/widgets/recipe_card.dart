import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/dto_s/recipe.dart';
import 'package:t4_demo_flutter/services/recipes_service.dart';
import 'package:t4_demo_flutter/widgets/webview.dart';

import '../constants/colors.dart';

class RecipeCard extends StatefulWidget {

  final Recipe recipe;
  final bool isSaved;

  RecipeCard(this.recipe, this.isSaved);

  @override
  RecipeCardState createState() => RecipeCardState(recipe, isSaved);
}

class RecipeCardState extends State<RecipeCard> {

  final Recipe recipe;
  bool isSaved;

  RecipeCardState(this.recipe, this.isSaved);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: [
          getTitle(),
          getSubheading(),
          getRecipeImage(),
          SizedBox(height: 15,),
          getIngredientsList(),
        ],
      ),
    );
  }

  getTitle() {
    return Row(
      children: [
        Expanded(child: Text(recipe.recipeName)),
        getSaveRecipe(),
    ],);
  }

  getSaveRecipe() {
    return IconButton(
        onPressed: () async {
          await RecipesService().saveRecipe(recipe).then((value) {
            setState(() {
              isSaved = value;
            });
          });
        },
        icon: Icon(!isSaved ? FontAwesomeIcons.heart: FontAwesomeIcons.solidHeart)
    );
  }

  getSubheading() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebView(recipe.sourceUrl)));
      },
      child: const Text(
        "Visit Source",
        style: TextStyle(
          color: Colors.lightBlue,
        ),
      ),
    );
  }

  getRecipeImage() {
    return SizedBox(
      height: 200,
        width: 300,
        child:
          Image.network(
            recipe.imageUrl
        ));
  }

  getIngredientsList() {
    return Container(
      height: 50,
        width: 350,
        child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: recipe.ingredients.length,
        itemBuilder: (context, index) {
          return getIngredientLabel(recipe.ingredients[index]);
        }
    ));
  }

  getIngredientLabel(Ingredients ingredient) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.lightTertiary
      ),

        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    ingredient.nameClean,
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        '${ingredient.quantity.toString()} '
                      ),
                      Text(
                        ingredient.metric
                      )
                  ],)
          ],))),

    );

  }

}