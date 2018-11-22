import 'package:sqflite/sqflite.dart';
import 'package:wi_ogsusu/entities/sport_event_info.dart';
import 'dart:convert';
import 'package:wi_ogsusu/sql/sql_master.dart';

class SportsEventDao {

  String tableSportsEvent = 'sports_event';
  Database database;
  SqlMaster sqlMaster = SqlMaster();

  SportsEventDao(){
    _init();
  }

  _init() async{
    database = await sqlMaster.open();
  }

  Future<SportEventInfo> insert(SportEventInfo sportEventInfo) async {
    try{
      sportEventInfo.id = await database.insert(tableSportsEvent, json.decode(sportEventInfo.toString()));
      return sportEventInfo;
    }catch (exception){
      return null;
    }finally{
      close();
    }
  }

  Future<SportEventInfo> selectById(int id) async {
    try{
      List<Map> maps = await database.query(tableSportsEvent,
        columns: [
          'id',
          'categoryId',
          'label',
          'name',
          'icon',
          'description',
          'type',
          'agent',
          'platform',
          'flag'
        ],
        where: "$id = ?",
        whereArgs: [id]);
      if (maps.length > 0) {
        return new SportEventInfo.fromJson(maps.first);
      }
      return null;
    }catch (exception){
      return null;
    }finally{
      close();
    }
  }

  Future<List<SportEventInfo>> selectAll() async {
    try {
      List<Map> maps = await database.query(tableSportsEvent,
        columns: [
          'id',
          'categoryId',
          'label',
          'name',
          'icon',
          'description',
          'type',
          'agent',
          'platform',
          'flag'
        ],
      );
      if (maps.length > 0) {
        return maps.map((map) => SportEventInfo.fromJson(maps.first)).toList();
      }
      return null;
    }catch (exception){
      return null;
    }finally{
      close();
    }
  }

  Future<int> deleteById(int id) async {
    try{
      return await database.delete(tableSportsEvent, where: "id = ?", whereArgs: [id]);
    }catch (exception){
      return null;
    }finally{
      close();
    }
  }

  Future<int> updateById(SportEventInfo sportEventInfo) async {
    try{
      return await database.update(tableSportsEvent, json.decode(sportEventInfo.toString()),
          where: "id = ?", whereArgs: [sportEventInfo.id]);
    }catch (exception){
      return null;
    }finally{
      close();
    }
  }

  Future close() async {
    if(database != null){
      database.close();
    }
  }

}