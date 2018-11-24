import 'package:flutter/material.dart';
import 'package:wi_ogsusu/entities/event_info.dart';

class MyEventItem extends StatelessWidget{

  EventInfo eventInfo;
  Function callBack;


  MyEventItem(this.eventInfo, this.callBack);

  @override
  Widget build(BuildContext context) {
    return buildEventItem(eventInfo);
  }

  Widget buildEventItem(EventInfo eventInfo){
    return GestureDetector(
      onTap: (){
        callBack();
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

}