import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class SqlMaster{


  Future<String> getDatabase(String dbName) async{
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "$dbName";
    return path;
  }

  deleteDatabase(String dbName) async{
  }

}