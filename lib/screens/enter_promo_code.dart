import 'package:flutter/material.dart';
import 'package:ride_app/widgets/GradientButton/GradientButton.dart';

class EnterPromoCode extends StatefulWidget {
  const EnterPromoCode({Key? key}) : super(key: key);

  @override
  State<EnterPromoCode> createState() => _EnterPromoCodeState();
}

class _EnterPromoCodeState extends State<EnterPromoCode> {
  FocusNode myfocus = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfocus.requestFocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myfocus.unfocus();
    super.dispose();
  }

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
                        "Enter Promo Code",
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
        body: SingleChildScrollView(
          child: Column(
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
                    focusNode: myfocus,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.grey[600], fontSize: 14),
                        //labelText: label,
                        hintText: "Enter code",
                        focusColor: Colors.grey,

                        //fillColor: Colors.white,

                        fillColor: Color.fromARGB(255, 136, 0, 0))),
              ),
              SizedBox(
                height: 15,
              ),
              Text("The promo will be applied to your next ride"),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 220,
                height: 50,
                child: GradientButton(
                  title: "Apply",
                  clrs: [Colors.blue, Colors.blue],
                  onpressed: () async {},
                ),
              )
            ],
          ),
        ));
  }
}
