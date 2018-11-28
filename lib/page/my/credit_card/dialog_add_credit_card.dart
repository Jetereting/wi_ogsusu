import 'package:flutter/material.dart';
import 'package:wi_ogsusu/widget/ensure_visible.dart';

class CreditCardAddDialog extends Dialog {

  Function onCloseEvent;
  Function onPositivePressEvent;

  String number;
  String date;
  String cvv;
  String zipCode;
  String billAddress;


  FocusNode _numberFocusNode = new FocusNode();
  FocusNode _billAddressFocusNode = new FocusNode();


  CreditCardAddDialog({
    Key key,
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }) : super(key: key);


  String _validateName(String value) {
    if (value.isEmpty)
      return 'Number is required.';
    final RegExp nameExp = RegExp(r'^\d+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only number.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              margin: const EdgeInsets.all(12.0),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        new Center(
                          child: new Text(
                            '+ Add Credit Card',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: this.onCloseEvent,
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new Icon(
                              Icons.close,
                              color: Color(0xffe0e0e0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  new Container(
                    padding: EdgeInsets.all(8.0),
                    constraints: BoxConstraints(minHeight: 180.0),
                    child: Column(
                      children: <Widget>[
                        EnsureVisibleWhenFocused(
                          focusNode: _numberFocusNode,
                          child: new TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(2.0),
                              fillColor: Colors.transparent,
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.credit_card),
                              hintText: 'credit card number',
                              labelText: 'Number *',
                            ),
                            onSaved: (String value) { },
                            validator: _validateName,
                            focusNode: _numberFocusNode,
                          ),
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            fillColor: Colors.transparent,
                            border: UnderlineInputBorder(),
                            filled: true,
                            icon: Icon(Icons.date_range),
                            labelText: 'Expiry date *',
                          ),
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            fillColor: Colors.transparent,
                            border: UnderlineInputBorder(),
                            filled: true,
                            icon: Icon(Icons.security),
                            labelText: 'CVV *',
                          ),
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            fillColor: Colors.transparent,
                            border: UnderlineInputBorder(),
                            filled: true,
                            icon: Icon(Icons.code),
                            labelText: 'ZipCode *',
                          ),
                        ),

                        EnsureVisibleWhenFocused(
                          focusNode: _billAddressFocusNode,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(2.0),
                              fillColor: Colors.transparent,
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.assignment),
                              labelText: 'BillAddress *',
                            ),
                            focusNode: _billAddressFocusNode,
                          ),
                        ),
                      ],
                    )
                  ),
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    widgets.add(_buildBottomPositiveButton());
    return new Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

  Widget _buildBottomPositiveButton() {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        onPressed: onPositivePressEvent,
        child: new Text(
          'Confirm',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
