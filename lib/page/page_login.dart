import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/common/utils/modal_util.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/widget/background_login.dart';
import 'page_sign_up.dart';
import 'page_reset_password.dart';


class PageLogin extends StatefulWidget{

  @override
  PageLoginState createState() => new PageLoginState();
}

class PageLoginState extends State<PageLogin>{

  String username = '';
  String password = '';
  bool _loading = false;

  Dio dio = new Dio();

  _signUp() async {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new PageSignUp();
    }));
  }

  _forgetPassword() async {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new PageResetPassword();
    }));
  }

  Future<Null> login(BuildContext context) async{
    if(username == null || username.length < 3){
      showError(context, "username input error");
      return;
    }
    if(password == null || password.length < 5){
      showError(context, "password input error");
      return;
    }
    setState(() {
      _loading = true;
    });
    try {
      Response response = await dio.post(Constant.URL_USER_LOGIN, data: {
        "username": username,
        "password": password,
      }).catchError((DioError e) {
        print("DioError: " + e.toString());
      });
      int code = response.data['code'];
      if (code == 200) {
        int userId = response.data['data']['id'];
        String repCode = response.data['data']['code'];
        setState(() {
          setSpInt(Constant.SP_KEY_USER_ID, userId);
          setSpString(Constant.SP_KEY_USERNAME, username);
          setSpString(Constant.SP_KEY_REP_CODE, repCode);
          loginOgsusu(context, userId);
        });
      } else {
        setState(() {
          _loading = false;
        });
        showError(context, response.data['msg']);
      }
    }catch (exception){
      setState(() {
        _loading = false;
      });
      showError(context, 'network connect fail, try again later');
    }
  }

  Future<Null> loginOgsusu(BuildContext context, int userId) async{
    setState(() {
      _loading = true;
    });
    try {
      Response response = await dio.post(Constant.URL_OGSUSU_USER_VERIFY + userId.toString())
          .catchError((DioError e) {
            print("DioError: " + e.toString());
      });
      setState(() {
        _loading = false;
      });
      int code = response.data['code'];
      if (code == 200) {
        String token = response.data['data']['token'];
        String validTime = response.data['data']['validTime'];
        setSpString(Constant.SP_KEY_TOKEN, token);
        setSpString(Constant.SP_KEY_VALID_TIME, validTime);
        setState(() {
          Navigator.of(context).pushNamed('/tab');
        });
      } else {
        showError(context, response.data['msg']);
      }
    }catch (exception){
      setState(() {
        _loading = false;
      });
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
      margin: new EdgeInsets.only(top: 20.0),
      padding: new EdgeInsets.all(20.0),
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

    Widget tfPassword = new Container(
      padding: new EdgeInsets.all(20.0),
      child: new Theme(
        data: new ThemeData(
            primaryColor: Colors.green,
            accentColor: Colors.blueAccent,
            hintColor: Colors.indigo
        ),
        child: new TextField(
          style: new TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(8.0),
            labelText: Translations.of(context).text('password'),
            labelStyle: new TextStyle(
                color: Colors.blueGrey,
                decorationColor: Colors.white
            ),
            hintStyle:  new TextStyle(
                color: Colors.white
            ),
            suffixIcon: Icon(Icons.lock, color: Colors.grey, size: 24.0,),
          ),
          autofocus: false,
          onChanged: (String str){
            password = str;
          },
          onSubmitted: (String str){
            password = str;
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

    Widget btLogin = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      width: double.infinity,
      height: 46.0,
      decoration: BoxDecoration(
        gradient: hotLinearGradient,
      ),
      child: new RawMaterialButton(
//        disabledElevation: 10.0,
        onPressed: () {
          login(context);
        },
//        constraints: new BoxConstraints(minHeight: 50.0),
//        splashColor: Colors.white,
        child: new Text(
          Translations.of(context).text('login'),
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0
          ),
        ),
      ),
    );

    Widget sectionBottom = new Row(
      children: <Widget>[
        new FlatButton(
          child: Text(Translations.of(context).text('signup')),
          onPressed: () {
            _signUp();
          },
        ),
        Expanded(child: Container(),),
        new FlatButton(
          child: Text(Translations.of(context).text('forgot_password')),
          onPressed: () {
            _forgetPassword();
          },
        ),
      ],
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackgroundLogin(),
          new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 170.0,),
                Card(
                  elevation: 6.0,
                  margin: EdgeInsets.all(24.0),
                  child: new Container(
                    child: new Column(
                      children: <Widget>[
                        tfUsername,
                        tfPassword,
                        _loading ? loading : btLogin,
                        SizedBox(height: 8.0,),
                        sectionBottom,
                        SizedBox(height: 20.0,),
                      ],
                    ),
                  ),
                ),
//                btSignUp,
//            Container(
//              alignment: Alignment.bottomCenter,
//              child: RevealProgressButton(),
//            ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}