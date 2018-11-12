import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wi_ogsusu/entities/news_info.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/page/search/page_search.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/widget/page_loading_list9.dart';
import 'page_news_detail.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => new _HomePageState();

}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{


  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  final HomeSearchDelegate _delegate = new HomeSearchDelegate();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _lastIntegerSelected;

  Dio dio = new Dio();
  bool _newsLoading = true;
  List<NewsInfo> _newsInfoList = [];
  int _currentHeadlineIndex = 0;
  int pageNum = 1;
  bool isLoadingMore = false;
  ScrollController _newsListScrollController = ScrollController();

  var hotLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: const <Color>[
      Color(0xFF0A0126),
      Color(0xFF0A0126),
      Color(0xFF130246),
      Color(0xFF1d036e),
      Color(0xFFeeeeee),
    ],
  );

  List<NewsInfo> _bannerNewsInfoList = [
    NewsInfo(0, '', '', '', '', '', '', 'http://', ''),
  ];

  List<String> headlines = [
    'Prefer Customer Program Office, Join now and we will waive the 1st years \$29.99 annual membership fee',
    'Prefer Customer Program Office, Join now and we will waive the 1st years \$29.99 annual membership fee'
  ];

  @override
  bool get wantKeepAlive => true;

  _showLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not open page, network connect error';
    }
  }

  Future<void> _pullDownRefresh() async {
    pageNum = 1;
    _newsInfoList = [];
    _getNewsData();
  }

  Future<void> _pullUpLoadMoreNewsData() async {
    if(!isLoadingMore) {
      _getNewsData();
    }
  }

  Future<void> _getNewsData() async{
    setState(() {
      _newsLoading = true;
      isLoadingMore = true;
    });
    String url = Constant.URL_NEWS;
    Response response = await dio.get(url, data: {
      "categoryId": "10",
      "pageNum": pageNum,
    }).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      List list = response.data['data'];
      if(mounted) {
        setState(() {
          _newsLoading = false;
          isLoadingMore = false;
          List<NewsInfo> dataList = list.map((dataStr) {
            return NewsInfo.fromJson(dataStr);
          }).toList();
          if(dataList == null || dataList.length <= 0){
            return;
          }
          if(_newsInfoList.length >= 0) {
            _newsInfoList.addAll(dataList);
            pageNum ++;
          }else{
            _newsInfoList = dataList;
          }

          if(_newsInfoList.length >= 5) {
            _bannerNewsInfoList = new List<NewsInfo>.generate(5, (int index) {
              return _newsInfoList[index];
            });
          }
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _newsLoading = false;
        });
      }
    }
  }

  Widget buildBanner(){
    var deviceSize = MediaQuery.of(context).size;
    return new Container(
      padding: EdgeInsets.only(top: 28.0),
      width: deviceSize.width,
      height: deviceSize.width / 16 * 9,
      decoration: BoxDecoration(
        gradient: hotLinearGradient,
      ),
      child: new CarouselSlider(
          items: _bannerNewsInfoList.map((newsInfo) {
            return new Builder(
              builder: (BuildContext context) {
                return new GestureDetector(
                  onTap: (){
                    showNewsDetail(newsInfo);
                  },
                  child: new Card(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'res/img/hold.jpg',
                            image: newsInfo.icon,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child:  Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              color: Colors.black45,
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                newsInfo.title,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    )
                  ),
                );
              },
            );
          }).toList(),
          autoPlay: true,
          interval: const Duration(milliseconds: 5000),
          autoPlayDuration: Duration(milliseconds: 600),
          viewportFraction: 0.9,
          aspectRatio: 16/9,
      ),
    );
  }

  void _clickHeadline(){
    print(headlines[_currentHeadlineIndex]);
    _showLink("http://www.golde.club");
  }

  void _headlineCallback(index){
    setState(() {
      _currentHeadlineIndex = index;
    });
  }

  Widget buildHeadline(){
    return new Container(
        width: double.infinity,
        height: 60.0,
//        margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 3.0),
        child: new Card(
          elevation: 3.0,
          shape: BorderDirectional(
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: new Row(
              children: <Widget>[
                Icon(Icons.fiber_new, color: Colors.red, size: 32.0,),
                SizedBox(width: 6.0,),
                Expanded(
                  child: new CarouselSlider(
                    items: headlines.map((headline) {
                      return new Builder(
                        builder: (BuildContext context) {
                          return Text(
                            headline,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      );
                    }).toList(),
                    autoPlay: true,
                    reverse: true,
                    interval: const Duration(milliseconds: 5000),
                    autoPlayDuration: Duration(milliseconds: 600),
                    viewportFraction: 1.0,
                    updateCallback: _headlineCallback,
                  ),
                ),
                SizedBox(width: 3.0,),
                Container(
                  color: Colors.grey,
                  width: 1.0,
                  height: 30.0,
                ),
                new IconButton(
                  iconSize: 32.0,
                  padding: EdgeInsets.all(3.0),
                  icon: new Icon(
                    Icons.more_horiz,
                  ),
                  color: Colors.deepPurple[500],
                  onPressed: (){
                    _clickHeadline();
                  }
                ),
              ],
            ),
          ),
        )
    );
  }

  void showNewsDetail(NewsInfo newsInfo){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new NewsDetailPage(newsInfo);
    }));
  }

  Widget buildNewsListItem(NewsInfo newsInfo){
    var deviceSize = MediaQuery.of(context).size;
    return new GestureDetector(
      onTap: (){
        showNewsDetail(newsInfo);
      },
      child: new Container(
          padding: EdgeInsets.all(3.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          newsInfo.title,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0
                          ),
                        ),
                        new Text(
                          newsInfo.description,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.0
                          ),
                        ),
                        SizedBox(height: 2.0,),
                        Row(
                          children: <Widget>[
                            new Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 3.0,),
                            new Text(
                              '0',
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0
                              ),
                            ),
                            SizedBox(width: 20.0,),
                            new Icon(
                              Icons.comment,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 3.0,),
                            new Text(
                              '0',
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: deviceSize.width / 3,
                    child: new AspectRatio(
                      aspectRatio: 16/11,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'res/img/hold.jpg',
                        image: newsInfo.icon,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.0,),
              Container(
                height: 0.5,
                color: Color(0xffcccccc),
              ),
              SizedBox(height: 3.0,)
            ],
          ),
      ),
    );
  }

  Widget _loadMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'loading more ...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
              valueColor: AlwaysStoppedAnimation(Colors.deepOrange)
            )
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    print("home init");
    _getNewsData();
    _newsListScrollController.addListener(() {
      if (_newsListScrollController.position.pixels ==
          _newsListScrollController.position.maxScrollExtent) {
        _pullUpLoadMoreNewsData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _newsListScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    double _appBarHeight = deviceSize.width /16 * 9;
    return _newsLoading && _newsInfoList.length <= 0 ?
      LoadingList9Page():
      new Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: new RefreshIndicator(
          onRefresh: _pullDownRefresh,
          child: new CustomScrollView(
            controller: _newsListScrollController,
            slivers: <Widget>[
              new SliverAppBar(
                backgroundColor: Color(0xFF0A0126),
                expandedHeight: _appBarHeight,
                automaticallyImplyLeading: false,
                pinned: _appBarBehavior == AppBarBehavior.pinned,
                floating: _appBarBehavior == AppBarBehavior.floating ||
                    _appBarBehavior == AppBarBehavior.snapping,
                snap: _appBarBehavior == AppBarBehavior.snapping,
                title: Text(
                  _appBarBehavior == AppBarBehavior.floating? '123': '',
                ),
                actions: <Widget>[

                ],
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text(
                    _appBarBehavior == AppBarBehavior.snapping? '123': '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  centerTitle: true,
                  background: new Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      buildBanner(),
                    ],
                  ),
                ),
              ),
              new SliverPadding(
                padding: new EdgeInsets.all(3.0),
                sliver: new SliverList(
                    delegate: new SliverChildListDelegate([
                      Container(
                        color: Color(0xFFeeeeee),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildHeadline(),
                          ],
                        ),
                      ),
                    ])
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 110.0,  // I'm forcing item heights
                delegate: SliverChildBuilderDelegate(
                      (context, index){
                        int itemLength = _newsInfoList.length - 5;
                        if (index < itemLength) {
                          return buildNewsListItem(_newsInfoList[index + 5]);
                        }
                        return _loadMoreWidget();
                      },
                  childCount: _newsInfoList.length - 5 + 1,
                ),
              ),
            ]
          )
        ),
      );
  }

}

