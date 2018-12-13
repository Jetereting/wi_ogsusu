import 'package:flutter/material.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:wi_ogsusu/common/http_master.dart';
import 'package:wi_ogsusu/common/utils/modal_util.dart';
import 'package:wi_ogsusu/widget/credit_card_field.dart';
import 'package:wi_ogsusu/common/utils/sp_util.dart';


// ignore: must_be_immutable
class PageVipPurchase extends StatefulWidget{

  int productId;
  String label;
  String description;
  int qty;
  double price;

  PageVipPurchase(this.productId, this.label, this.description, this.qty, this.price);

  @override
  PageVipPurchaseState createState() => PageVipPurchaseState(productId, label, description, qty, price);

}

class PageVipPurchaseState extends State<PageVipPurchase>{

  int productId;
  String label;
  String description;
  int qty;
  double price;

  bool _loading = false;
  int _userId;
  String cardNumber;
  String expirationDate;
  String cvv;
  String holderName;

  PageVipPurchaseState(this.productId, this.label, this.description, this.qty, this.price);

  @override
  void initState() {
    super.initState();
    getLocalUserInfo();
  }

  getLocalUserInfo() async{
    var userId = await getSpInt(Constant.SP_KEY_USER_ID);
    setState(() {
      if(userId != null) {
        _userId = userId;
      }
    });
  }


  Future<void> purchase() async{
    if(cardNumber == null || cardNumber.length != 16){
      showError(context, 'card number input error');
      return;
    }
    if(expirationDate == null || expirationDate.length != 4){
      showError(context, 'expiration date input error');
      return;
    }
    if(cvv == null || cvv.length != 3){
      showError(context, 'cvv input error');
      return;
    }
    if(holderName == null || holderName.length <= 0){
      showError(context, 'holder name input error');
      return;
    }
    setState(() {
      _loading = true;
    });
    HttpMaster.instance.post(Constant.URL_OGSUSU_VIP_PURCHASE + productId.toString(), data: {
      'userId': _userId,
      'number': cardNumber,
      'expiryDate': expirationDate,
      'cvv': cvv,
      'firstName': holderName,
      'lastName': holderName,
    }).then((result){
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
      });
      int code = result.code;
      if (code != 200) {
        showError(context, result.msg);
        return;
      }
      setState(() {

      });
      showSuccess(context, 'Successfully');
    });
  }

  Widget buildPayInfo(){
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0)
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Product information',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),),
              SizedBox(height: 8.0,),
              Container(height: .3, color: Colors.grey,),
              SizedBox(height: 8.0,),
              Row(
                children: <Widget>[
                  Text(
                    'Name:',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0,),
              Row(
                children: <Widget>[
                  Text(
                    'Description:',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0,),
              Row(
                children: <Widget>[
                  Text(
                    'QTY:',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    qty.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0,),
              Row(
                children: <Widget>[
                  Text(
                    'Price:',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    '\$' + price.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0,),
              Container(height: .3, color: Colors.grey,),
              SizedBox(height: 8.0,),
              Text(
                '* Price does not include tax, fees will be added to the purchase amount.',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onNumberChange(String value){
    cardNumber = value;
  }

  void onExpirationDateChange(String value){
    expirationDate = value;
  }

  void onCvvChange(String value){
    cvv = value;
  }

  void onHolderNameChange(String value){
    holderName = value;
  }

  Widget buildCreditCardInputSection(){
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0)
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Fill in credit card information',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.0,),
              Container(height: .3, color: Colors.grey,),
              SizedBox(height: 8.0,),
              CreditCardField(
                  onNumberChange: onNumberChange,
                  onExpirationDateChange: onExpirationDateChange,
                  onCvvChange: onCvvChange,
                  onHolderNameChange: onHolderNameChange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentButton(){
    return new Container(
      width: double.infinity,
      padding: new EdgeInsets.all(12.0),
      child: new RawMaterialButton(
        disabledElevation: 10.0,
        onPressed: () {
          purchase();
        },
        elevation: 6.0,
        constraints: new BoxConstraints(minHeight: 46.0),
        fillColor: Colors.blueAccent[400],
        splashColor: Colors.white,
        child: new Text(
          Translations.of(context).text('payment'),
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0
          ),
        ),
      ),
    );
  }

  Widget loading = new Container(
    padding: new EdgeInsets.all(20.0),
    child: new CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.blueAccent[400],)
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFeeeeee),
      appBar: AppBar(
        backgroundColor: Color(0xFFEE0000),
        title: Text(Translations.of(context).text('payment')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildPayInfo(),
            buildCreditCardInputSection(),
            _loading? loading: buildPaymentButton(),
            SizedBox(height: 20.0,),
          ],
        ),
      )
    );
  }

}

