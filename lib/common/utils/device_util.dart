import 'dart:io';
import 'package:device_info/device_info.dart';
import 'dart:async';

class DeviceUtil{

  static bool isAndroid(){
    return Platform.isAndroid;
  }

  static bool isIos(){
    return Platform.isIOS;
  }

  static Future<String> getAndroidModel() async{
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  }

  static Future<String> getIosModel() async{
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.model;
  }



}