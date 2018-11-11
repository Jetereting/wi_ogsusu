import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/sport_game_info.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/entities/sport_event_info.dart';
import 'package:wi_ogsusu/page/sports/page_sports_games_detail.dart';
import 'package:wi_ogsusu/widget/page_loading_list8.dart';

// ignore: must_be_immutable
class SportsGamesPage extends StatefulWidget{

  SportEventInfo _sportEventInfo;

  SportsGamesPage(SportEventInfo sportEventInfo){
    _sportEventInfo = sportEventInfo;
  }

  @override
  _SportsGamesPageState createState() => new _SportsGamesPageState(_sportEventInfo);

}

class _SportsGamesPageState extends State<SportsGamesPage> with AutomaticKeepAliveClientMixin {

  SportEventInfo _sportEventInfo;
  bool _loading = false;
  List<SportGameInfo> sportGamesList = [];
  Dio dio = new Dio();
  bool loadable = true;


  _SportsGamesPageState(SportEventInfo sportEventInfo){
    _sportEventInfo = sportEventInfo;
  }


  @override
  bool get wantKeepAlive => true;

  Future<void> _getGamesData() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_SPORTS_GAMES + _sportEventInfo.id.toString();
    Response response = await dio.get(url).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      List dataList = response.data['data'];
      if(mounted) {
        setState(() {
          _loading = false;
          sportGamesList = dataList.map((dataStr) {
            return new SportGameInfo.fromJson(dataStr);
          }).toList();
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(_sportEventInfo.label + " init");
    _getGamesData();
  }

  void _onItemClick(SportGameInfo sportGameInfo){
    if(loadable) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (BuildContext context) {
        return new SportsGamesDetailPage(sportGameInfo);
      }));
    }
  }

  Widget buildSportGameItem(SportGameInfo sportGameInfo){
    var deviceSize = MediaQuery.of(context).size;
    String t;
    try {
      t = TimeUtil.toStrDateTime(int.parse(sportGameInfo.time));
    } on Exception catch (e) {
      print(e);
      t = sportGameInfo.time;
    } on Error catch (e) {
      print(e);
      t = sportGameInfo.time;
    }
    return new GestureDetector(
      onTap: (){
        _onItemClick(sportGameInfo);
      },
      child: new Container(
        padding: EdgeInsets.all(3.0),
        child: new Row(
          children: <Widget>[
            new Container(
              child: Image.asset(
                _sportEventInfo.icon,
              ),
              width: 32.0,
              height: 32.0,
            ),
            new Expanded(
              child: new Column(
                children: <Widget>[
                  Text(
                    t,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          width: deviceSize.width / 3,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  sportGameInfo.guestTeam,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(width: 5.0,),
                              Icon(Icons.arrow_forward, size: 25.0, color: Colors.grey,),
                              SizedBox(width: 8.0,),
                            ],
                          )
                      ),
                      Text(
                        "VS",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,

                        ),
                      ),
                      new Container(
                          width: deviceSize.width / 3,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(width: 8.0,),
                              Icon(Icons.arrow_back, size: 25.0, color: Colors.grey,),
                              SizedBox(width: 5.0,),
                              new Expanded(
                                child: Text(
                                  sportGameInfo.homeTeam,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.center,
        child: _loading && sportGamesList.length <= 0 ?
        LoadingList8Page() :
          sportGamesList.length > 0 ?
            new RefreshIndicator(
                child: new ListView.builder(
                  itemCount: sportGamesList.length * 2,
                  itemBuilder: (BuildContext context, int index) {
                    if(index.isOdd){
                      return const Divider();
                    }else {
                      return buildSportGameItem(sportGamesList[index ~/ 2]);
                    }
                  },
                ),
                onRefresh: _getGamesData,
            ): new Container(
              alignment: Alignment.center,
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 60.0,),
                  Image.asset('res/img/icon_sad_80.png', width: 40.0, height: 40.0,),
                  Text(
                    "No game yet!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    ),
                  ),

                ],
              ),
            )
    );
  }


}