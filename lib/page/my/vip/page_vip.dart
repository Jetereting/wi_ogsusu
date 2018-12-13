import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:wi_ogsusu/constant.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/entities/ogsusu_vip_info.dart';
import 'package:wi_ogsusu/common/http_master.dart';
import 'package:wi_ogsusu/constant.dart';
import 'page_vip_purchase.dart';

class VipPage extends StatefulWidget {
  @override
  VipPageState createState() => VipPageState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class VipPageState extends State<VipPage> {
  bool _loading = true;
  String _username = 'no login';
  int _vipLevel = 0;
  String _repCode = '';
  String _validTime = '';
  List<OgsusuVipInfo> vipList = [];
  List<ExpendItem> expendItems = [];

  @override
  void initState() {
    super.initState();
    getLocalUserInfo();
    getVipsData();
  }

  getLocalUserInfo() async {
    var vipLevel = await getSpInt(Constant.SP_KEY_VIP_LEVEL);
    var name = await getSpString(Constant.SP_KEY_USERNAME);
    var repCode = await getSpString(Constant.SP_KEY_REP_CODE);
    var validTime = await getSpString(Constant.SP_KEY_VALID_TIME);
    setState(() {
      if (vipLevel != null) {
        _vipLevel = vipLevel;
      }
      if (name != null) {
        _username = name;
      }
      if (repCode != null) {
        _repCode = repCode;
      }
      if (validTime != null) {
        _validTime = validTime.substring(0, 10);
      }
    });
  }

  Future<void> getVipsData() async {
    setState(() {
      _loading = true;
    });
    HttpMaster.instance.get(Constant.URL_OGSUSU_VIPS).then((result) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      int code = result.code;
      if (code != 200) {
        print(result.msg);
        return;
      }
      setState(() {
        List dataList = result.data;
        vipList = dataList.map((dataStr) {
          return OgsusuVipInfo.fromJson(dataStr);
        }).toList();
        expendItems = vipList.map((vipInfo) {
          return ExpendItem(
            context: context,
            vipInfo: vipInfo,
          );
        }).toList();
      });
    });
  }

  Widget buildVipProfileSection() {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: Card(
        elevation: 6.0,
        child: AspectRatio(
          aspectRatio: 5 / 2,
          child: Stack(
            children: <Widget>[
              Image.asset(
                'res/img/bg_vip_section.jpg',
                fit: BoxFit.cover,
              ),
              Column(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'res/img/icons8_crown_96.png',
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                    child: Container(
                      height: 0.3,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Level:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          _vipLevel.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Valid:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          _validTime,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVipActivateSection() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: expendItems != null && expendItems.length > 0
          ? ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  print(isExpanded);
                  expendItems[index].isExpanded = !isExpanded;
                });
              },
              children: expendItems.map<ExpansionPanel>((ExpendItem item) {
                return ExpansionPanel(
                    isExpanded: item.isExpanded,
                    headerBuilder: item.headerBuilder,
                    body: item.body);
              }).toList())
          : Center(
              child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.deepOrange)),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFeeeeee),
      appBar: AppBar(
        backgroundColor: Color(0xFFff0000),
        title: Text(Translations.of(context).text('vip')),
      ),
      body: Column(
        children: <Widget>[
          buildVipProfileSection(),
          buildVipActivateSection(),
        ],
      ),
    );
  }
}

class ExpendItem {
  ExpendItem({
    this.context,
    this.vipInfo,
  });

  final BuildContext context;
  final OgsusuVipInfo vipInfo;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return Container(
          padding: EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      vipInfo.label,
                      style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      vipInfo.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '\$' + vipInfo.price.toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ));
    };
  }

  Widget get body {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(vipInfo.rights.replaceAll('\\n', '\n')),
          SizedBox(
            height: 8.0,
          ),
          Container(
            color: Colors.grey,
            height: 0.3,
          ),
          Row(
            children: <Widget>[
              Expanded(child: Container()),
              IconButton(
                color: Colors.blueAccent,
                icon: Icon(Icons.credit_card),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new PageVipPurchase(
                        vipInfo.id, vipInfo.label, vipInfo.description, 1, vipInfo.price);
                  }));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
