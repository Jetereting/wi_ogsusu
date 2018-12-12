import 'package:flutter/material.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/constant.dart';
import 'page_news2.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  bool showAllSection = false;

  List<String> _categories = <String>['general', 'business', 'technology', 'science', 'health', 'entertainment'];
  List<Widget> _tabPages;
  String currentCategory = 'general';


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;


  void initState() {
    super.initState();
    initTabPages();
    _tabController = new TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void initTabPages(){
    _tabPages = _categories.map((category){
      return PageNews2(category);
    }).toList();
  }


  void _handleTabSelection() {
    setState(() {
      currentCategory = _categories[_tabController.index];
    });
  }

  void showMenuSelection(String value){
    setState(() {
      setSpString(Constant.SP_KEY_COUNTRY, value);
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        elevation: 6.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF0A0126),
        title: new Text(Translations.of(context).text('home')),
        centerTitle: false,
        bottom: new TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: _categories.map((String category) {
              return new Tab(
                child: new Container(
                  child: Text(
                    Translations.of(context).text(category),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            }).toList()
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.language),
            onSelected: showMenuSelection,
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                  value: 'us',
                  child: Text('USA')
              ),
              const PopupMenuItem<String>(
                  value: 'cn',
                  child: Text('中文')
              ),
              const PopupMenuItem<String>(
                  value: 'cz',
                  child: Text('Česká')
              ),
              const PopupMenuItem<String>(
                  value: 'mx',
                  child: Text('Mexico')
              ),
            ],
          ),
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: _tabPages
      ),
    );
  }

}

