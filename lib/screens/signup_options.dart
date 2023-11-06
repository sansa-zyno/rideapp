import 'package:flutter/material.dart';
import 'package:ride_app/helpers/constants.dart';
import 'package:ride_app/helpers/screen_navigation.dart';
import 'package:ride_app/screens/driver/driver_registration.dart';
import 'package:ride_app/screens/login.dart';

class SignUpOptions extends StatefulWidget {
  @override
  _SignUpOptionsState createState() => _SignUpOptionsState();
}

class _SignUpOptionsState extends State<SignUpOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              width: 250,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                  image: AssetImage('images/5.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                onPressed: () {
                  changeScreenReplacement(context, DriverRegisteration());
                },
                child: Text(
                  'SIGNUP AS Driver',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                onPressed: () {
                  // changeScreenReplacement(context, VendorRegisteration());
                },
                child: Text(
                  'SIGNUP AS VENDOR',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    //border: Border.all(),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10.0,
                          offset: Offset(2, 2),
                          color: Colors.grey.withOpacity(0.5))
                    ]),
                child: InkWell(
                  onTap: () {
                    changeScreenReplacement(context, Sign_in_screen());
                  },
                  child: Text(
                    'Login instead?',
                    style: TextStyle(
                        color: mycolor,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
