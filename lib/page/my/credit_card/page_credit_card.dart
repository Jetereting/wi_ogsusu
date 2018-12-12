import 'package:flutter/material.dart';
import 'package:wi_ogsusu/common/utils/toast_util.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'credit_card.dart';
import 'package:wi_ogsusu/widget/page_loading_list9.dart';
import 'dialog_add_credit_card.dart';
import 'package:wi_ogsusu/entities/user_credit_card_info.dart';

class CreditCardPage extends StatefulWidget{

  @override
  CreditCardPageState createState() => CreditCardPageState();

}


enum AppBarBehavior { normal, pinned, floating, snapping }

class CreditCardPageState extends State<CreditCardPage>{

  Dio dio = new Dio();
  bool _loading = false;
  int _userId;
  List<UserCreditCardInfo> _userCreditCardInfoList = [];
  UserCreditCardInfo _materCreditCardInfo;


  FocusNode _numberFocusNode = new FocusNode();

  Future<void> _getUserId() async{
    getSpInt(Constant.SP_KEY_USER_ID).then((userId) {
      if (userId != null && userId > 0) {
        setState(() {
          _userId = userId;
        });
        _getCreditsData();
      }else{
        ToastUtil.showError(context, 'no login in');
      }
    });
  }

  Future<void> _getCreditsData() async{
    if(_userId == null || _userId <= 0){
      return;
    }
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_CREDITS + _userId.toString();
    Response response = await dio.get(url).catchError((DioError e){
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
      List dateList = response.data['data'];
      if(mounted) {
        setState(() {
          _userCreditCardInfoList = dateList.map((item){
            UserCreditCardInfo info = new UserCreditCardInfo.fromJson(item);
            if(info.master){
              _materCreditCardInfo = info;
            }
            return info;
          }).toList();
          print(_userCreditCardInfoList);
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

  void addCreditCard(){
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new CreditCardAddDialog(onCloseEvent: (){
            Navigator.pop(context);
          });
        });
  }


  Widget buildCard(){
    return _materCreditCardInfo != null?
    CreditCard(_materCreditCardInfo):
    Container();
  }

  Widget buildItem(UserCreditCardInfo userCreditCardInfo){
    return Container(
      child: new ListTile(
        leading: new Icon(Icons.credit_card),
  //      trailing: new Icon(icon),
        title: new Text(userCreditCardInfo.number),
        subtitle: new Text(
          "ExpiryDate: " + userCreditCardInfo.expiryDate,
          style: TextStyle(
            fontSize: 10.0
          ),
        ),
      )
    );
  }

  Widget buildCardList(){
    return ListView.builder(
        itemCount: (_userCreditCardInfoList.length - 1) * 2,
        itemBuilder: (BuildContext context, int index) {
          if(index.isOdd){
            return const Divider();
          }
          return buildItem(_userCreditCardInfoList[index ~/ 2 + 1]);
        },
    );
  }


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0126),
        title: Text(Translations.of(context).text('credit_card')),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            addCreditCard();
          })
        ],
      ),
      body: _loading? LoadingList9Page(): Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCard(),
            Container(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'More Cards: ',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            _userCreditCardInfoList != null && _userCreditCardInfoList.length > 1 ?
              Expanded(
                child: buildCardList(),
              )
              :
              Center(
                child: Text(
                  'click the + button to add new card',
                ),
              ),
          ],
        ),
      ),
    );
  }

}


