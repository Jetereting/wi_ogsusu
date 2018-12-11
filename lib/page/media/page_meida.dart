import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'page_media_epg.dart';
import 'page_media_movie.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/extension/token_master.dart';
import 'package:wi_ogsusu/common/utils/modal_util.dart';
import 'package:wi_ogsusu/page/page_feature_activate.dart';
import 'page_local_media.dart';
import 'page_media_vex_movie.dart';


class MediaInfo{

  int id;
  String label;
  MediaInfo(this.id, this.label);

}

class MediaPage extends StatefulWidget{


  bool showAllSection = false;


  MediaPage(this.showAllSection);

  @override
  _MediaPageState createState() => new _MediaPageState(showAllSection);

}

class _MediaPageState extends State<MediaPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  List<MediaInfo> _tabs = <MediaInfo>[];

  List<MediaInfo> _tabs1 = <MediaInfo>[
    new MediaInfo(1, Constant.MOVIES),
  ];

  List<MediaInfo> _tabs2 = <MediaInfo>[
    new MediaInfo(2, Constant.LIVETV),
    new MediaInfo(3, Constant.MOVIES_PLUS),
  ];


  bool showAllSection = false;

  _MediaPageState(this.showAllSection);


  List<Widget> mediaTabPages (){
    return _tabs.map((MediaInfo mediaInfo) {
      if(mediaInfo.id == 1){
        return MediaMoviePage();
      }else if(mediaInfo.id == 2){
        return MediaEpgPage();
      }else if(mediaInfo.id == 3){
        return PageVexMovie();
      }else {
        return new Container(
            color: Color(0xFFEEEEEE),
            key: new ObjectKey(mediaInfo.label),
            padding: const EdgeInsets.all(12.0),
            child: new Card(
                child: new Center(
                    child: new Text(
                        "no data"
                    )
                )
            )
        );
      }
    }).toList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  //局部变量，选择页面
  MediaInfo _selectedTab;

  @override
  void initState() {
    super.initState();
    if(showAllSection){
      _tabs = _tabs2;
    }else{
      _tabs = _tabs1;
    }
    _tabController = new TabController(vsync: this, length: _tabs.length);
    _tabController.addListener(_handleTabSelection);
    _selectedTab = _tabs[0];
    makeStreamToken();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTab = _tabs[_tabController.index];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent[400],
        title: new Text(Translations.of(context).text('media')),
        centerTitle: false,
        bottom: new TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Color(0xFFEEEEEE),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: _tabs.map((MediaInfo mediaInfo) {
              return new Tab(
                child: new Container(
                  child: Text(
                    Translations.of(context).text(mediaInfo.label),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            }).toList()
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              getSpBool(Constant.SP_KEY_MEDIA_ACTIVATED).then((load){
                if(load){
                  showNotice(context, 'new feature was activated');
                }else{
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                    return new PageFeatureActivate(2);
                  }));
                }
              });
            },
          ),
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: mediaTabPages(),
      ),
    );

//    return new Column(
//      children: <Widget>[
//        Container(
//          color: Colors.redAccent[400],
//            width: double.infinity,
//          height: 36.0,
//        ),
//        Container(
//          color: Colors.redAccent[400],
//          width: double.infinity,
//          height: 26.0,
//          alignment: Alignment.center,
//          child: new TabBar(
//              controller: _tabController,
//              isScrollable: true,
//              indicatorColor: Color(0xFFFFFFFF),
//              indicatorWeight: 3.0,
//              labelColor: Colors.white,
//              labelStyle: TextStyle(
//                fontWeight: FontWeight.w500
//              ),
//              unselectedLabelColor: Colors.white54,
//              tabs: _tabs.map((MediaInfo mediaInfo) {
//                return new Tab(
//                  child: new Container(
//                    child: Text(
//                      Translations.of(context).text(mediaInfo.label),
//                      style: TextStyle(
//                        fontSize: 16.0,
//                      ),
//                    ),
//                  ),
//                );
//              }).toList()
//          ),
//        ),
//        Expanded(
//            child: new TabBarView(
//              controller: _tabController,
//              children: mediaTabPages(),
//            ),
//        )
//      ],
//    );
  }


}