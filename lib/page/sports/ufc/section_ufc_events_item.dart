import 'package:flutter/material.dart';
import 'package:wi_ogsusu/entities/ufc_event_info.dart';

class UfcEventItem extends StatelessWidget{

  UfcEventInfo ufcEventInfo;
  Function callBack;


  UfcEventItem(this.ufcEventInfo, this.callBack);

  @override
  Widget build(BuildContext context) {
    return buildItem(ufcEventInfo);
  }

  Widget buildItem(UfcEventInfo ufcEventInfo){
    return GestureDetector(
      onTap: (){
        callBack();
      },
      child: Container(
        width: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 200.0,
              height: 100,
              child: ufcEventInfo.feature_image != null ? FadeInImage.assetNetwork(
                placeholder: 'res/img/hold.jpg',
                image: ufcEventInfo.feature_image,
                fit: BoxFit.cover,
              ): Image.asset('res/img/hold.jpg', fit: BoxFit.fill,),
            ),
            Text(
              ufcEventInfo.title_tag_line,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black87
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  ufcEventInfo.event_date != null? ufcEventInfo.event_date.substring(0, 10): '',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey
                  ),
                ),
                Expanded(child: Container(),),
                Text(
                  ufcEventInfo.ticket_seller_name != null? ufcEventInfo.ticket_seller_name: '',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}