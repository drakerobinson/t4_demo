import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t4_demo_flutter/dto_s/recipe.dart';
import 'package:t4_demo_flutter/services/device_service.dart';

final savedGroceriesProvider = StreamProvider<List<String>>((ref) async* {

  String deviceId = await DeviceService().getDeviceId();

  final stream = FirebaseFirestore.instance.collection('savedIngredients').doc(deviceId).get();

  var results = const <String>[];
  yield results;
});
