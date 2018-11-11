import 'package:flutter/material.dart';
import 'package:wi_ogsusu/generated/i18n.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/page/home/page_home.dart';
import 'package:wi_ogsusu/page/sports/page_sports.dart';
import 'package:wi_ogsusu/page/media/page_meida.dart';
import 'package:wi_ogsusu/page/mall/page_mall.dart';
import 'package:wi_ogsusu/page/my/page_my.dart';

class PageTab extends StatefulWidget {
  @override
  _PageTabState createState() => new _PageTabState();
}

class _PageTabState extends State<PageTab> {
  int _tabIndex = 0;

  List<Widget> _tabPages = [
    new Container(key: ObjectKey("home"), child: new HomePage()),
    new Container(key: ObjectKey("sport"), child: new SportsPage()),
    new Container(key: ObjectKey("media"), child: new MediaPage()),
    new Container(key: ObjectKey("mall"), child: new MallPage()),
    new Container(key: ObjectKey("my"), child: new MyPage()),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBarTitles = [
      Translations.of(context).text('home'),
      Translations.of(context).text('sports'),
      Translations.of(context).text('media'),
      Translations.of(context).text('mall'),
      Translations.of(context).text('my'),
//      S.of(context).home,
    ];
    return Scaffold(
        body: _tabPages[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          fixedColor: Colors.deepOrange,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home), title: new Text(appBarTitles[0])),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.border_all), title: new Text(appBarTitles[1])),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.tv), title: new Text(appBarTitles[2])),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.store_mall_directory), title: new Text(appBarTitles[3])),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.person), title: new Text(appBarTitles[4])),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabIndex,
          iconSize: 30.0,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ));
  }
}