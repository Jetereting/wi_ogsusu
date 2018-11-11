import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/common/utils/modal_util.dart';
import 'package:wi_ogsusu/entities/news_info.dart';
import 'package:wi_ogsusu/entities/news_detail_info.dart';
import 'package:wi_ogsusu/widget/page_loading_list7.dart';

// ignore: must_be_immutable
class NewsDetailPage extends StatefulWidget{

  NewsInfo _newsInfo;

  NewsDetailPage(NewsInfo newsInfo){
    this._newsInfo = newsInfo;
  }

  @override
  NewsDetailPageState createState() => new NewsDetailPageState(_newsInfo);

}


enum AppBarBehavior { normal, pinned, floating, snapping }

class NewsDetailPageState extends State<NewsDetailPage> with AutomaticKeepAliveClientMixin{


  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  NewsInfo _newsInfo;
  NewsDetailInfo _newsDetailInfo;
  Dio dio = new Dio();
  bool _detailLoading = true;




  NewsDetailPageState(NewsInfo newsInfo){
    this._newsInfo = newsInfo;
  }

  @override
  void initState() {
    super.initState();
    _getNewsDetailData(_newsInfo.newsId);
  }

  @override
  bool get wantKeepAlive => true;


  _getNewsDetailData(String newsId) async {
    setState(() {
      _detailLoading = true;
    });
    String url = Constant.URL_NEWS_DETAIL + newsId;
    Response response = await dio.get(url)
        .catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      var data = response.data['data'];
      if(mounted) {
        setState(() {
          _detailLoading = false;
          _newsDetailInfo = NewsDetailInfo.fromJson(data);
//          print(_newsDetailInfo);
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


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    double _appBarHeight = deviceSize.width /16 * 9;
//    return Scaffold(
//      appBar: AppBar(
//
//      ),
//      body:
//    );
    return new Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.border_color, color: Colors.white),
      ),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            backgroundColor: Color(0xFF0A0126),
            expandedHeight: _appBarHeight,
            pinned: _appBarBehavior == AppBarBehavior.pinned,
            floating: _appBarBehavior == AppBarBehavior.floating ||
                _appBarBehavior == AppBarBehavior.snapping,
            snap: _appBarBehavior == AppBarBehavior.snapping,
            title: new Text(
              _newsInfo.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            flexibleSpace: new FlexibleSpaceBar(
              centerTitle: true,
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'res/img/hold.jpg',
                      image: _newsInfo.icon,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverPadding(
            padding: new EdgeInsets.all(3.0),
            sliver: new SliverList(
                delegate: new SliverChildListDelegate([
                  _detailLoading ? LoadingList7Page():
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _newsDetailInfo != null && _newsDetailInfo.content.length > 0 ?
                        _newsDetailInfo.content :
                        _newsInfo.description,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0,),
                    ],
                  ),
                ])
            ),
          ),
        ]
      ),
    );
  }

}