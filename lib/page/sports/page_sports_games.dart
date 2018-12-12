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
import 'package:wi_ogsusu/common/http_master.dart';


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
  List<SportGameInfo> currentSportGamesList = [];
  Dio dio = new Dio();
  bool loadable = true;
  FocusNode focusNode = FocusNode();

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
    HttpMaster.instance.get(url).then((result) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      int code = result.code;
      if (code != 200) {
        print(result.msg);
        return;
      }
      setState(() {
        List dataList = result.data;
        _loading = false;
        sportGamesList = dataList.map((dataStr) {
          return new SportGameInfo.fromJson(dataStr);
        }).toList();
        currentSportGamesList = sportGamesList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getGamesData();
  }

  void _onItemClick(SportGameInfo sportGameInfo){
    focusNode.unfocus();
    if(loadable) {
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
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
    return new InkWell(
      onTap: (){
        _onItemClick(sportGameInfo);
      },
      child: new Container(
        width: double.infinity,
        color: Colors.transparent,
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

  void filterList(String key){
    if(key == null || key.length <= 0 || key == '' || key == ' '){
      setState(() {
        currentSportGamesList = sportGamesList;
      });
    }
    setState(() {
      currentSportGamesList =
        sportGamesList.where((sportGameInfo){
          return sportGameInfo.homeTeam.toLowerCase().contains(key.toLowerCase()) ||
              sportGameInfo.guestTeam.toLowerCase().contains(key.toLowerCase()) ;
        }).toList();
    });
  }

  Widget buildFilter(){
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      width: double.infinity,
      child: new TextField(
        focusNode: focusNode,
        style: new TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
          border: OutlineInputBorder(
          ),
          fillColor: Colors.pink,
          contentPadding: EdgeInsets.all(8.0),
          hintText: Translations.of(context).text('search'),
          suffixIcon: Icon(Icons.search, color: Colors.grey, size: 24.0,),
        ),
        autofocus: false,
        onChanged: (String str){
          filterList(str);
        },
        onSubmitted: (String str){
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: _loading && currentSportGamesList.length <= 0 ?
      LoadingList8Page() :
      currentSportGamesList.length >= 0 ?
        new RefreshIndicator(
          child: new ListView.builder(
            itemCount: currentSportGamesList.length * 2 + 1,
            itemBuilder: (BuildContext context, int index) {
              if(index == 0){
                return buildFilter();
              }
              if(index.isEven){
                return const Divider();
              }else {
                return buildSportGameItem(currentSportGamesList[index ~/ 2]);
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