import 'package:flutter/material.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/widget/page_loading_list8.dart';
import 'package:wi_ogsusu/common/http_master.dart';
import 'package:wi_ogsusu/entities/news2_info.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/page/page_web_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';


// ignore: must_be_immutable
class PageNews2 extends StatefulWidget{

  String category;

  PageNews2(this.category);

  @override
  _PageNews2State createState() => new _PageNews2State(category);

}

class _PageNews2State extends State<PageNews2> with AutomaticKeepAliveClientMixin {


  String category;

  bool _loading = false;
  List<News2Info> news2List = [];
  List<News2Info> bannerNews2List = [];
  int pageNum = 1;
  bool loadable = true;
  bool isLoadingMore = false;
  bool showLoadMore = true;
  ScrollController _listScrollController = ScrollController();


  _PageNews2State(this.category);

  Future<void> getData() async{
    getSpString(Constant.SP_KEY_COUNTRY).then((country){
      if(country == null){
        country = 'us';
      }
      _getSportsNewsData(country);
    });
  }

  Future<void> _getSportsNewsData(String country) async{
    setState(() {
      _loading = true;
      isLoadingMore = true;
    });
    String url = Constant.URL_NEWS2;
    HttpMaster.instance.get(url, data: {
      "category": category.toLowerCase(),
      "country": country,
      "pageNum": pageNum,
    }).then((result) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        isLoadingMore = false;
      });
      if (result.code != 200) {
        print(result.msg);
        setState(() {
          showLoadMore = false;
        });
        return;
      }
      List data = result.data;
      List<News2Info> dataList = data.map((item){
        return new News2Info.fromJson(item);
      }).toList();
      if(dataList == null || dataList.length <= 0){
        return;
      }
      setState(() {
        if(news2List.length >= 0) {
          news2List.addAll(dataList);
          pageNum ++;
        }else{
          news2List = dataList;
        }
        if(news2List.length >= 5) {
          bannerNews2List = new List<News2Info>.generate(5, (int index) {
            return news2List[index];
          });
        }else{
          bannerNews2List = new List<News2Info>.generate(news2List.length, (int index) {
            return news2List[index];
          });
        }
      });
    });
  }

  Future<void> _pullDownRefresh() async {
    pageNum = 1;
    news2List = [];
    getData();
    showLoadMore = true;
  }

  Future<void> _pullUpLoadMoreNewsData() async {
    if(!isLoadingMore) {
      getData();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _listScrollController.addListener(() {
      if (_listScrollController.position.pixels ==
          _listScrollController.position.maxScrollExtent) {
        _pullUpLoadMoreNewsData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  var bannerLinearGradient = LinearGradient(
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


  Widget buildBanner(){
    var deviceSize = MediaQuery.of(context).size;
    return new Container(
      width: deviceSize.width,
      height: deviceSize.width / 16 * 9,
      decoration: BoxDecoration(
        gradient: bannerLinearGradient,
      ),
      child: new CarouselSlider(
        items: bannerNews2List.map((news2Info) {
          return new Builder(
            builder: (BuildContext context) {
              return new GestureDetector(
                onTap: (){
                  showNews2Detail(news2Info);
                },
                child: new Card(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'res/img/hold.jpg',
                            image: news2Info.icon != null ? news2Info.icon : 'https://s1.ax1x.com/2018/12/12/FtSJKJ.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child:  Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: double.infinity,
                                color: Colors.black45,
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  news2Info.title != null? news2Info.title: '',
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

  void showNews2Detail(News2Info news2Info){
    if(news2Info.link == null){
      return;
    }
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new WebViewPage(news2Info.link);
    }));
  }

  Widget buildNews2ListItem(News2Info news2Info){
    var deviceSize = MediaQuery.of(context).size;
    return new GestureDetector(
      onTap: (){
        showNews2Detail(news2Info);
      },
      child: new Container(
        color: Color(0xFFeeeeee),
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
                        news2Info.title != null? news2Info.title: '',
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0
                        ),
                      ),
                      new Text(
                        news2Info.description != null? news2Info.description : '',
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
                          SizedBox(width: 3.0,),
                          new Text(
                            news2Info.releaseTime != null? TimeUtil.toStr(news2Info.releaseTime): '',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0
                            ),
                          ),
                          Expanded(child: Container(),),
                          new Text(
                            news2Info.source != null? news2Info.source: '',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0
                            ),
                          ),
                          SizedBox(width: 5.0,),
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
                      image: news2Info.icon != null ? news2Info.icon: 'https://s1.ax1x.com/2018/12/12/FtSJKJ.jpg',
                      fit: BoxFit.fill,
                    )
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
    return Container(
      color: Color(0xFFeeeeee),
      child: Center(
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
              SizedBox(width: 8.0,),
              CircularProgressIndicator(
                  strokeWidth: 1.0,
                  valueColor: AlwaysStoppedAnimation(Colors.deepOrange)
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(0xFFeeeeee),
      alignment: Alignment.center,
      child: _loading && news2List.length <= 0 ?
        LoadingList8Page() :
        new RefreshIndicator(
          child: new ListView.builder(
            controller: _listScrollController,
            itemCount: news2List.length > 5 ? news2List.length - 5 + 2: 1,
            itemBuilder: (BuildContext context, int index) {
              if(index == 0){
                return bannerNews2List != null && bannerNews2List.length > 0? buildBanner(): Container();
              }
              if(index < news2List.length - 5 + 1){
                return buildNews2ListItem(news2List[index + 5 - 1]);
              }else{
                return showLoadMore? _loadMoreWidget(): SizedBox(height: 0.0,);
              }
            },
          ),
          onRefresh: _pullDownRefresh,
        )
    );
  }


}