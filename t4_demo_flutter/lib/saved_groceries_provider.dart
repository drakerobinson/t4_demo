import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final savedGroceriesProvider = StreamProvider<List<String>>((ref) async* {

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceId = '';
  if(Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor != null ? iosDeviceInfo.identifierForVendor! : '';
  }
  if(Platform.isAndroid) {
    var iosDeviceInfo = await deviceInfo.androidInfo;
    deviceId = iosDeviceInfo.id;
  }

  final stream = FirebaseFirestore.instance.collection('saved').doc(deviceId);

  var allResults = const <String>[];
  yield allResults;
});