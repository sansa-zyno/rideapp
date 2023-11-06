import 'package:flutter/material.dart';
import 'package:ride_app/helpers/screen_navigation.dart';
import 'package:ride_app/models/driver.dart';
import 'package:ride_app/providers/admin_provider.dart';
import 'package:ride_app/screens/admin/track_driver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BookedDrivers extends StatefulWidget {
  const BookedDrivers({Key? key}) : super(key: key);

  @override
  State<BookedDrivers> createState() => _BookedDriversState();
}

class _BookedDriversState extends State<BookedDrivers> {
  @override
  Widget build(BuildContext context) {
    List<DriverModel> drivers =
        DriverModel.drivers.where((e) => e.booked == true).toList();
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
                        "Booked Drivers",
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
          shrinkWrap: true,
          itemBuilder: (ctx, index) => Padding(
            padding: EdgeInsets.only(top: 10),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset("${drivers[index].photo}"),
                  ),
                  Column(
                    children: [
                      Text(
                        "${drivers[index].name}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("${drivers[index].car.name}"),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Booked")
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      changeScreen(
                          context,
                          TrackDriver(LatLng(
                              (drivers[index].position.lat +
                                  adminProvider.extra),
                              (drivers[index].position.lng +
                                  adminProvider.extra))));
                      print((drivers[index].position.lat + adminProvider.extra)
                          .toString());
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            //border: Border.all(),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Track Driver",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            )),
          ),
          itemCount: drivers.length,
        ));
  }
}
