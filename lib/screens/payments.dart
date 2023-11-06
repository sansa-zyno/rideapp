import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ride_app/helpers/screen_navigation.dart';
import 'package:ride_app/screens/credit_card.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  TextEditingController amtController = TextEditingController(text: '');
  List? tableDatas;
  Map? totalBalance;
  String? username;
  int selectedVal = 0;

  getData() async {
    /* username = await LocalStorage().getString("username");
    final balance =
        await HttpService.post(Api.totalBalance, {"username": username});
    totalBalance = jsonDecode(balance.data)[0];
    setState(() {});*/
  }

  bool loading = false;
  Payments() async {
    /*loading = true;
    setState(() {});
    final res = await HttpService.post(Api.Paymentss,
        {"username": username, "amount": amtController.text});
    final result = jsonDecode(res.data);
    print(result);
    if (result["Status"] == "succcess") {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle:
            TextStyle(color: Color(0xFF072A6C), fontWeight: FontWeight.bold),
        middleText: "Transaction successful",
        middleTextStyle: TextStyle(color: Color(0xFF072A6C)),
      ).then((value) => print("done"));
      amtController.text = "";
    } else {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle:
            TextStyle(color: Color(0xFF072A6C), fontWeight: FontWeight.bold),
        middleText: "Transaction failed",
        middleTextStyle: TextStyle(color: Color(0xFF072A6C)),
      ).then((value) => print("done"));
    }
    loading = false;
    setState(() {});*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
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
                      "Payments",
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
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(children: [
                        Row(
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        totalBalance != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "NGN ${totalBalance != null ? totalBalance!["money"].replaceAllMapped(reg, mathFunc) : ""}",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            : SpinKitFadingCircle(
                                color: Colors.white,
                              ),
                        SizedBox(
                          height: 30,
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 3,
                              offset: Offset(3, 10))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Payment methods",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.money,
                            color: Colors.blue,
                          ),
                          title: Text("Cash"),
                          trailing: Radio(
                            value: 1,
                            groupValue: selectedVal,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              log("Radio $val");
                              selectedVal = val as int;
                              setState(() {});
                            },
                          ),
                          onTap: () {},
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.credit_card,
                            color: Colors.blue,
                          ),
                          title: Text("Add debit/credit card"),
                          trailing: Radio(
                            value: 2,
                            groupValue: selectedVal,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              log("Radio $val");
                              selectedVal = val as int;
                              setState(() {});
                              changeScreen(context, CreditCard());
                            },
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller,
      {bool obscure = false, TextInputType type = TextInputType.text}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: Color(0xFF072A6C)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(2, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 15, 0),
        child: TextFormField(
          keyboardType: type,
          cursorColor: Color(0xFF072A6C),
          obscureText: obscure,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "This field must not be empty.";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
              //labelText: label,
              hintText: hint,
              focusColor: Colors.grey,

              //fillColor: Colors.white,

              fillColor: Colors.white),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
