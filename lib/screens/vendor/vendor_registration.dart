import 'package:flutter/material.dart';
import 'package:ride_app/helpers/constants.dart';
import 'package:ride_app/helpers/screen_navigation.dart';
import 'package:ride_app/screens/login.dart';
import 'package:ride_app/screens/vendor/vendor_home.dart';
import 'package:ride_app/widgets/rounded_textfield.dart';

class VendorRegisteration extends StatefulWidget {
  @override
  _VendorRegisterationState createState() => _VendorRegisterationState();
}

class _VendorRegisterationState extends State<VendorRegisteration> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 65),
            child: Column(
              children: <Widget>[
                Image.asset("images/5.png"),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //firstname
                        RoundedTextField(
                          controller: firstNameController,
                          hint: "First name",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required";
                            }
                            return null;
                          },
                        ),

                        //lastname
                        RoundedTextField(
                          controller: lastNameController,
                          hint: "Last name",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required";
                            }
                            return null;
                          },
                        ),

                        //Email
                        RoundedTextField(
                          controller: emailController,
                          hint: "Email",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required";
                            }
                            if (!value.contains('@')) {
                              return 'invalid email';
                            }
                            return null;
                          },
                        ),

                        //Phone Number
                        RoundedTextField(
                          controller: phoneController,
                          hint: "Phone number",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required";
                            }

                            if (value.length < 5) {
                              return 'Password is too short!';
                            }
                            return null;
                          },
                        ),

                        //Password
                        RoundedTextField(
                          controller: passwordController,
                          hint: "Password",
                          validator: (value) {
                            bool passValid = RegExp(
                                    "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                                .hasMatch(value!);
                            if (value.isEmpty) {
                              return '*Required';
                            }
                            if (value.length < 5) {
                              return '*Password is too short';
                            }
                            if (!passValid) {
                              return 'Weak password';
                            }
                            return null;
                          },
                        ),

                        //Confirm password
                        RoundedTextField(
                          controller: confirmPasswordController,
                          hint: "Comfirm Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required";
                            }
                            if (value != confirmPasswordController.text) {
                              return 'invalid password';
                            }
                            return null;
                          },
                        )
                      ],
                    )),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 25),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('SIGN UP',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.51)),
                      onPressed: () {
                        changeScreenReplacement(context, VendorHome());
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?  "),
                    InkWell(
                        onTap: () {
                          changeScreen(context, Sign_in_screen());
                        },
                        child: Text("Sign in",
                            style: TextStyle(
                              color: mycolor,
                            ))),
                  ],
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
    /*loading = true;
    setState(() {});
    try {
      final apiResult = await HttpService.post(
        Api.register,
        {
          "username": userNameController.text,
          "referer": refererIdController.text,
          "upline": uplineController.text,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "cpassword": confirmPasswordController.text
        },
      );
      print(apiResult);
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
                child: Home(username: userNameController.text)),
            (route) => false);
      } else {
        Get.defaultDialog(
          title: "${result["Report"]}",
          titleStyle:
              TextStyle(color: Color(0xFF072A6C), fontWeight: FontWeight.bold),
          middleText: "Please check your sign up credentials",
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
