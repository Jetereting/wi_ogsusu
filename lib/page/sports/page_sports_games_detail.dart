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
import 'package:wi_ogsusu/entities/sport_game_channel_info.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/extension/token_master.dart';
import 'package:wi_ogsusu/common/utils/device_util.dart';
import 'package:flutter/services.dart';
import 'page_sports_games_play.dart';

// ignore: must_be_immutable
class SportsGamesDetailPage extends StatefulWidget{

  SportGameInfo _sportGameInfo;

  SportsGamesDetailPage(SportGameInfo sportGameInfo){
    _sportGameInfo = sportGameInfo;
  }

  @override
  _SportsGamesDetailPageState createState() => new _SportsGamesDetailPageState(_sportGameInfo);

}

class _SportsGamesDetailPageState extends State<SportsGamesDetailPage> with AutomaticKeepAliveClientMixin {

  SportGameInfo _sportGameInfo;
  bool _loading = false;
  List<SportGameChannelInfo> _sportGameChannelList = [];
  Dio dio = new Dio();
  bool _loadable = true;


  _SportsGamesDetailPageState(SportGameInfo sportGameInfo){
    _sportGameInfo = sportGameInfo;
  }


  @override
  bool get wantKeepAlive => true;

  Future<void> _getGameChannelData() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_SPORTS_GAME_CHANNELS + _sportGameInfo.channelIds;
    Response response = await dio.get(url).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      List dataList = response.data['data'];
      if(mounted) {
        setState(() {
          _loading = false;
          _sportGameChannelList = dataList.map((dataStr) {
            return new SportGameChannelInfo.fromJson(dataStr);
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
    _getGameChannelData();
  }

  void itemClick(SportGameChannelInfo sportGameChannelInfo){
    getStreamToken().then((token){
      String method = 'startPlayActivity%%' + sportGameChannelInfo.channelId + "%%" + token;
      if(_loadable){
        if(DeviceUtil.isAndroid()){
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return new SportsGamesPlayPage(sportGameChannelInfo);
          }));
        }else if(DeviceUtil.isIos()){
          const streamPlayPlugin = const MethodChannel('com.wiatec.ogsusu.video.player');
          streamPlayPlugin.invokeMethod(method);
        }
      }
    });
  }

  Widget buildSportGameChannelItem(SportGameChannelInfo sportGameChannelInfo){
    var deviceSize = MediaQuery.of(context).size;
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.0),
      child: new GestureDetector(
        onTap: (){
          itemClick(sportGameChannelInfo);
        },
        child: new Row(
          children: <Widget>[
            Container(
              width: deviceSize.width / 5,
              child: new AspectRatio(
                aspectRatio: 16.0 / 9.0,
                child: new Container(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'res/img/hold.jpg',
                    image: sportGameChannelInfo.icon,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              child: Text(
                sportGameChannelInfo.label,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0126),
        title: Text(
          Translations.of(context).text('more')
        ),
      ),
      body: new Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 8.0),
          child: _loading ?
          new CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red)
          ) :
          _sportGameChannelList.length > 0 ?
          new RefreshIndicator(
            child: new ListView.builder(
              itemCount: _sportGameChannelList.length * 2,
              itemBuilder: (BuildContext context, int index) {
                if(index.isOdd){
                  return const Divider();
                }
                return buildSportGameChannelItem(_sportGameChannelList[index ~/ 2]);
              },
            ),
            onRefresh: _getGameChannelData,
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
      ),
    );
  }


}