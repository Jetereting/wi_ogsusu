import 'package:flutter/material.dart';
import 'navigator.dart';
import 'common/utils/sp_util.dart';
import 'page/page_login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'page/page_splash.dart';
import 'package:flutter/rendering.dart';

void main() {
//  debugPaintSizeEnabled=true;
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();

}

class MyAppState extends State<MyApp>{

  int userId = 0;

  getLoginUserId() async{
    int currentUserId = await getSpInt('userId');
    setState(() {
      userId = currentUserId;
    });
  }

  @override
  void initState() {
    super.initState();
    RouteNavigator.initRoute();
    getLoginUserId();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('zh', ''),
      ],
      onGenerateRoute: RouteNavigator.router.generator,
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrange,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      home: new Container(
        child: userId > 0 ? Splash() : PageLogin(),
      ),
    );
  }

}



