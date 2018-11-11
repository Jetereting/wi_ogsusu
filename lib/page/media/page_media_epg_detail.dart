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
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


class MediaEpgDetailPage extends StatefulWidget{

  EpgInfo _epgInfo;

  MediaEpgDetailPage(EpgInfo epgInfo){
    this._epgInfo = epgInfo;
  }

  @override
  _MediaEpgDetailPageState createState() => new _MediaEpgDetailPageState(_epgInfo);

}

class _MediaEpgDetailPageState extends State<MediaEpgDetailPage>{

  bool _detailLoading = false;
  bool _channelLoading = false;
  EpgInfo _epgInfo;
  List<EpgDetailInfo> _epgDetailList = [];
  ChannelInfo _channelInfo;
  Dio dio = new Dio();
  String localeStr = "en_US";

  _MediaEpgDetailPageState(EpgInfo epgInfo){
    this._epgInfo = epgInfo;
  }


  Future<void> _getEpgDetailData() async{
    setState(() {
      _detailLoading = true;
    });
    String url = Constant.URL_EPG_DETAIL + _epgInfo.channelId;
    Response response = await dio.get(url).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      List dataList = response.data['data'];
      if(mounted) {
        setState(() {
          _detailLoading = false;
          _epgDetailList = dataList.map((dataStr) {
            return new EpgDetailInfo.fromJson(dataStr);
          }).toList();
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _detailLoading = false;
        });
      }
    }
  }

  Future<void> _getChannelData() async{
    setState(() {
      _channelLoading = true;
    });
    String url = Constant.URL_CHANNEL + _epgInfo.channelId;
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
    _getEpgDetailData();
    _getChannelData();
  }

  Widget buildEpgPlayWidget(ChannelInfo channelInfo){
    var deviceSize = MediaQuery.of(context).size;
    if(channelInfo == null) {
      return new Container(
        width: deviceSize.width,
        height: deviceSize.width / 16 * 9,
        color: Colors.black,
      );
    }
    return new Chewie(
      new VideoPlayerController.network(
        channelInfo.url,
      ),
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


  Widget buildEpgDetailListItem(EpgDetailInfo epgDetailInfo, Size deviceSize){
    localeStr = Translations.of(context).currentLanguage + "_" +
        Translations.of(context).currentCountry;
    var currentSeconds = TimeUtil.currentTimeSeconds();
    Color bgColor = Colors.black;
    if(currentSeconds > epgDetailInfo.startTime && currentSeconds < epgDetailInfo.endTime){
      bgColor = Colors.green[400];
    }
    return new GestureDetector(
      onTap: (){
      },
      child: new Container(
        padding: EdgeInsets.all(3.0),
        child: new Row(
          children: <Widget>[
            Container(
              width: deviceSize.width / 5,
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    TimeUtil.toStrTimeWithLocaleStr(epgDetailInfo.startTime, localeStr),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.0,
                    ),
                  ),
                  Text(
                    TimeUtil.toStrTimeWithLocaleStr(epgDetailInfo.endTime, localeStr),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 3.0, right: 8.0),
                    width: 1.0,
                    height: 26.0,
                    color: Colors.grey,
                  ),
                  Text(
                    epgDetailInfo.label,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: bgColor,
                    ),
                  ),
                ],
              )
            ),
          ],
        )
      ),
    );
  }

  Widget buildTitleWidget(String title){
    return Container(
      width: double.infinity,
      color: Colors.black38,
      padding: EdgeInsets.all(3.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }


  Widget buildEpgDetailListWidget(List<EpgDetailInfo> _epgDetailList){
    var deviceSize = MediaQuery.of(context).size;
    return new Expanded(
      child: _detailLoading ?
        new Container(
          alignment: Alignment.center,
          child: new CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red)
          ),
        ):
        new RefreshIndicator(
          child: new ListView.builder(
            padding: EdgeInsets.all(3.0),
            itemCount: _epgDetailList.length,
            itemBuilder: (BuildContext context, int index) {
              if(index.isOdd){
                return const Divider();
              }
              return buildEpgDetailListItem(_epgDetailList[index], deviceSize);
            },
            ),
          onRefresh: _getEpgDetailData,
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
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text(_epgInfo.label),
      ),
      body: new Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildEpgPlayWidget(_channelInfo),
//            buildTitleWidget(_epgInfo.label),
            buildEpgDetailListWidget(_epgDetailList),
          ],
        ),
      ),
    );
  }


}