import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TimeUtil{

  ///获取当前时间unix毫秒数
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  ///获取当前时间的unix秒数
  static int currentTimeSeconds() {
    String millis = new DateTime.now().millisecondsSinceEpoch.toString();
    return int.parse(millis.substring(0, millis.length - 3));
  }

  ///解析文本时间 eg. 2019-11-06 15:29:33
  static DateTime strToDateTime(String time) {
    var format = new DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');
    DateTime dateTime = format.parse(time.substring(0, 19));
    return dateTime;
  }

  ///日期转换为带日期时间的文本
  static String toDateTimeString(DateTime dateTime) {
    var format = new DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');
    return format.format(dateTime);
  }

  ///日期转换为显示时间文本
  static String toTimeString(DateTime dateTime) {
    var format = new DateFormat('HH:mm:ss', 'en_US');
    return format.format(dateTime);
  }

  /** 返回两个日期相差的天数 */
  static int daysBetween(DateTime a, DateTime b, [bool ignoreTime = false]) {
    if (ignoreTime) {
      int v = a.millisecondsSinceEpoch ~/ 86400000 -
          b.millisecondsSinceEpoch ~/ 86400000;
      if (v < 0) return -v;
      return v;
    } else {
      int v = a.millisecondsSinceEpoch - b.millisecondsSinceEpoch;
      if (v < 0) v = -v;
      return v ~/ 86400000;
    }
  }

  ///unix时间转时间文本,默认使用en_US locale
  static String toStrTime(int timestamp) {
    return toStrTimeWithLocaleStr(timestamp, 'en_US');
  }

  ///unix时间转时间文本并指定locale
  static String toStrTimeWithLocale(int timestamp, Locale locale) {
    return toStrTimeWithLocaleStr(timestamp, locale.languageCode + "_" + locale.countryCode);
  }

  ///unix时间转时间文本并用文本形式指定locale
  static String toStrTimeWithLocaleStr(int timestamp, String str) {
    var now = new DateTime.now();
    var format = new DateFormat('hh:mm a', str);
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  static String toStrDateTime(int timestamp) {
    return toStrDateTimeWithLocaleStr(timestamp, 'en_US');
  }

  static String toStrDateTimeWithLocale(int timestamp, Locale locale) {
    return toStrDateTimeWithLocaleStr(timestamp, locale.languageCode + "_" + locale.countryCode);
  }


  ///unix时间转带日期的时间文本并用文本形式指定locale
  static String toStrDateTimeWithLocaleStr(int timestamp, String localStr) {
    var now = new DateTime.now();
    var format = new DateFormat('yyyy-MM-dd HH:mm a', 'en_US');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }
    return time;
  }



  static String toStr(int timestamp) {
    var format = new DateFormat('yyyy-MM-dd HH:mm a', 'en_US');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }
}