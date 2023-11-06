import 'package:flutter/material.dart';

class MyRides extends StatefulWidget {
  const MyRides({Key? key}) : super(key: key);

  @override
  State<MyRides> createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
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
                        "My Rides",
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
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (ctx, index) => ListTile(
                  leading: Icon(
                    Icons.time_to_leave_rounded,
                    color: Colors.blue,
                  ),
                  title: Text("Ibadan"),
                  trailing: Text("\u20A6 3000"),
                )));
  }
}
