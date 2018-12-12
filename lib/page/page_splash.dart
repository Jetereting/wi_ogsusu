import 'package:flutter/material.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/page/page_bottom_tab.dart';
import 'package:wi_ogsusu/page/page_login.dart';
import 'package:wi_ogsusu/locale/translations.dart';


class Splash extends StatefulWidget{

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash>{

  Dio dio = new Dio();

  Future<Null> verifyOgsusuToken() async{
    int userId = await getSpInt(Constant.SP_KEY_USER_ID);
    String currentToken = await getSpString(Constant.SP_KEY_TOKEN);
    String url = Constant.URL_OGSUSU_TOKEN + userId.toString() + "/$currentToken";
    Response response = await dio.post(url).catchError((DioError e){
      print("DioError: " + e.toString());
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageTab()),
              (route) => route == null);
    });
    int code = response.data['code'];
    if(code == 200) {
      print("$currentToken verify success");
      String validTime = response.data['data']['validTime'];
      int level = response.data['data']['level'];
      setSpString(Constant.SP_KEY_VALID_TIME, validTime);
      setSpInt(Constant.SP_KEY_LEVEL, level);
      print(validTime);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageTab()),
              (route) => route == null);
    }else{
      print("$currentToken verify failure");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageLogin()),
              (route) => route == null);
    }
  }

  _saveCurrentLanguage(String language) async{
    print(language);
    await setSpString(Constant.SP_KEY_LANGUAGE, language);
  }

  @override
  void initState() {
    super.initState();
    verifyOgsusuToken();
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }

  @override
  Widget build(BuildContext context) {
    _saveCurrentLanguage(Translations.of(context).currentLanguage);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        child: Stack(
          children: <Widget>[
            new Image.asset(
              'res/img/splash.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            new Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Ogsusu',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 32.0
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}