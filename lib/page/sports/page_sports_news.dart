import 'package:flutter/material.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/widget/page_loading_list8.dart';
import 'package:wi_ogsusu/common/http_master.dart';
import 'package:wi_ogsusu/entities/news2_info.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/page/page_web_view.dart';


// ignore: must_be_immutable
class PageSportsNews extends StatefulWidget{

  @override
  _PageSportsNewsState createState() => new _PageSportsNewsState();

}

class _PageSportsNewsState extends State<PageSportsNews> with AutomaticKeepAliveClientMixin {

  bool _loading = false;
  List<News2Info> news2List = [];
  int pageNum = 1;
  bool loadable = true;
  bool isLoadingMore = false;
  bool showLoadMore = true;
  ScrollController _listScrollController = ScrollController();

  Future<void> _getSportsNewsData() async{
    setState(() {
      _loading = true;
      isLoadingMore = true;
    });
    String url = Constant.URL_NEWS2;
    HttpMaster.instance.get(url, data: {
      "category": "sports",
      "country": "us",
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
      });
    });
  }

  Future<void> _pullDownRefresh() async {
    pageNum = 1;
    news2List = [];
    _getSportsNewsData();
    showLoadMore = true;
  }

  Future<void> _pullUpLoadMoreNewsData() async {
    if(!isLoadingMore) {
      _getSportsNewsData();
    }
  }

  Future<void> refreshData() async{
    _getSportsNewsData();
  }

  @override
  void initState() {
    super.initState();
    _getSportsNewsData();
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
                    child: news2Info.icon != null ? FadeInImage.assetNetwork(
                      placeholder: 'res/img/hold.jpg',
                      image: news2Info.icon,
                      fit: BoxFit.fill,
                    ): Image.asset('res/img/hold.jpg')
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
            SizedBox(width: 8.0,),
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
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.center,
        color: Color(0xffeeeeee),
        child: _loading && news2List.length <= 0 ?
          LoadingList8Page() :
          new RefreshIndicator(
            child: new ListView.builder(
              controller: _listScrollController,
              itemCount: news2List.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if(index < news2List.length){
                  return buildNews2ListItem(news2List[index]);
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