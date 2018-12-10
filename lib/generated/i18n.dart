import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

//This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;
  String get EUROPE => "EUROPE";
  String get LIVETV => "TV GUIDE";
  String get MOVIES => "MOVIE GUIDE";
  String get RepCode => "RepCode: ";
  String get TV => "TV";
  String get USA => "USA";
  String get ValidTime => "ValidTime: ";
  String get american_football => "AmericanFootball";
  String get baseball => "Baseball";
  String get basketball => "Basketball";
  String get boxing => "Boxing";
  String get check_in => "Check In";
  String get checked => "Checked";
  String get coins => "Coins";
  String get continuous_check_in_days => "ContinuousCheckInDays: ";
  String get credit_card => "Credit Card";
  String get fight => "fight";
  String get football => "Football";
  String get golf => "Golf";
  String get home => "Home";
  String get login => "Login";
  String get logout => "Logout";
  String get mall => "Mall";
  String get media => "Media";
  String get monthly_check_in_days => "MonthlyCheckInDays: ";
  String get more => "More";
  String get my => "My";
  String get password => "password";
  String get play_list => "Play List";
  String get points => "POINTS: ";
  String get popular_events => "Popular events: ";
  String get presents_for_attendance => "PRESENTS FOR ATTENDANCE";
  String get search => "Search";
  String get signup => "SignUp";
  String get sports => "Sports";
  String get sports_guide => "Sports Guide";
  String get username => "username";
  String get vip => "VIP";
}

class en extends S {
  const en();
}

class zh extends S {
  const zh();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get TV => "TV";
  @override
  String get popular_events => "热门活动:";
  @override
  String get continuous_check_in_days => "连续签到: ";
  @override
  String get media => "影视";
  @override
  String get login => "登录";
  @override
  String get ValidTime => "有效期: ";
  @override
  String get points => "积分： ";
  @override
  String get password => "密码";
  @override
  String get logout => "退出";
  @override
  String get search => "查找";
  @override
  String get basketball => "篮球";
  @override
  String get golf => "高尔夫";
  @override
  String get monthly_check_in_days => "本月签到: ";
  @override
  String get checked => "已签到";
  @override
  String get play_list => "播放列表";
  @override
  String get sports_guide => "赛程";
  @override
  String get vip => "会员";
  @override
  String get fight => "搏击";
  @override
  String get USA => "美国";
  @override
  String get sports => "运动";
  @override
  String get MOVIES => "电影";
  @override
  String get coins => "金币";
  @override
  String get more => "详情";
  @override
  String get mall => "商城";
  @override
  String get check_in => "签到";
  @override
  String get RepCode => "邀请码: ";
  @override
  String get football => "足球";
  @override
  String get my => "我的";
  @override
  String get signup => "注册";
  @override
  String get home => "主页";
  @override
  String get EUROPE => "欧洲";
  @override
  String get credit_card => "信用卡";
  @override
  String get american_football => "美式足球";
  @override
  String get LIVETV => "电视";
  @override
  String get boxing => "拳击";
  @override
  String get presents_for_attendance => "签到有礼";
  @override
  String get baseball => "棒球";
  @override
  String get username => "用户名";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("zh", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          return SynchronousFuture<S>(const en());
        case "zh":
          return SynchronousFuture<S>(const zh());
        default:
        // NO-OP.
      }
    }
    return SynchronousFuture<S>(const S());
  }

  @override
  bool isSupported(Locale locale) =>
      locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

String getLang(Locale l) => l == null
    ? null
    : l.countryCode != null && l.countryCode.isEmpty
        ? l.languageCode
        : l.toString();
