import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/common/utils/color_util.dart';
import 'package:wi_ogsusu/entities/tool_info.dart';
import 'package:wi_ogsusu/entities/event_info.dart';
import 'package:wi_ogsusu/page/page_web_view.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';

class MyPage extends StatefulWidget{
  @override
  MyPageState createState() => new MyPageState();

}

class MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin{

  String _username = 'no login';
  String _repCode = '';
  String _validTime = '';
  List<ToolInfo> _toolList = [
    ToolInfo('check_in', 'res/img/icons8_calendar_plus_96.png', 1),
    ToolInfo('vip', 'res/img/icons8_vip_96.png', 2),
    ToolInfo('coins', 'res/img/icons8_cheap_96.png', 3),
    ToolInfo('credit_card', 'res/img/icons8_card_security_96.png', 4),
  ];

  List<EventInfo> _eventList = [
    EventInfo()
      ..type = 1
      ..label = ''
      ..icon = 'https://s1.ax1x.com/2018/11/22/FPuBnJ.jpg'
      ..link = 'http://www.golde.club'
      ..labelVisible = true,
    EventInfo()
      ..type = 1
      ..label = ''
      ..icon = 'https://s1.ax1x.com/2018/11/22/FPur7R.jpg'
      ..link = 'http://www.golde.club'
      ..labelVisible = true,
    EventInfo()
      ..type = 1
      ..label = ''
      ..icon = 'https://s1.ax1x.com/2018/11/22/FPuwX4.jpg'
      ..link = 'http://www.golde.club'
      ..labelVisible = true,
  ];

  @override
  void initState() {
    super.initState();
    getLocalUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;


  getLocalUserInfo() async{
    var name = await getSpString(Constant.SP_KEY_USERNAME);
    var repCode = await getSpString(Constant.SP_KEY_REP_CODE);
    var validTime = await getSpString(Constant.SP_KEY_VALID_TIME);
    setState(() {
      if(name != null) {
        _username = name;
      }
      if(repCode != null) {
        _repCode = repCode;
      }
      if(validTime != null) {
        _validTime = validTime.substring(0,10);
      }
    });
  }

  logout() async{
    await setSpInt('userId', 0);
    Navigator.of(context).pushNamed('/main');
  }

  void clickToolGridItem(ToolInfo toolInfo){
    print(toolInfo);
  }

  Widget buildToolItem(ToolInfo toolInfo){
    return GestureDetector(
      onTap: (){
        clickToolGridItem(toolInfo);
      },
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 0.0, top: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(toolInfo.icon, width: 48.0,),
            Text(
              Translations.of(context).text(toolInfo.label),
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clickEventItem(EventInfo eventInfo){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new WebViewPage(eventInfo.link);
    }));
  }

  Widget buildEventItem(EventInfo eventInfo){
    return GestureDetector(
      onTap: (){
        clickEventItem(eventInfo);
      },
      child: Container(
        child: Card(
          elevation: 2.0,
          child: Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 2.2/1,
                child: FadeInImage.assetNetwork(
                  placeholder: 'res/img/hold.jpg',
                  image: eventInfo.icon,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    eventInfo.labelVisible? eventInfo.label: '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    Widget sectionAvatar = new AspectRatio(
      aspectRatio: 5/1.5,
      child: new Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 5/1.5,
            child: Image.asset(
              'res/img/bg_my_header4.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 80.0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 20.0,),
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: ColorUtils.nameToColor(_username),
                  backgroundImage: AssetImage(
                      'res/img/avatar_hold.png'
                  )
                ),
                SizedBox(width: 15.0,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _username,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 3.0,),
                    Text(
                      Translations.of(context).text('ValidTime') + _validTime,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 3.0,),
                    Text(
                      Translations.of(context).text('RepCode') + _repCode,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget sectionTool = new Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 13.0, bottom: 8.0, left: 8.0, right: 8.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _toolList.map((ToolInfo toolInfo) {
            return buildToolItem(toolInfo);
          }).toList()
        ),
      )
    );

    Widget sectionEvent = new Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        height: 140.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                Translations.of(context).text('popular_events'),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height: 2.0,),
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: _eventList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return buildEventItem(_eventList[index]);
                },
              ),
            )
          ],
        ),
//        child: new ListView.builder(
//          itemCount: _eventList.length,
//          scrollDirection: Axis.horizontal,
//          itemBuilder: (BuildContext context, int index) {
//            return buildEventGridItem(_eventList[index]);
//          },
//        ),
    );

    Widget btnLogout = new Container(
      width: double.infinity,
      margin: new EdgeInsets.only(top: 5.0),
      padding: new EdgeInsets.all(20.0),
      child: new RawMaterialButton(
        disabledElevation: 10.0,
        onPressed: () {
          logout();
        },
        elevation: 6.0,
        constraints: new BoxConstraints(minHeight: 46.0),
        fillColor: Colors.deepOrange[700],
        splashColor: Colors.white,
        child: new Text(
          Translations.of(context).text('logout'),
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0
          ),
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: new Column(
        children: <Widget>[
          sectionAvatar,
          sectionTool,
          SizedBox(height: 4.0,),
          sectionEvent,
          Expanded(child: SizedBox(),),
          btnLogout,
        ],
      )
    );
  }


}