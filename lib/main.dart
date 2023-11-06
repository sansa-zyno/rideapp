import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:ride_app/providers/admin_provider.dart';
import 'package:ride_app/providers/driver_provider.dart';
import 'package:ride_app/providers/vendor_provider.dart';
import 'package:ride_app/screens/login.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /* ChangeNotifierProvider<AppProvider>.value(
          value: AppProvider(),
        ),*/
        ChangeNotifierProvider<DriverProvider>(
          create: (_) => DriverProvider(),
        ),
        ChangeNotifierProvider<VendorProvider>(
          create: (_) => VendorProvider(),
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (_) => AdminProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ride app',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(bodyText1: TextStyle(fontFamily: "Poppins"))),
        home: Sign_in_screen(),
      ),
    );
  }
}
