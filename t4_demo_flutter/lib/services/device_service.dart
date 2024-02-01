import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  Future<String> getDeviceId() async {
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
    return deviceId;
  }
}