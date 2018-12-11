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
import 'dart:io';
import 'package:wi_ogsusu/entities/vex_genres_info.dart';
import 'package:wi_ogsusu/entities/vex_movie_info.dart';
import 'package:wi_ogsusu/entities/vex_movie_play_info.dart';
import 'page_media_vex_movie_play.dart';
import 'dart:async';
import 'dart:convert';


class PageVexMovie extends StatefulWidget{

  @override
  _PageVexMovieState createState() => new _PageVexMovieState();

}

class _PageVexMovieState extends State<PageVexMovie> with AutomaticKeepAliveClientMixin{

  bool _loading = false;
  bool _plaUrlLoading = false;
  bool noData = false;

  List<VexGenresInfo> vexGenresList = [];
  List<VexMovieInfo> vexMovieList = [];
  List<String> vexYearList = ['All'];

  String currentGenres = 'Recently';
  String currentYear = '2018';

  @override
  bool get wantKeepAlive => true;

  Future<void> _getVexGenresData() async {
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_VEX_MOVIES_GENRES;
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
        vexGenresList = dataList.map((dataStr) {
          return VexGenresInfo.fromJson(dataStr);
        }).toList();
      });
    });
  }

  Future<void> _getVexMoviesData() async {
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_VEX_MOVIES;
    HttpMaster.instance.get(url, data: {
      'genres': currentGenres,
      'releaseYear': currentYear,
    }).then((result) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      int code = result.code;
      if (code != 200) {
        setState(() {
          vexMovieList = [];
          noData = true;
        });
        return;
      }
      setState(() {
        List dataList = result.data;
        vexMovieList = dataList.map((dataStr) {
          return VexMovieInfo.fromJson(dataStr);
        }).toList();
      });
    });
  }


  void generateYears(){
    for (int i = 2018 ; i >= 1970; i --){
      vexYearList.add(i.toString());
    }
  }


  Future<void> _getVexMoviePlayUrl(VexMovieInfo movieInfo) async {
    setState(() {
      _plaUrlLoading = true;
    });
    String str = Constant.URL_VEX_MOVIE_PLAY_URL + movieInfo.link;
    HttpMaster.instance.getNative(str).then((result) {
      if (!mounted) {
        return;
      }
      int code = result.code;
      if (code != 200) {
        print(result.data);
        return;
      }
      var d = json.decode(result.data);
      int rc = d['error_code'];
      if(rc != 0){
        return;
      }
      List dataList = d['data'];
      List<VexMoviePlayInfo> playList = dataList.map((item){
        return VexMoviePlayInfo.fromJson(item);
      }).toList();
      if(playList == null || playList.length <= 0){
        return;
      }
      VexMoviePlayInfo vexMoviePlayInfo = playList[0];
      if(vexMoviePlayInfo.type != 5){
        playVexMovie(vexMoviePlayInfo.url, movieInfo.label);
      }else{
        replyUrl(vexMoviePlayInfo.url, movieInfo.label);
      }
    });

  }

  @override
  void initState() {
    super.initState();
    generateYears();
    _getVexGenresData();
    _getVexMoviesData();
  }

  void replyUrl(String url, String label){
    print(url);
    HttpMaster.instance.getResponse(url).then((response){
      List<String> rr = response.data.toString().split('\n');
      String url1 = rr[2];
      print(url1);
      if(url1 != null && url1.length > 0){
        playVexMovie(url1, label);
      }
    });
  }

  void playVexMovie(String url, String label){
    setState(() {
      _plaUrlLoading = false;
    });
    if(!mounted){
      return;
    }
    print(url);
    if(DeviceUtil.isAndroid()){
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
        return new VexMoviePlayPage(url, label);
      }));
    }else if(DeviceUtil.isIos()){
      String method = 'startVexPlayer%%' + url + '%%' + label;
      const vexPlayPlugin = const MethodChannel('com.wiatec.ogsusu.vex.player');
      vexPlayPlugin.invokeMethod(method);
    }
  }

  Widget buildGenresListItem(VexGenresInfo genresInfo){
    return Container(
      child: new ChoiceChip(
        key: new ValueKey<String>(genresInfo.label),
        padding: EdgeInsets.all(1),
        backgroundColor: Colors.grey,
        label: new Text(genresInfo.label),
        labelStyle: TextStyle(
        fontSize: 11.0,
        color: Colors.white
        ),
        selected: currentGenres == genresInfo.label,
        selectedColor: Colors.redAccent[400],
        onSelected: (bool value) {
          setState(() {
            currentGenres = value ? genresInfo.label : '';
            _getVexMoviesData();
        });
        },
      ),
    );
  }

  Widget buildGenresList(){
    return Container(
      child: Row(
        children: <Widget>[
          Text('Genres: '),
          Expanded(
            child:  new ListView.builder(
              itemCount: vexGenresList.length * 2 + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if(index == 0){
                  return SizedBox(width: 0.0,);
                }
                if(index.isEven){
                  return SizedBox(width: 5.0,);
                }
                return buildGenresListItem(vexGenresList[index ~/ 2]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildYearListItem(String year){
    return Container(
      child: new ChoiceChip(
        key: new ValueKey<String>(year),
        padding: EdgeInsets.all(1),
        backgroundColor: Colors.grey,
        label: new Text(year),
        labelStyle: TextStyle(
            fontSize: 11.0,
            color: Colors.white
        ),
        selected: currentYear == year,
        selectedColor: Colors.redAccent[400],
        onSelected: (bool value) {
          setState(() {
            currentYear = value ? year : '';
            _getVexMoviesData();
          });
        },
      ),
    );
  }

  Widget buildYearList(){
    return Container(
      child: Row(
        children: <Widget>[
          Text('Year: '),
          Expanded(
            child:  new ListView.builder(
              itemCount: vexYearList.length * 2 + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if(index == 0){
                  return SizedBox(width: 0.0,);
                }
                if(index.isEven){
                  return SizedBox(width: 5.0,);
                }
                return buildYearListItem(vexYearList[index ~/ 2]);
              },
            ),
          )
        ],
      ),
    );
  }

  void itemClick(VexMovieInfo movieInfo){
    _getVexMoviePlayUrl(movieInfo);
  }

  Widget buildMovieListItem(VexMovieInfo movieInfo){
    return new GestureDetector(
      onTap: (){
        itemClick(movieInfo);
      },
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new AspectRatio(
                aspectRatio: 9.0 / 14.0,
                child: new Container(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'res/img/hold.jpg',
                    image: movieInfo.icon,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Text(
              movieInfo.label,
              textAlign: TextAlign.start,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            new Expanded(child: SizedBox()),
            Row(
              children: <Widget>[
                Text(
                  movieInfo.genres,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.deepOrange,
                  ),
                ),
                new Expanded(child: SizedBox()),
                Text(
                  movieInfo.releaseYear,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.center,
        child: _loading && vexMovieList.length <= 0?
        LoadingList8Page() :
        new RefreshIndicator(
          onRefresh: _getVexMoviesData,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 5.0,),
                  Container(
                    height: 45.0,
                    child: buildGenresList(),
                  ),
                  Container(
                    height: 45.0,
                    child: buildYearList(),
                  ),
                  Expanded(
                      child: vexMovieList.length > 0? new GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 4.0,
                        padding: const EdgeInsets.all(4.0),
                        childAspectRatio: 9/18,
                        children: vexMovieList.map((VexMovieInfo movieInfo) {
                          return buildMovieListItem(movieInfo);
                        }).toList(),
                      )
                          : noData ? Container(
                        alignment: Alignment.center,
                        child: new Column(
                          children: <Widget>[
                            SizedBox(height: 60.0,),
                            Image.asset('res/img/icon_sad_80.png', width: 40.0, height: 40.0,),
                            Text(
                              "No data yet!",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),

                          ],
                        ),
                      )
                          : Container()
                  ),
                ],
              ),
              _plaUrlLoading? Container(
                color: Colors.black54,
                child: Center(
                  child: new CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.deepOrange)
                  ),
                ),
              ): SizedBox(),
            ],
          ),
          
          
          
        )
    );
  }


}