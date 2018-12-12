import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wi_ogsusu/common/utils/modal_util.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';

class PageResetPassword extends StatefulWidget{

  @override
  PageResetPasswordState createState() => new PageResetPasswordState();
}

class PageResetPasswordState extends State<PageResetPassword>{

  String username = '';
  String email = '';
  bool _loading = false;


  Dio dio = new Dio();

  Future<Null> reset(BuildContext context) async{
    if(username == null || username.length < 3){
      showError(context, "username input error");
      return;
    }
    if(email == null || email.length < 3){
      showError(context, "email input error");
      return;
    }
    setState(() {
      _loading = true;
    });
    try {
      Response response = await dio.post(Constant.URL_USER_RESET_PASSWORD, data: {
        "username": username,
        "email": email,
      }).catchError((DioError e) {
        print("DioError: " + e.toString());
      });
      setState(() {
        _loading = false;
      });
      if(!mounted){
        return;
      }
      int code = response.data['code'];
      if (code == 200) {

        showSuccess(context, response.data['msg']);
      } else {
        showError(context, response.data['msg']);
      }
    }catch (exception){
      showError(context, 'network connect fail, try again later');
    }
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }

  @override
  Widget build(BuildContext context) {

    Widget tfUsername = new Container(
      margin: new EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
      padding: new EdgeInsets.all(8.0),
      child:  new Theme(
        data: new ThemeData(
            primaryColor: Colors.green,
            accentColor: Colors.blueAccent,
            hintColor: Colors.indigo
        ),
        child:  new TextField(
          style: new TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(8.0),
            labelText: Translations.of(context).text('username'),
            labelStyle: new TextStyle(
              color: Colors.blueGrey,
              decorationColor: Colors.red,
              fontSize: 16.0,
            ),
            suffixIcon: Icon(Icons.person, color: Colors.grey, size: 24.0,),
          ),
          autofocus: false,
          onChanged: (String str){
            username = str;
          },
          onSubmitted: (String str){
            username = str;
          },
        ),
      ),
    );

    Widget tfEmail = new Container(
      margin: new EdgeInsets.only(left: 12.0, right: 12.0),
      padding: new EdgeInsets.all(8.0),
      child:  new Theme(
        data: new ThemeData(
            primaryColor: Colors.green,
            accentColor: Colors.blueAccent,
            hintColor: Colors.indigo
        ),
        child:  new TextField(
          style: new TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          keyboardType: TextInputType.emailAddress,
          decoration: new InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(8.0),
            labelText: Translations.of(context).text('email'),
            labelStyle: new TextStyle(
              color: Colors.blueGrey,
              decorationColor: Colors.red,
              fontSize: 16.0,
            ),
            suffixIcon: Icon(Icons.email, color: Colors.grey, size: 24.0,),
          ),
          autofocus: false,
          onChanged: (String str){
            email = str;
          },
          onSubmitted: (String str){
            email = str;
          },
        ),
      ),
    );


    Widget loading = new Container(
      padding: new EdgeInsets.all(20.0),
      child: new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.amber)
      ),
    );


    var hotLinearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: const <Color>[
        Colors.amber,
        Colors.deepOrange,
        Colors.red,
      ],
    );

    Widget btConfirm = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      width: double.infinity,
      height: 46.0,
      decoration: BoxDecoration(
        gradient: hotLinearGradient,
      ),
      child: new RawMaterialButton(
//        disabledElevation: 10.0,
        onPressed: () {
          reset(context);
        },
//        constraints: new BoxConstraints(minHeight: 50.0),
//        splashColor: Colors.white,
        child: new Text(
          Translations.of(context).text('confirm'),
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0
          ),
        ),
      ),
    );


    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0126),
        title: Text(Translations.of(context).text('reset_password')),
      ),
      body: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            tfUsername,
            tfEmail,
            _loading ? loading : btConfirm,
          ],
        ),
      ),
    );
  }
}