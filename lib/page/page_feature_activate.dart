import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/common/utils/modal_util.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/constant.dart';


class PageFeatureActivate extends StatefulWidget{

  int category = 1;

  PageFeatureActivate(this.category);

  @override
  PageFeatureActivateState createState() => new PageFeatureActivateState(category);
}

class PageFeatureActivateState extends State<PageFeatureActivate>{


  int category = 1;

  String link = '';
  bool _loading = false;

  PageFeatureActivateState(this.category);

  Future<Null> activate(BuildContext context) async{
    if(link == null || link.length < 3){
      showError(context, "link input error");
      return;
    }
    setState(() {
      _loading = true;
    });
    Timer(Duration(milliseconds: 3300), (){
      setState(() {
        _loading = false;
        if(!mounted){
          return;
        }
        print(link);
        if(category == 1 && link == 'pco789.ly'){
          setSpBool(Constant.SP_KEY_SPORTS_ACTIVATED, true);
          showSuccess(context, 'Successfully, please restart app');
        }else if(category == 2 && (link == 'p1roJmd.ly' || link == 'b1roJmd.ly') || link == 'a1jmd.ly'){
          setSpBool(Constant.SP_KEY_MEDIA_ACTIVATED, true);
          showSuccess(context, 'Successfully, please restart app');
        }else{
          showError(context, 'activate failure, resource link error');
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget tfLink = new Container(
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
            contentPadding: EdgeInsets.all(12.0),
            hintText: 'type in resource link',
            labelStyle: new TextStyle(
              color: Colors.blueGrey,
              decorationColor: Colors.red,
              fontSize: 16.0,
            ),
          ),
          autofocus: false,
          onChanged: (String str){
            link = str;
          },
          onSubmitted: (String str){
            link = str;
          },
        ),
      ),
    );

    Widget loading = new Container(
      padding: new EdgeInsets.all(20.0),
      child: new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.deepOrange)
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
          activate(context);
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
        title: Text(Translations.of(context).text('feature_activate')),
      ),
      body: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            tfLink,
            Text('No resource links? Please contact your sponsor!!!'),
            _loading ? loading : btConfirm,
          ],
        ),
      ),
    );
  }
}