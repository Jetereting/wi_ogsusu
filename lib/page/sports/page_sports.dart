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


class SportsPage extends StatefulWidget{
  @override
  _SportsPageState createState() => new _SportsPageState();

}

class _SportsPageState extends State<SportsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  Dio dio = new Dio();
  List<SportEventInfo> _sportEventList = [];

  List<SportEventInfo> _tabs = <SportEventInfo>[
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

  List<SportsGamesPage> sportTabPages() {
    return _tabs.map((SportEventInfo sportEventInfo) {
      return new SportsGamesPage(sportEventInfo);
    }).toList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  SportEventInfo _selectedTab;


  Future<void> _getSportsEventsData() async{
    String url = Constant.URL_SPORTS_EVENTS;
    Response response = await dio.get(url, data: {
      "type": 1,
    }).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    if(response == null){
      return;
    }
    int code = response.data['code'];
    if(code == 200) {
      List dataList = response.data['data'];
      _sportEventList = dataList.map((dataStr) {
        return new SportEventInfo.fromJson(dataStr);
      }).toList();
      print(_sportEventList);
      if(mounted) {
        setState(() {
          _tabs = _sportEventList;
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
        });
      }
    }
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
    _insertEventsDataToDB();
    _getEventsDataFromDB();
//    _getSportsEventsData();
    _tabController = new TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _selectedTab = _tabs[0];
  }


  @override
  bool get wantKeepAlive => true;

  void _handleTabSelection() {
    setState(() {
      _selectedTab = _tabs[_tabController.index];
    });
  }


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
//                  Translations.of(context).text(sportEventInfo.label),
//                  style: TextStyle(
//                    fontSize: 16.0,
//                  ),
//                ),
//              ),
//            );
//          }).toList()
//        ),
//      ),
//      body: new TabBarView(
//        controller: _tabController,
//        children: sportTabPages(),
//    ),
//    );

    return new Column(
      children: <Widget>[
        Container(
          color: Color(0xFF0A0126),
          width: double.infinity,
          height: 36.0,
        ),
        Container(
          color: Color(0xFF0A0126),
          width: double.infinity,
          height: 30.0,
          child: new TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.deepOrange,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500
              ),
              unselectedLabelColor: Colors.white54,
              tabs: _tabs.map((SportEventInfo sportEventInfo) {
                return new Tab(
                  child: new Container(
                    child: Text(
                      sportEventInfo.label,
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
            children: sportTabPages(),
          ),
        )
      ],
    );
  }


}
