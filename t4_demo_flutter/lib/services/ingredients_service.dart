import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:t4_demo_flutter/services/device_service.dart';

class IngredientsService {
  
  Future<void> addIngredientToShoppingList(Map<String, dynamic> savedItem) async {

    FirebaseFirestore.instance.collection('savedIngredients').doc(await DeviceService().getDeviceId()).update(savedItem);
  }
  
}