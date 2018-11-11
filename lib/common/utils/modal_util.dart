import 'package:flutter/material.dart';

void showError(BuildContext context, String msg){
  showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
    return new Container(
        color: Colors.black87,
        child: new Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Icon(Icons.highlight_off, color: Colors.red,),
              new Text(' ' + msg,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                      color: Colors.red,
                      fontSize: 16.0
                  )
              ),
            ],
          ),
        )
    );
  });
}

void showNotice(BuildContext context, String msg){
  showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
    return new Container(
      color: Colors.black87,
      child: new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Icon(Icons.check, color: Colors.yellow,),
            new Text(' ' + msg,
                textAlign: TextAlign.left,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    color: Colors.yellow,
                    fontSize: 16.0
                )
            ),
          ],
        ),
      )
    );
  });
}

