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
import 'package:wi_ogsusu/common/http_master.dart';


class MediaEpgPage extends StatefulWidget{

  @override
  _MediaEpgPageState createState() => new _MediaEpgPageState();

}

class _MediaEpgPageState extends State<MediaEpgPage> with AutomaticKeepAliveClientMixin{

  bool _loading = false;
  List<EpgInfo> epgList = [];
  List<EpgInfo> currentEpgList = [];

  bool _loadable = true;

  @override
  bool get wantKeepAlive => true;

  Future<void> _getEpgData() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_EPGS;
    HttpMaster.instance.get(url, data: {
      'type': "2",
      'agent': "101",
      'platform': "3",
    }).then((result) {
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
        epgList = dataList.map((dataStr) {
          return EpgInfo.fromJson(dataStr);
        }).toList();
        currentEpgList = epgList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getEpgData();
  }

  @override
  void deactivate() {
    super.deactivate();
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
      now = 'Now: Local Programming...';
    }else{
      now = 'Now: ' + epgInfo.currentPlay;
    }
    var next;
    if(epgInfo.nextPlay == null){
      next = 'Next: Local Programming...';
    }else{
      next = 'Next: ' + epgInfo.nextPlay;
    }
    return new Container(
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
                new IconButton(
                  icon: Icon(Icons.play_circle_outline, color: Colors.black54, size: 30.0,),
                  onPressed: (){
                    itemClick(epgInfo);
                  }
                )
              ],
            ),
          ],
        )
    );
  }

  void filterEpgList(String key){
    if(key == null || key.length <= 0 || key == '' || key == ' '){
      setState(() {
        currentEpgList = epgList;
      });
    }
    setState(() {
      currentEpgList =
          epgList.where((epgInfo){
            return epgInfo.label.toLowerCase().contains(key.toLowerCase());
          }).toList();
    });
  }

  Widget buildFilter(){
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 3.0),
      width: double.infinity,
      height: 45.0,
      child: new TextField(
        style: new TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.pink),
          ),
          contentPadding: EdgeInsets.all(8.0),
          hintText: Translations.of(context).text('search'),
          suffixIcon: Icon(Icons.search, color: Colors.grey, size: 24.0,),
        ),
        autofocus: false,
        onChanged: (String str){
          filterEpgList(str);
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
        child: _loading && currentEpgList.length <= 0 ?
        LoadingList8Page() :
          new RefreshIndicator(
            color: Colors.red,
            child: new ListView.builder(
              itemCount: currentEpgList.length * 2 + 1,
              itemBuilder: (BuildContext context, int index) {
                if(index == 0){
                  return buildFilter();
                }
                if(index.isEven){
                  return const Divider();
                }
                return buildEpgListItem(currentEpgList[index ~/ 2]);
              },
            ),
            onRefresh: _getEpgData,
          )
    );
  }


}