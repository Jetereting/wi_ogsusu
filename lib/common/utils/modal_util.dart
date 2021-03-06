import 'package:flutter/material.dart';

void showError(BuildContext context, String msg){
  showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
    return new Container(
        color: Colors.black87,
        child: new Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Icon(Icons.highlight_off, color: Colors.red,),
              SizedBox(width: 8.0,),
              Expanded(
                child: new Text(' ' + msg,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                      color: Colors.red,
                      fontSize: 16.0
                  )
                ),
              ),
            ],
          ),
        )
    );
  });
}

void showNotice(BuildContext context, String msg) {
  showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
    return new Container(
        color: Colors.black87,
        child: new Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0,  top: 12.0, bottom: 12.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Icon(Icons.check, color: Colors.yellow,),
              SizedBox(width: 8.0,),
              Expanded(
                child: new Text(' ' + msg,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                      color: Colors.yellow,
                      fontSize: 16.0
                  )
                ),
              ),
            ],
          ),
        )
    );
  });
}


void showSuccess(BuildContext context, String msg){
  showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
    return new Container(
      color: Colors.black87,
      child: new Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top:12.0, bottom: 12.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Icon(Icons.check, color: Colors.green,),
            SizedBox(width: 8.0,),
            Expanded(
              child: new Text(' ' + msg,
                textAlign: TextAlign.left,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    color: Colors.green,
                    fontSize: 16.0
                )
              ),
            ),
          ],
        ),
      )
    );
  });
}