import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scacffoldKey,
      appBar: AppBar(
        title: Text("New Card"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              CreditCardWidget(
                onCreditCardWidgetChange: (brand) {},
                height: 200,
                cardBgColor: Colors.blue,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView:
                    isCvvFocused, //true when you want to show cvv(back) view
              ),
              CreditCardForm(
                formKey: _formKey,
                themeColor: Colors.blue,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvFocused = data.isCvvFocused;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          int? cvc = int.tryParse(cvvCode);
          int? carNo =
              int.tryParse(cardNumber.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
          int? exp_year = int.tryParse(expiryDate.substring(3, 5));
          int? exp_month = int.tryParse(expiryDate.substring(0, 2));
        },
        tooltip: 'Submit',
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
