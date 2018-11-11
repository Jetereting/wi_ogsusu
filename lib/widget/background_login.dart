import 'package:flutter/material.dart';
import 'package:wi_ogsusu/common/utils/arc_clipper.dart';

class BackgroundLogin extends StatelessWidget {
  final showIcon;
  final icon;
  BackgroundLogin({this.showIcon = true, this.icon});

  Widget topHalf(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new Flexible(
      flex: 2,
      child: ClipPath(
        clipper: new ArcClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Color(0xFF451671),
                      Color(0xFF0A0126),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
            ),
            showIcon ? new Center(
              child: SizedBox(
//                height: deviceSize.height / 7,
//                width: deviceSize.width / 4,
                child: Image.asset(
                  'res/img/icon_ogsusu.png',
                  fit: BoxFit.fill,
                  width: 88.0,
                  height: 88.0,
                )
              )
            ): new Container(
              width: double.infinity,
              child: icon != null ? Image.network(
                icon,
                fit: BoxFit.cover,
              ): new Container(

              )
            )
          ],
        ),
      ),
    );
  }

  final bottomHalf = new Flexible(
    flex: 3,
    child: new Container(),
  );

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }
}