import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/ufc_event_info.dart';
import 'package:wi_ogsusu/entities/ufc_news_info.dart';
import 'package:wi_ogsusu/entities/ufc_fighter_info.dart';
import 'package:wi_ogsusu/widget/page_loading_list8.dart';
import 'ufc/section_ufc.dart';
import 'package:wi_ogsusu/common/http_master.dart';


// ignore: must_be_immutable
class RecommendSportsPage extends StatefulWidget{

  @override
  _RecommendSportsPageState createState() => new _RecommendSportsPageState();

}

class _RecommendSportsPageState extends State<RecommendSportsPage> with AutomaticKeepAliveClientMixin {

  bool _loading = false;
  List<UfcEventInfo> ufcEventList = [];
  List<UfcNewsInfo> ufcNewsList = [];
  List<UfcFighterInfo> ufcFighterList = [];
  bool loadable = true;

  Future<void> _getUfcEvents() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.UFC_EVENTS;
    HttpMaster.instance.getNative(url).then((result) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      if (result.code != 200) {
        print(result.msg);
        return;
      }
      List data = result.data;
      setState(() {
        ufcEventList = data.map((item){
          return new UfcEventInfo.fromJson(item);
        }).toList();
      });
    });
  }


  Future<void> _getUfcNews() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.UFC_NEWS;
    HttpMaster.instance.getNative(url).then((result) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      if (result.code != 200) {
        print(result.msg);
        return;
      }
      List data = result.data;
      setState(() {
        ufcNewsList = data.map((item){
          return new UfcNewsInfo.fromJson(item);
        }).toList();
      });
    });
  }

  Future<void> _getUfcFighters() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.UFC_FIGHTERS;
    HttpMaster.instance.getNative(url).then((result) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      if (result.code != 200) {
        print(result.msg);
        return;
      }
      List data = result.data;
      setState(() {
        ufcFighterList = data.map((item){
          return new UfcFighterInfo.fromJson(item);
        }).toList();
      });
    });
  }

  Future<void> refreshData() async{
    _getUfcEvents();
  }

  @override
  void initState() {
    super.initState();
    _getUfcEvents();
    _getUfcNews();
    _getUfcFighters();
  }

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.center,
        color: Color(0xffeeeeee),
        child: _loading && ufcEventList.length <= 0 ?
          LoadingList8Page() :
          new RefreshIndicator(
            child: Column(
              children: <Widget>[
                SectionUfc(ufcEventList, ufcNewsList, ufcFighterList)
              ],
            ),
            onRefresh: refreshData,
          )
    );
  }


}