import 'package:flutter/material.dart';
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

class _PageTabState extends State<PageTab> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  List<Widget> _pageList = [
    HomePage(),
    SportsPage(),
    MediaPage(),
    MallPage(),
    MyPage(),
  ];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _labels = [
      Translations.of(context).text('home'),
      Translations.of(context).text('sports'),
      Translations.of(context).text('media'),
      Translations.of(context).text('mall'),
      Translations.of(context).text('my'),
    ];
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pageList,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text(_labels[0])),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.pages), title: new Text(_labels[1])),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.tv), title: new Text(_labels[2])),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.store_mall_directory), title: new Text(_labels[3])),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.person), title: new Text(_labels[4])),
        ],
      ),
    );










//    var appBarTitles = [
//      Translations.of(context).text('home'),
//      Translations.of(context).text('sports'),
//      Translations.of(context).text('media'),
//      Translations.of(context).text('mall'),
//      Translations.of(context).text('my'),
////      S.of(context).home,
//    ];
//    return Scaffold(
//        body: _pageList[_tabIndex],
//        bottomNavigationBar: new BottomNavigationBar(
//          fixedColor: Colors.deepOrange,
//          items: <BottomNavigationBarItem>[
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.home), title: new Text(appBarTitles[0])),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.border_all), title: new Text(appBarTitles[1])),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.tv), title: new Text(appBarTitles[2])),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.store_mall_directory), title: new Text(appBarTitles[3])),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.person), title: new Text(appBarTitles[4])),
//          ],
//          type: BottomNavigationBarType.fixed,
//          currentIndex: _tabIndex,
//          iconSize: 30.0,
//          onTap: (index) {
//            setState(() {
//              _tabIndex = index;
//            });
//          },
//        ));
  }
}