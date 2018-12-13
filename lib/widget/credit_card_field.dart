import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreditCardField extends StatelessWidget{

  Function onNumberChange;
  Function onExpirationDateChange;
  Function onCvvChange;
  Function onHolderNameChange;


  CreditCardField({this.onNumberChange, this.onExpirationDateChange,
      this.onCvvChange, this.onHolderNameChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Card number',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.0,),
          TextField(
            maxLength: 16,
            style: new TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.all(3.0),
              hintText: '16 digital',
              suffixIcon: Icon(Icons.credit_card, color: Colors.grey, size: 24.0,),
            ),
            autofocus: false,
            onChanged: (String str){
              onNumberChange(str);
            },
            onSubmitted: (String str){

            },
          ),
          SizedBox(height: 8.0,),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Expiration date',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    TextField(
                      maxLength: 4,
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(3.0),
                        hintText: '4 digital',
                        suffixIcon: Icon(Icons.calendar_today, color: Colors.grey, size: 24.0,),
                      ),
                      autofocus: false,
                      onChanged: (String str){
                        onExpirationDateChange(str);
                      },
                      onSubmitted: (String str){

                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'CVV',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    TextField(
                      maxLength: 3,
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(3.0),
                        hintText: '3 digital',
                        suffixIcon: Icon(Icons.security, color: Colors.grey, size: 24.0,),
                      ),
                      autofocus: false,
                      onChanged: (String str){
                        onCvvChange(str);
                      },
                      onSubmitted: (String str){

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0,),
          Text(
            'Card holder name',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.0,),
          TextField(
            style: new TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.all(3.0),
              hintText: 'firstname lastname',
              suffixIcon: Icon(Icons.person, color: Colors.grey, size: 24.0,),
            ),
            autofocus: false,
            onChanged: (String str){
              onHolderNameChange(str);
            },
            onSubmitted: (String str){

            },
          ),
        ],
      ),
    );
  }


}