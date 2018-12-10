import 'package:flutter/material.dart';
import 'package:wi_ogsusu/entities/ufc_event_info.dart';
import 'package:wi_ogsusu/entities/ufc_news_info.dart';
import 'package:wi_ogsusu/entities/ufc_fighter_info.dart';
import 'section_ufc_events_item.dart';
import 'section_ufc_news_item.dart';
import 'section_ufc_fighter_item.dart';
import 'package:wi_ogsusu/page/page_web_view.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionUfc extends StatelessWidget{

  List<UfcEventInfo> ufcEventList;
  List<UfcNewsInfo> ufcNewsList;
  List<UfcFighterInfo> ufcFighterList;

  SectionUfc(this.ufcEventList, this.ufcNewsList, this.ufcFighterList);

  Widget createEvents(){
    return new Container(
      color: Colors.white,
      height: 130.0,
      width: double.infinity,
      child: ListView.builder(
        itemCount: ufcEventList.length * 2 + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if(index == 0){
            return SizedBox(width: 0.0,);
          }
          if(index.isEven){
            return SizedBox(width: 10.0,);
          }
          return UfcEventItem(ufcEventList[index ~/ 2], (){
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new WebViewPage(ufcEventList[index ~/ 2].ticketurl);
            }));
          });
        },
      ),
    );
  }

  Widget createNews(){
    return new Container(
      color: Colors.white,
      height: 150.0,
      width: double.infinity,
      child: ListView.builder(
        itemCount: ufcNewsList.length * 2 + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if(index == 0){
            return SizedBox(width: 0.0,);
          }
          if(index.isEven){
            return SizedBox(width: 10.0,);
          }
          return UfcNewsItem(ufcNewsList[index ~/ 2], (){
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new WebViewPage(Constant.UFC_NEWS + ufcNewsList[index ~/ 2].id.toString());
            }));
          });
        },
      ),
    );
  }

  Widget createFighters(){
    return new Container(
      color: Colors.white,
      height: 110.0,
      width: double.infinity,
      child: ListView.builder(
        itemCount: ufcFighterList.length * 2 + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if(index == 0){
            return SizedBox(width: 0.0,);
          }
          if(index.isEven){
            return SizedBox(width: 10.0,);
          }
          return UfcFighterItem(ufcFighterList[index ~/ 2], (){

            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return new WebViewPage(Constant.UFC_FIGHTERS + ufcFighterList[index ~/ 2].id.toString());
            }));
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'UFC',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              Expanded(child: Container(),),
              new GestureDetector(
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.blue
                  ),
                ),
                onTap: () {

                },
              ),
            ],
          ),
          SizedBox(height: 8.0,),
          createEvents(),
          SizedBox(height: 8.0,),
          createNews(),
          SizedBox(height: 8.0,),
          createFighters(),
        ],
      ),
    );
  }



}