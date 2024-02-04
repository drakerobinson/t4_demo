import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t4_demo_flutter/constants/styles.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/services/ingredients_service.dart';
import 'package:t4_demo_flutter/widgets/components/recipe_tag.dart';

class IngredientCard extends StatefulWidget {

  final Ingredient ingredient;
  final bool canBeTagged;

  IngredientCard(this.ingredient, this.canBeTagged);

  @override
  IngredientCardState createState() => IngredientCardState(ingredient, canBeTagged);
}

class IngredientCardState extends State<IngredientCard> {

  final Ingredient ingredient;
  final bool canBeTagged;

  bool isExpanded = false;

  IngredientCardState(this.ingredient, this.canBeTagged);

  @override
  Widget build(BuildContext context) {
   return  Card(
     child: Padding(
       padding: const EdgeInsets.symmetric(vertical: 5),
         child: Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Padding(
                     padding: const EdgeInsets.only(left: 10),
                       child: Text(ingredient.name!,

                         style: const TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                         ),
                       )),
                 const SizedBox(width: 5,),
               //  Spacer(),
                 !canBeTagged ? getSaveIngredient(): Container()
               ],
             ),
            canBeTagged ? getTagSegment(): Container(),
         ],)
   ));
  }



  getTagSegment() {
    return Column(
      children: [
        Styles.t4Divider,
        getLabel(),
        Styles.t4Divider,
        RecipeTag(ingredient)
    ],);
  }

  getLabel() {
    return Text("Recipes that Use this Ingredient");
  }

  getSaveIngredient() {
    return  Flexible(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(25)
          ),
            child: TextButton(
          onPressed: () async {
            IngredientsService().addToShoppingList(ingredient);
          },
          child: const Text("Save", textAlign: TextAlign.center,)
    )));
  }

}