import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:wi_ogsusu/common/utils/toast_util.dart';
import 'dart:math' as math;
import 'package:wi_ogsusu/constant.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/entities/check_in_info.dart';
import 'package:wi_ogsusu/entities/user_points_detail_info.dart';
import 'package:wi_ogsusu/entities/check_in_detail_info.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/widget/page_loading_list7.dart';
import 'package:wi_ogsusu/locale/translations.dart';

class CheckInPage extends StatefulWidget{

  @override
  State<CheckInPage> createState() => CheckInPageState();

}


enum AppBarBehavior { normal, pinned, floating, snapping }

class CheckInPageState extends State<CheckInPage>{

  Dio dio = new Dio();
  bool _loading = true;
  bool _checking = false;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  bool _currentChecked = false;
  bool alreadyLogin = false;

  CheckInInfo _checkInInfo;
  Map<DateTime, int> _markedDateMap;
  int _userId;

  Future<void> _getUserId() async{
    getSpInt(Constant.SP_KEY_USER_ID).then((userId) {
      if (userId != null && userId > 0) {
        setState(() {
          _userId = userId;
        });
        _getCheckInData();
      }else{
        ToastUtil.showError(context, 'no login in');
      }
    });
  }

  Future<void> _getCheckInData() async{
    if(_userId == null || _userId <= 0){
      return;
    }
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_CHECK_IN_DETAILS;
    Response response = await dio.get(url, data: {
      "userId": _userId,
      "type": Constant.PARAM_TYPE,
      "agent": Constant.PARAM_AGENT,
      "platform": Constant.PARAM_PLATFORM,
    }).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    if(response == null){
      return;
    }
    if(mounted) {
      setState(() {
        _loading = false;
      });
    }
    int code = response.data['code'];
    if(code == 200) {
      if(mounted) {
        CheckInInfo checkInInfo = new CheckInInfo.fromJson(response.data['data']);
        setState(() {
          _checkInInfo = checkInInfo;
          _currentChecked = checkInInfo.currentChecked;
          if(checkInInfo.checkInDetailInfoList != null) {
            List<DateTime> checkedDateList = checkInInfo.checkInDetailInfoList
                .map((checkInDetailInfo) {
              String time = checkInDetailInfo.createTime;
              return TimeUtil.strToDateTime(time);
            }).toList();
            _markedDateMap = new Map.fromIterable(checkedDateList,
                key: (item) => item,
                value: (item) => 1);
          }
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
        });
      }
    }
  }

  Future<void> _checkIn() async{
    if(_currentChecked != null && _currentChecked){
      return;
    }
    if(_checking){
      return;
    }
    if(_userId == null || _userId <= 0){
      ToastUtil.showError(context, 'no login in');
      return;
    }
    setState(() {
      _checking = true;
    });
    String url = Constant.URL_CHECK_IN;
    Response response = await dio.post(url, data: {
      "userId": _userId,
      "type": Constant.PARAM_TYPE,
      "agent": Constant.PARAM_AGENT,
      "platform": Constant.PARAM_PLATFORM,
    }).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    if(response == null){
      return;
    }
    int code = response.data['code'];
    setState(() {
      _checking = false;
    });
    if(code == 200) {
      if(mounted) {
        CheckInInfo checkInInfo = new CheckInInfo.fromJson(response.data['data']);
        setState(() {
          _checkInInfo = checkInInfo;
          _currentChecked = true;
          if(checkInInfo.checkInDetailInfoList != null) {
            List<DateTime> checkedDateList = checkInInfo.checkInDetailInfoList
                .map((checkInDetailInfo) {
              String time = checkInDetailInfo.createTime;
              return TimeUtil.strToDateTime(time);
            }).toList();
            _markedDateMap = new Map.fromIterable(checkedDateList,
                key: (item) => item,
                value: (item) => 1);
          }
        });
      }
    }else{
      ToastUtil.showError(context, response.data['msg']);
      if(mounted) {
        setState(() {
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }


  Widget buildPoints(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text(
            Translations.of(context).text('points'),
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400
            ),
          ),
          Text(
            _checkInInfo.points.toString(),
            style: TextStyle(
              color: Colors.red,
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            ),
          ),
          Expanded(child: Container(),),
          RaisedButton(
            onPressed: (){
              _checkIn();
            },
            color: _currentChecked != null && _currentChecked? Colors.grey: Colors.pink,
            shape: StadiumBorder(),
            elevation: 4.0,
            child: _checking?
              SizedBox(
                width: 26.0,
                height: 26.0,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ):Text(
              _currentChecked != null && _currentChecked? Translations.of(context).text('checked'):
                Translations.of(context).text('check_in'),
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }

  void dayPress(DateTime date){
    this.setState((){
    });
  }

  Widget buildCalendar(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: CalendarCarousel(
        onDayPressed: (DateTime date) {
          dayPress(date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        weekends: [WeekDay.Sunday, WeekDay.Saturday],
        markedDatesMap: _markedDateMap,
        markedDateWidget: Icon(
          Icons.check, color: Colors.red, size: 18.0,
        ),
        selectedDayBorderColor: Colors.orange,
        todayBorderColor: Colors.blue,
        todayButtonColor: Colors.lightGreen,
        height: 400.0,
//        selectedDateTime: _selectDate,
        showHeaderButton: false,
        daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  Widget buildCheckInDays(){
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            Translations.of(context).text('monthly_check_in_days'),
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
          Text(
            _checkInInfo != null? _checkInInfo.checkInDays.toString(): '0',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 12.0,
            ),
          ),
          Expanded(child: Container(),),
          Text(
            Translations.of(context).text('continuous_check_in_days'),
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
          Text(
            _checkInInfo != null? _checkInInfo.checkInContinuousDays.toString(): '0',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }



  double _discreteValue = 2.0;
  Widget buildSliderPoint(){
    final ThemeData theme = Theme.of(context);
    return SliderTheme(
      data: theme.sliderTheme.copyWith(
        activeTrackColor: Colors.pink,
        inactiveTrackColor: Colors.black26,
        activeTickMarkColor: Colors.yellow,
        inactiveTickMarkColor: Colors.deepPurple,
        overlayColor: Colors.black12,
        thumbColor: Colors.pink,
        valueIndicatorColor: Colors.deepPurpleAccent,
//            thumbShape: _CustomThumbShape(),
//            valueIndicatorShape: _CustomValueIndicatorShape(),
        valueIndicatorTextStyle: theme.accentTextTheme.body2.copyWith(color: Colors.black87),
      ),
      child: Slider(
        value: _discreteValue,
        min: 0.0,
        max: 28.0,
        divisions: 4,
        semanticFormatterCallback: (double value) => value.round().toString(),
        label: '${_discreteValue.round()}',
        onChanged: (double value) {
          setState(() {
            _discreteValue = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    double _appBarHeight = deviceSize.width /5 * 1.8;
    return new Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                backgroundColor: Colors.red[800],
                expandedHeight: _appBarHeight,
                pinned: _appBarBehavior == AppBarBehavior.pinned,
                floating: _appBarBehavior == AppBarBehavior.floating ||
                    _appBarBehavior == AppBarBehavior.snapping,
                snap: _appBarBehavior == AppBarBehavior.snapping,
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text(
                    Translations.of(context).text('presents_for_attendance'),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  centerTitle: true,
                  background: new Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          "res/img/banner_check_in.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, -0.4),
                            colors: <Color>[Color(0x60000000), Color(0x00000000)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new SliverPadding(
                padding: new EdgeInsets.all(3.0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate([
                    Container(
                      child: _loading? LoadingList7Page():
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildPoints(),
//                          SizedBox(height: 30.0,),
//                          buildSliderPoint(),
                            buildCalendar(),
                            buildCheckInDays(),
                          ],
                        ),
                    ),
                  ])
                ),
              ),
            ]
        )
    );
  }

}






Path _triangle(double size, Offset thumbCenter, {bool invert = false}) {
  final Path thumbPath = Path();
  final double height = math.sqrt(3.0) / 2.0;
  final double halfSide = size / 2.0;
  final double centerHeight = size * height / 3.0;
  final double sign = invert ? -1.0 : 1.0;
  thumbPath.moveTo(thumbCenter.dx - halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.lineTo(thumbCenter.dx, thumbCenter.dy - 2.0 * sign * centerHeight);
  thumbPath.lineTo(thumbCenter.dx + halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.close();
  return thumbPath;
}

class _CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 4.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled ? const Size.fromRadius(_thumbSize) : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
      PaintingContext context,
      Offset thumbCenter, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
      }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final double size = _thumbSize * sizeTween.evaluate(enableAnimation);
    final Path thumbPath = _triangle(size, thumbCenter);
    canvas.drawPath(thumbPath, Paint()..color = colorTween.evaluate(enableAnimation));
  }
}

class _CustomValueIndicatorShape extends SliderComponentShape {
  static const double _indicatorSize = 4.0;
  static const double _disabledIndicatorSize = 3.0;
  static const double _slideUpHeight = 40.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isEnabled ? _indicatorSize : _disabledIndicatorSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledIndicatorSize,
    end: _indicatorSize,
  );

  @override
  void paint(
      PaintingContext context,
      Offset thumbCenter, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
      }) {
    final Canvas canvas = context.canvas;
    final ColorTween enableColor = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.valueIndicatorColor,
    );
    final Tween<double> slideUpTween = Tween<double>(
      begin: 0.0,
      end: _slideUpHeight,
    );
    final double size = _indicatorSize * sizeTween.evaluate(enableAnimation);
    final Offset slideUpOffset = Offset(0.0, -slideUpTween.evaluate(activationAnimation));
    final Path thumbPath = _triangle(
      size,
      thumbCenter + slideUpOffset,
      invert: true,
    );
    final Color paintColor = enableColor.evaluate(enableAnimation).withAlpha((255.0 * activationAnimation.value).round());
    canvas.drawPath(
      thumbPath,
      Paint()..color = paintColor,
    );
    canvas.drawLine(
        thumbCenter,
        thumbCenter + slideUpOffset,
        Paint()
          ..color = paintColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0);
    labelPainter.paint(canvas, thumbCenter + slideUpOffset + Offset(-labelPainter.width / 2.0, -labelPainter.height - 4.0));
  }
}
