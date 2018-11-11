import 'package:flutter/material.dart';
import 'package:wi_ogsusu/navigator.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:fluro/fluro.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/common/utils/color_util.dart';

class MyPage extends StatefulWidget{
  @override
  MyPageState createState() => new MyPageState();

}

class MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin{

  String username = 'no login';

  @override
  void initState() {
    super.initState();
    getLocalUserInfo();
  }

  getLocalUserInfo() async{
    var name = await getSpString('username');
    setState(() {
      if(name != null) {
        username = name;
      }
    });
  }



  logout() async{
    await setSpInt('userId', 0);
    Navigator.of(context).pushNamed('/main');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    Widget sectionAvatar = new AspectRatio(
      aspectRatio: 5/2,
      child: new Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Image.asset(
            'res/img/bg_my_header4.jpg',
          ),
          Container(
            height: 70.0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 20.0,),
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: ColorUtils.nameToColor(username),
                  backgroundImage: AssetImage(
                      'res/img/avatar_hold.png'
                  )
                ),
                SizedBox(width: 20.0,),
                Column(
                  children: <Widget>[
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 26.0,
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
          'Logout',
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0
          ),
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Column(
        children: <Widget>[
          sectionAvatar,
          btnLogout,
        ],
      )
    );
  }


}