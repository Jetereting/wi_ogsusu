import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'main.dart';
import 'page/page_bottom_tab.dart';
import 'page/page_login.dart';

class RouteNavigator{

  static Router router;

  static void initRoute(){
    router = Router();
    router.define(
        "/main",
        handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return MyApp();
        })
    );
    router.define(
        "/tab",
        handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return PageTab();
        })
    );
    router.define(
        "/login",
        handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return PageLogin();
        })
    );
//    router.define(
//        "/login",
//        handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//          return LoginPage();
//        })
//    );
//    router.define(
//        "/nav",
//        handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//          return NavPage();
//        })
//    );
  }
}