import 'package:flutter/material.dart';
import 'package:ride_app/helpers/constants.dart';
import 'package:ride_app/helpers/screen_navigation.dart';
import 'package:ride_app/screens/admin/admin_home.dart';
import 'package:ride_app/screens/driver/driver_home.dart';
import 'package:ride_app/screens/signup_options.dart';
import 'package:ride_app/screens/vendor/vendor_home.dart';
import 'package:ride_app/widgets/rounded_textfield.dart';

class Sign_in_screen extends StatefulWidget {
  @override
  _Sign_in_screenState createState() => _Sign_in_screenState();
}

class _Sign_in_screenState extends State<Sign_in_screen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  List users = [
    {"type": "admin", "email": "admin@gmail.com", "password": "admin123"},
    {"type": "vendor", "email": "vendor@gmail.com", "password": "vendor123"},
    {"type": "driver", "email": "driver@gmail.com", "password": "driver123"}
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "images/5.png",
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Email
                        RoundedTextField(
                          hint: "Email",
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'invalid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //Password
                        RoundedTextField(
                          controller: passwordController,
                          hint: "Password",
                          validator: (value) {
                            if (value!.isEmpty || value.length <= 5) {
                              return 'invalid password';
                            }
                            return null;
                          },
                        )
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                isloading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: 14.51),
                          ),
                          onPressed: () {
                            users.forEach((element) {
                              if (element["email"] == emailController.text &&
                                  element["password"] ==
                                      passwordController.text) {
                                if (element["type"] == "admin") {
                                  changeScreenReplacement(context, AdminHome());
                                } else if (element["type"] == "vendor") {
                                  changeScreenReplacement(
                                      context, VendorHome());
                                } else {
                                  changeScreenReplacement(
                                      context, DriverHome());
                                }
                              }
                            });
                          },
                        ),
                      ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    //Navigator.of(context).pushReplacementNamed(Email_Screen.routename);
                  },
                  child: Center(
                    child: Text("Forgot Password?",
                        style: TextStyle(
                          color: mycolor,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?  "),
                    InkWell(
                        onTap: () {
                          changeScreenReplacement(context, SignUpOptions());
                        },
                        child: Text("Sign up",
                            style: TextStyle(
                              color: mycolor,
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signin() async {
    /*loading = true;
    setState(() {});
    try {
      final apiResult = await HttpService.post(
        Api.login,
        {
          "username": userNameController.text,
          "password": passwordController.text,
        },
      );
      print(apiResult.data);
      //Map<String, String> result = apiResult.data as Map<String, String>;
      final result = jsonDecode(apiResult.data);
      print(result);
      if (result["Status"] == "succcess") {
        LocalStorage().setString("username", userNameController.text);
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Home(
                  username: userNameController.text,
                )),
            (route) => false);
      } else {
        Get.defaultDialog(
          title: "${result["Report"]}",
          titleStyle:
              TextStyle(color: Color(0xFF072A6C), fontWeight: FontWeight.bold),
          middleText: "Please check your sign in credentials",
          middleTextStyle: TextStyle(color: Color(0xFF072A6C)),
        ).then((value) => print("done"));
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        titleStyle:
            TextStyle(color: Color(0xFF072A6C), fontWeight: FontWeight.bold),
        middleText: "Please check your internet connection and try again",
        middleTextStyle: TextStyle(color: Color(0xFF072A6C)),
      ).then((value) => print("done"));
    }
    loading = false;
    setState(() {});*/
  }
}
