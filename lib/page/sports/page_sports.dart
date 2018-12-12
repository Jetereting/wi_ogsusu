import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/entities/sport_event_info.dart';
import 'page_sports_games.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/sql/sprots_event_dao.dart';
import 'page_sports_news.dart';
import 'package:wi_ogsusu/page/page_feature_activate.dart';
import 'package:wi_ogsusu/common/utils/modal_util.dart';


class SportsPage extends StatefulWidget{


  bool showAllSection = false;


  SportsPage(this.showAllSection);

  @override
  _SportsPageState createState() => new _SportsPageState(showAllSection);

}

class _SportsPageState extends State<SportsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  Dio dio = new Dio();
  bool showAllSection = false;
  List<SportEventInfo> _sportEventList = [];

  List<SportEventInfo> _tabs = <SportEventInfo>[];

  List<SportEventInfo> _tabs1 = <SportEventInfo>[
    new SportEventInfo(0, 0, 'Recommend', '', 'res/img/icon_nba_64.png', '', 0, 0, 0, 0),
  ];

  List<SportEventInfo> _tabs2 = <SportEventInfo>[
    new SportEventInfo(0, 0, 'Recommend', '', 'res/img/icon_nba_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(1, 0, 'NBA', '', 'res/img/icon_nba_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(2, 0, 'NFL', '', 'res/img/icon_nfl_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(3, 0, 'NHL', '', 'res/img/icon_nhl_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(4, 0, 'MLB', '', 'res/img/icon_mlb_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(5, 0, 'UFC', '', 'res/img/icon_ufc_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(6, 0, 'WWE', '', 'res/img/icon_wwe_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(7, 0, 'MLS', '', 'res/img/icon_mls_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(8, 0, 'NASCAR', '', 'res/img/icon_nascar_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(9, 0, 'F1', '', 'res/img/icon_f1_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(10, 0, 'INDY', '', 'res/img/icon_indy_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(11, 0, 'TENNIS', '', 'res/img/icon_tennis_64.png', '', 0, 0, 0, 0),
    new SportEventInfo(12, 0, 'GOLF', '', 'res/img/icon_golf_64.png', '', 0, 0, 0, 0),
  ];

  List<Widget> _tabPages = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  SportEventInfo _selectedTab;


  _SportsPageState(this.showAllSection);

  void initTabPages(){
    _tabPages = _tabs.map((SportEventInfo sportEventInfo) {
      if(sportEventInfo.id == 0){
        return PageSportsNews();
      }else {
        return new SportsGamesPage(sportEventInfo);
      }
    }).toList();
  }

  _insertEventsDataToDB() async{
    SportEventInfo sportEventInfo = new SportEventInfo(1, 0, 'NBA', '', 'res/img/icon_nba_64.png', '', 0, 0, 0, 0);
    SportsEventDao().insert(sportEventInfo).then((event) =>
        print(event)
    );
  }

  _getEventsDataFromDB() async{
    await SportsEventDao().selectAll().then((list) =>
      print("list from database:" + list.toString())
    );
  }


  @override
  void initState() {
    super.initState();
    print("sports init");
    if(showAllSection){
      _tabs = _tabs2;
    }else{
      _tabs = _tabs1;
    }
    initTabPages();
    _tabController = new TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _selectedTab = _tabs[0];
    _insertEventsDataToDB();
    _getEventsDataFromDB();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTab = _tabs[_tabController.index];
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    dio.clear();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        elevation: 6.0,
//        automaticallyImplyLeading: false,
//        backgroundColor: Color(0xFF0A0126),
//        title: new Text(Translations.of(context).text('sports_guide')),
//        centerTitle: false,
//        bottom: new TabBar(
//          controller: _tabController,
//          isScrollable: true,
//          indicatorColor: Colors.transparent,
//          labelColor: Colors.deepOrange,
//          unselectedLabelColor: Colors.white54,
//          tabs: _tabs.map((SportEventInfo sportEventInfo) {
//            return new Tab(
//              child: new Container(
//                child: Text(
//                  sportEventInfo.label,
//                  style: TextStyle(
//                    fontSize: 16.0,
//                  ),
//                ),
//              ),
//            );
//          }).toList()
//        ),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.add),
//            onPressed: (){
//              getSpBool(Constant.SP_KEY_SPORTS_ACTIVATED).then((load){
//                if(load){
//                  showNotice(context, 'new feature was activated');
//                }else{
//                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
//                    return new PageFeatureActivate(1);
//                  }));
//                }
//              });
//            },
//          ),
//        ],
//      ),
//      body: new TabBarView(
//        controller: _tabController,
//        children: _tabPages,
//      ),
//    );



    return new Column(
      children: <Widget>[
        Container(
          color: Color(0xFF0A0126),
          width: double.infinity,
          height: 20.0,
        ),
        Container(
          color: Color(0xFF0A0126),
          width: double.infinity,
          height: 50.0,
          padding: EdgeInsets.only(left: 15.0, right: 0.0),
          child: Row(
            children: <Widget>[
              Text(
                Translations.of(context).text('sports_guide'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                ),
              ),
              Expanded(child: Container(),),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: (){
                  getSpBool(Constant.SP_KEY_SPORTS_ACTIVATED).then((load){
                    if(load){
                      showNotice(context, 'new feature was activated');
                    }else{
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                        return new PageFeatureActivate(1);
                      }));
                    }
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          color: Color(0xFF0A0126),
          width: double.infinity,
          height: 26.0,
          alignment: Alignment.center,
          child: new TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Color(0xFFFFFFFF),
              indicatorWeight: 3.0,
              labelColor: Colors.white,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500
              ),
              unselectedLabelColor: Colors.white54,
              tabs: _tabs.map((SportEventInfo sportEventInfo) {
                return new Tab(
                  child: new Container(
                    child: Text(
                      Translations.of(context).text(sportEventInfo.label),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              }).toList()
          ),
        ),
        Expanded(
          child: new TabBarView(
            controller: _tabController,
            children: _tabPages,
          ),
        )
      ],
    );
  }


}
