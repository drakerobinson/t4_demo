import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:t4_demo_flutter/dto_s/recipe.dart';
import 'package:t4_demo_flutter/services/device_service.dart';

import '../constants/strings.dart';


class RecipesService {


  Future<List<Recipe>> getRandomRecipes() async {
    var response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/random?${Strings.apiKey}&number=5'),
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
            "image": recipe.imageUrl,
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
        "nameClean": element.name,
        "amount": element.quantity,
        "unit": element.metric,
      });
    });
    return serializedIngredients;
  }

  Future<List<Recipe>> getSavedRecipes() async {
    String deviceId = await DeviceService().getDeviceId();
    List<Recipe> recipes = [];
    await FirebaseFirestore
        .instance
        .collection('savedRecipes')
        .doc(deviceId)
        .get()
        .then((DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['recipes'].forEach((element) {
            recipes.add(Recipe.fromJSON(element));
          });
      },
      onError: (error) => print(error.toString()),
    );
    return recipes;
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    List<Recipe> recipes = [];

    final response = await http.get(
        Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=$query&${Strings
            .apiKey}&number=4'),
        headers: {
          'Content-Type': 'application/json'
        }
    );
    try {
      final responseData = jsonDecode(response.body);


      responseData['results'].forEach((element) async {
        await getRecipeById(element['id']).then((value) => recipes.add(value));
      });

      return recipes;
    } catch (error) {
      print(error);
      return <Recipe>[];
    }
  }

  Future<Recipe> getRecipeById(int id) async {

    final response = await http.get(
        Uri.parse('https://api.spoonacular.com/recipes/$id/information?&${Strings
            .apiKey}'),
        headers: {
          'Content-Type': 'application/json'
        }
    );
    print(response);
    final responseData = jsonDecode(response.body);
    return Recipe.fromJSON(responseData);
  }

  Future<List<Recipe>> getRecipesWithIngredient(int id) async {
    List<Recipe> recipes = await getSavedRecipes();
    List<Recipe> likeRecipes = [];
    recipes.forEach((element) { 
      element.ingredients.forEach((ingredientsIterated) {
        if(ingredientsIterated.id == id && !likeRecipes.contains(element)) {
          likeRecipes.add(element);
        }
      });
    });
    return likeRecipes;
  }



}