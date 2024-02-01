import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/services/ingredients_service.dart';

class IngredientCard extends StatefulWidget {

  final Ingredient ingredient;

  IngredientCard(this.ingredient);

  @override
  IngredientCardState createState() => IngredientCardState(ingredient);
}

class IngredientCardState extends State<IngredientCard> {

  final Ingredient ingredient;

  IngredientCardState(this.ingredient);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Card(
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Flexible(child: Text(ingredient.name)),
         const Spacer(),
         getSaveIngredient(),
       ],
     ),
   );
  }

  getSaveIngredient() {
    return Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(25)
          ),
            child: TextButton(
          onPressed: () async {
            IngredientsService().addToShoppingList(ingredient);
          },
          child: Text("Add to Shopping List", textAlign: TextAlign.center,)
    )));
  }

}