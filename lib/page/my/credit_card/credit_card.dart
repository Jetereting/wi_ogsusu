import 'package:flutter/material.dart';
import 'package:wi_ogsusu/entities/user_credit_card_info.dart';

class CreditCard extends StatelessWidget{

  UserCreditCardInfo _userCreditCardInfo;


  CreditCard(this._userCreditCardInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(6.0),
        child: AspectRatio(
          aspectRatio: 5/3,
          child: Stack(
            children: <Widget>[
              Image.asset('res/img/bg_card.png'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(
                        'Credit Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Expanded(child: Container(),),
                  Container(
                    padding: EdgeInsets.only(left: 30.0, top: 10.0),
                    child: Text(
                      _userCreditCardInfo.number,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 30.0),
                    child: Text(
                      'Expiry Date: ' + _userCreditCardInfo.expiryDate,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 20.0),
                    child: Text(
                      'CVV: ' + _userCreditCardInfo.cvv,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }


}