import 'package:flutter/material.dart';
import 'package:wi_ogsusu/page/my/check_in/page_check_in.dart';

class CheckInNoticeDialog extends Dialog {

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(45.0),
      child: new Material(
        type: MaterialType.transparency,
        child: Container(
          child: AspectRatio(aspectRatio: 3 /5,
            child: Stack(
              children: <Widget>[
                Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                          return new CheckInPage();
                        }));
                      },
                      child: Image.asset('res/img/check_in.png', fit: BoxFit.cover,),
                    )
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.only(top: 50.0),
                      child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.white, size: 30.0,),
                          onPressed: (){
                            Navigator.pop(context);
                          }
                      ),
                    )
                )
              ],
            ),
          ),
        )
      ),
    );
  }

}
