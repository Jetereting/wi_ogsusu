import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/epg_info.dart';
import 'package:wi_ogsusu/entities/epg_detail_info.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/entities/channel_info.dart';
import 'dart:async';
import 'package:wi_ogsusu/widget/video.dart';
import 'package:wi_ogsusu/extension/token_master.dart';
import 'package:wi_ogsusu/entities/sport_game_channel_info.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


class SportsGamesPlayPage extends StatefulWidget{

  SportGameChannelInfo _sportGameChannelInfo;

  SportsGamesPlayPage(SportGameChannelInfo sportGameChannelInfo){
    this._sportGameChannelInfo = sportGameChannelInfo;
  }

  @override
  _SportsGamesPlayPageState createState() => new _SportsGamesPlayPageState(_sportGameChannelInfo);

}

class _SportsGamesPlayPageState extends State<SportsGamesPlayPage>{

  bool _detailLoading = false;
  bool _channelLoading = false;
  SportGameChannelInfo _sportGameChannelInfo;
  ChannelInfo _channelInfo;
  Dio dio = new Dio();
  String localeStr = "en_US";
  VideoPlayerController _videoPlayerController;

  _SportsGamesPlayPageState(SportGameChannelInfo sportGameChannelInfo){
    this._sportGameChannelInfo = sportGameChannelInfo;
  }


  Future<void> _getChannelData() async{
    setState(() {
      _channelLoading = true;
    });
    String url = Constant.URL_CHANNEL + _sportGameChannelInfo.channelId;
    Response response = await dio.get(url).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      var data = response.data['data'];
      if(mounted) {
        _channelInfo = ChannelInfo.fromJson(data);
        getStreamToken().then((token){
          if(token != null && token.length > 0){
            setState(() {
              _channelLoading = false;
              _channelInfo.url = _channelInfo.url + "?token=$token";
            });
          }
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _channelLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getChannelData();
  }

  Widget buildPlayWidget(ChannelInfo channelInfo){
    var deviceSize = MediaQuery.of(context).size;
    if(channelInfo == null) {
      return new Container(
        width: deviceSize.width,
        height: deviceSize.width / 16 * 9,
        color: Colors.black,
      );
    }
    _videoPlayerController = VideoPlayerController.network(
      channelInfo.url,
    );
    return new Chewie(
      _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.deepOrange,
        bufferedColor: Colors.deepOrange[100],
        handleColor: Colors.deepOrange,
      ),
      placeholder: Image.asset('res/img/hold1.jpg'),
    );
  }


  @override
  void dispose() {
    _videoPlayerController.dispose();
    dio.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text(_sportGameChannelInfo.label),
      ),
      body: new Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildPlayWidget(_channelInfo),
          ],
        ),
      ),
    );
  }


}