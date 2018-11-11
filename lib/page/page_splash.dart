import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';

class Splash extends StatefulWidget{

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash>{

  Dio dio = new Dio();

  Future<Null> verifyToken() async{
    int userId = await getSpInt(Constant.SP_KEY_USER_ID);
    String currentToken = await getSpString(Constant.SP_KEY_TOKEN);
    String url = Constant.URL_OGSUSU_TOKEN + userId.toString() + "/$currentToken";
    Response response = await dio.post(url).catchError((DioError e){
      print("DioError: " + e.toString());
      Navigator.of(context).pushNamed('/tab');
    });
    int code = response.data['code'];
    if(code == 200) {
      print("$currentToken verify success");
      Navigator.of(context).pushNamed('/tab');
    }else{
      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  void initState() {
    super.initState();
    verifyToken();
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }

  @override
  Widget build(BuildContext context) {
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