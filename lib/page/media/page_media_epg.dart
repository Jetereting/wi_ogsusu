import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/epg_info.dart';
import 'page_media_epg_detail.dart';
import 'package:flutter/services.dart';
import 'package:wi_ogsusu/common/utils/device_util.dart';
import 'package:wi_ogsusu/extension/token_master.dart';
import 'package:wi_ogsusu/widget/page_loading_list8.dart';

class MediaEpgPage extends StatefulWidget{

  @override
  _MediaEpgPageState createState() => new _MediaEpgPageState();

}

class _MediaEpgPageState extends State<MediaEpgPage> with AutomaticKeepAliveClientMixin{

  bool _loading = false;
  List<EpgInfo> epgList = [];
  Dio dio = new Dio();

  bool _loadable = true;

  @override
  bool get wantKeepAlive => true;

  Future<void> _getEpgData() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_EPGS;
    try {
      Response response = await dio.get(url, data: {
        'type': Constant.PARAM_TYPE,
        'agent': Constant.PARAM_AGENT,
        'platform': Constant.PARAM_PLATFORM,
      }).catchError((DioError e) {
        print("DioError: " + e.toString());
      });
      int code = response.data['code'];
      if (code == 200) {
        List dataList = response.data['data'];
        if (mounted) {
          setState(() {
            _loading = false;
            epgList = dataList.map((dataStr) {
              return EpgInfo.fromJson(dataStr);
            }).toList();
          });
        }
      } else {
        print(response.data['msg']);
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      }
    }catch (exception){
      print(exception);

    }
  }

  @override
  void initState() {
    super.initState();
    _getEpgData();
  }


  void itemClick(EpgInfo epgInfo){
    print(epgInfo.label);
    getStreamToken().then((token){
      String method = 'startPlayActivity%%' + epgInfo.channelId + "%%" + token;
      if(_loadable){
        if(DeviceUtil.isAndroid()){
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return new MediaEpgDetailPage(epgInfo);
          }));
        }else if(DeviceUtil.isIos()){
          const streamPlayPlugin = const MethodChannel('com.wiatec.ogsusu.video.player');
          streamPlayPlugin.invokeMethod(method);
        }
      }
    });
  }


  Widget buildEpgListItem(EpgInfo epgInfo){
    var deviceSize = MediaQuery.of(context).size;
    var now;
    if(epgInfo.currentPlay == null){
      now = 'Now: N/A';
    }else{
      now = 'Now: ' + epgInfo.currentPlay;
    }
    var next;
    if(epgInfo.nextPlay == null){
      next = 'Next: N/A';
    }else{
      next = 'Next: ' + epgInfo.nextPlay;
    }
    return new InkWell(
      onTap: (){
        itemClick(epgInfo);
      },
      child: new Container(
        color: Colors.transparent,
        width: double.infinity,
        padding: EdgeInsets.all(3.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  width: deviceSize.width / 4,
                  child: new AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: new Container(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'res/img/hold.jpg',
                        image: epgInfo.icon,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                new SizedBox(width: 10.0,),
                new Expanded(
                    child: new Container(
//                    width: iconWidth,
                      alignment: Alignment.topLeft,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            epgInfo.label,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            now,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            next,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ],
        )
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
        child: _loading && epgList.length <= 0 ?
        LoadingList8Page() :
          new RefreshIndicator(
            color: Colors.red,
            child: new ListView.builder(
              itemCount: epgList.length * 2,
              itemBuilder: (BuildContext context, int index) {
                if(index.isOdd){
                  return const Divider();
                }
                return buildEpgListItem(epgList[index ~/ 2]);
              },
            ),
            onRefresh: _getEpgData,
          )
    );
  }


}