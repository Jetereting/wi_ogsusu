import 'package:flutter/material.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/common/utils/crypto_util.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'dart:convert';


void makeStreamToken() async{
  try {
    Dio dio = new Dio();
    String unixSeconds = TimeUtil.currentTimeSeconds().toString();
    String md5Value = getMd5("BTVi35C41E7Ho2oMcqUZMMvFzqb$unixSeconds");
    String url = Constant.URL_STREAM_TOKEN + unixSeconds + "&token=$md5Value";
    Response response = await dio.get(url).catchError((DioError e) {
      print("DioError: " + e.toString());
    });
    Map<String, dynamic> result = json.decode(response.data);
    print(result);
    if(result['error_code'] == 0){
      String streamToken = result['data']['token'].toString();
      await setSpString(Constant.SP_KEY_STREAM_TOKEN, streamToken);
    }
  }catch (exception){
    print(exception);
  }
}

Future<String> getStreamToken() async{
  try {
    String streamToken = await getSpString(Constant.SP_KEY_STREAM_TOKEN);
    return streamToken;
  }catch (exception){
    print(exception);
    return "";
  }
}

