import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/locale/translations.dart';

class CoinPage extends StatefulWidget{

  @override
  CoinPageState createState() => CoinPageState();

}


enum AppBarBehavior { normal, pinned, floating, snapping }

class CoinPageState extends State<CoinPage>{

  bool _loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0126),
        title: Text(Translations.of(context).text('coins')),
      ),
      body: Container(

      ),
    );
  }

}


