
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:t4_demo_flutter/constants/strings.dart';
import 'package:t4_demo_flutter/dto_s/ingredients.dart';
import 'package:t4_demo_flutter/services/device_service.dart';

class IngredientsService {
  
  Future<void> addToShoppingList(Ingredient savedItem) async {
    Map<String, dynamic> ingredientToSave = {
      'id': savedItem.id,
      'name': savedItem.name,
      'quantity': savedItem.quantity,
      'metric': savedItem.metric
    };
    FirebaseFirestore.instance
        .collection('savedIngredients')
        .doc(await DeviceService().getDeviceId())
        .set(
      {'ingredients': FieldValue.arrayUnion([ingredientToSave])},
        SetOptions(merge: true)
    );
  }
  
  Future<List<Ingredient>> searchIngredients(String query) async {
    final response = await http.get(
        Uri.parse('https://api.spoonacular.com/food/ingredients/search?${Strings
            .apiKey}&query=$query'),
        headers: {
          'Content-Type': 'application/json'
        }
    );
    try {
      final responseData = jsonDecode(response.body);

      List<Ingredient> ingredients = [];
      responseData['results'].forEach((element) {
        ingredients.add(Ingredient.fromQuery(element));
      });

      return ingredients;
    } catch (error) {
      print(error);
      return <Ingredient>[];
    }
  }

  Future<List<Ingredient>> getSavedIngredients() async {
    String deviceId = await DeviceService().getDeviceId();
    List<Ingredient> ingredients = [];
    await FirebaseFirestore
        .instance
        .collection('savedIngredients')
        .doc(deviceId)
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['ingredients'].forEach((element) {
        ingredients.add(Ingredient.fromQuery(element));
      });
    },
      onError: (error) => print(error.toString()),
    );
    return ingredients;
  }
  
}