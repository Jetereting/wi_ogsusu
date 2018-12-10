import 'package:flutter/material.dart';
import 'package:wi_ogsusu/entities/ufc_fighter_info.dart';

class UfcFighterItem extends StatelessWidget{

  UfcFighterInfo ufcFighterInfo;
  Function callBack;


  UfcFighterItem(this.ufcFighterInfo, this.callBack);

  @override
  Widget build(BuildContext context) {
    return buildItem(ufcFighterInfo);
  }

  Widget buildItem(UfcFighterInfo ufcFighterInfo){
    return GestureDetector(
      onTap: (){
        callBack();
      },
      child: Container(
        width: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80,
              child: ufcFighterInfo.thumbnail != null ? FadeInImage.assetNetwork(
                placeholder: 'res/img/hold.jpg',
                image: ufcFighterInfo.thumbnail,
                fit: BoxFit.cover,
              ): Image.asset('res/img/hold.jpg', fit: BoxFit.fill,),
            ),
            Text(
              ufcFighterInfo.first_name + ufcFighterInfo.last_name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.black87
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50.0,
                  child: Text(
                    ufcFighterInfo.weight_class != null? ufcFighterInfo.weight_class: '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.grey
                    ),
                  ),
                ),
                Expanded(child: Container(),),
                Text(
                  ufcFighterInfo.wins.toString(),
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.green
                  ),
                ),
                Text(
                  '/',
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.black87
                  ),
                ),
                Text(
                  ufcFighterInfo.losses.toString(),
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.red
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