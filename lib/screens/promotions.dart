import 'package:flutter/material.dart';
import 'package:ride_app/helpers/screen_navigation.dart';
import 'package:ride_app/screens/enter_promo_code.dart';

class Promotions extends StatefulWidget {
  const Promotions({Key? key}) : super(key: key);

  @override
  State<Promotions> createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        flexibleSpace: SafeArea(
          child: Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              border: Border.all(
                color: Colors.blue,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Promotions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: Colors.blue),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(2, 2))
                ]),
            child: TextField(
                onTap: () => changeScreen(context, EnterPromoCode()),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    //labelText: label,
                    hintText: "Enter code",
                    focusColor: Colors.grey,

                    //fillColor: Colors.white,

                    fillColor: Color.fromARGB(255, 136, 0, 0))),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 8,
          ),
          Spacer(),
          Center(child: Text("Your promotions would appear here")),
          Spacer()
        ],
      ),
    );
  }
}
