import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:t4_demo_flutter/dto_s/recipe.dart';
import 'package:t4_demo_flutter/services/device_service.dart';


class RecipesService {


  Future<List<Recipe>> getRandomRecipes() async {
    var response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/random?apiKey=15abfbe7f6744be1af885113ef4411ae'),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    try {
      List<Recipe> results = [];
      var json = jsonDecode(response.body);
      print(json);
      json['recipes'].forEach((element) {
        results.add(Recipe.fromJSON(element));
      });
      return results;
    } catch (error){
      print(error);
      return [];
    }
  }

  Future<bool> saveRecipe(Recipe recipe) async {
    var data = jsonEncode(recipe);
    try {
      await FirebaseFirestore.instance.collection('savedRecipes').doc(
          await DeviceService().getDeviceId()).set(
          {"recipes": FieldValue.arrayUnion([{
            "imageUrl": recipe.imageUrl,
            "sourceUrl": recipe.sourceUrl,
            "title": recipe.recipeName,
            "extendedIngredients": getSerializedIngredients(recipe),
          }])},
        SetOptions(merge: true)
      ).then((value) { return true;});
      return true;
    } catch(error) {
      return false;
    }
  }

  getSerializedIngredients(Recipe recipe) {
    List<Map<String, dynamic>> serializedIngredients = [];
    recipe.ingredients.forEach((element) {
      serializedIngredients.add({
        "id": element.id,
        "nameClean": element.nameClean,
        "quantity": element.quantity,
        "metric": element.metric,
      });
    });
    return serializedIngredients;
  }

}