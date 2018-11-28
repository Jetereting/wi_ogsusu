import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:wi_ogsusu/common/utils/toast_util.dart';
import 'dart:math' as math;
import 'package:wi_ogsusu/constant.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/entities/check_in_info.dart';
import 'package:wi_ogsusu/entities/user_points_detail_info.dart';
import 'package:wi_ogsusu/entities/check_in_detail_info.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/widget/page_loading_list7.dart';
import 'package:wi_ogsusu/locale/translations.dart';

class CoinPage extends StatefulWidget{

  @override
  CoinPageState createState() => CoinPageState();

}


enum AppBarBehavior { normal, pinned, floating, snapping }

class CoinPageState extends State<CoinPage>{

  Dio dio = new Dio();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
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


