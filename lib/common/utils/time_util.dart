import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TimeUtil{

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  static int currentTimeSeconds() {
    String millis = new DateTime.now().millisecondsSinceEpoch.toString();
    return int.parse(millis.substring(0, millis.length - 3));
  }

  /** 复制到剪粘板 */
  static copyToClipboard(final String text) {
//    if (text == null) return;
//    Clipboard.setData(new ClipboardData(text: text));
  }

  static const RollupSize_Units = ["GB", "MB", "KB", "B"];
  /** 返回文件大小字符串 */
  static String getRollupSize(int size) {
    int idx = 3;
    int r1 = 0;
    String result = "";
    while (idx >= 0) {
      int s1 = size % 1024;
      size = size >> 10;
      if (size == 0 || idx == 0) {
        r1 = (r1 * 100) ~/ 1024;
        if (r1 > 0) {
          if (r1 >= 10)
            result = "$s1.$r1${RollupSize_Units[idx]}";
          else
            result = "$s1.0$r1${RollupSize_Units[idx]}";
        } else
          result = s1.toString() + RollupSize_Units[idx];
        break;
      }
      r1 = s1;
      idx--;
    }
    return result;
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

  /** 获取屏幕宽度 */
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /** 获取屏幕高度 */
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /** 获取系统状态栏高度 */
  static double getSysStatsHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }



  static String toStrTime(int timestamp) {
    return toStrTimeWithLocaleStr(timestamp, 'en_US');
  }

  static String toStrTimeWithLocale(int timestamp, Locale locale) {
    return toStrTimeWithLocaleStr(timestamp, locale.languageCode + "_" + locale.countryCode);
  }

  static String toStrTimeWithLocaleStr(int timestamp, String str) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a', str);
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
}