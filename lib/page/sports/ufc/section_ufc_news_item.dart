import 'package:flutter/material.dart';
import 'package:wi_ogsusu/entities/ufc_news_info.dart';

class UfcNewsItem extends StatelessWidget{

  UfcNewsInfo ufcNewsInfo;
  Function callBack;


  UfcNewsItem(this.ufcNewsInfo, this.callBack);

  @override
  Widget build(BuildContext context) {
    return buildItem(ufcNewsInfo);
  }

  Widget buildItem(UfcNewsInfo ufcNewsInfo){
    return GestureDetector(
      onTap: (){
        callBack();
      },
      child: Container(
        width: 180.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 180.0,
              height: 120,
              child: ufcNewsInfo.thumbnail != null ? FadeInImage.assetNetwork(
                placeholder: 'res/img/hold.jpg',
                image: ufcNewsInfo.thumbnail,
                fit: BoxFit.cover,
              ): Image.asset('res/img/hold.jpg', fit: BoxFit.fill,),
            ),
            Text(
              ufcNewsInfo.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black87
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  ufcNewsInfo.article_date != null? ufcNewsInfo.article_date.substring(0, 10): '',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey
                  ),
                ),
                Expanded(child: Container(),),
                Text(
                  ufcNewsInfo.author != null? ufcNewsInfo.author: '',
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