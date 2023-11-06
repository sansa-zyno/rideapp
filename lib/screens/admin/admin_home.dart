import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:ride_app/helpers/constants.dart';
import 'package:ride_app/helpers/style.dart';
import 'package:ride_app/providers/admin_provider.dart';
import 'package:ride_app/screens/admin/booked_drivers.dart';
import 'package:ride_app/screens/admin/menu.dart';
import 'package:ride_app/screens/admin/unbooked_drivers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
              /*borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),*/
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Dashboard",
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
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        //border: Border.all(color: Color(0xFF072A6C)),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(2, 2))
                        ]),
                    padding: EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Number of Drivers",
                                  style: TextStyle(
                                      color: Color(0xFF072A6C),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Icon(Boxicons.bx_group, color: Colors.deepOrange)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("50",
                              style: TextStyle(
                                  color: Colors.cyan,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Color(0xFF072A6C)),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(2, 2))
                        ]),
                    padding: EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Number of Customers",
                                  style: TextStyle(
                                      color: Color(0xFF072A6C),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Icon(Boxicons.bxs_binoculars,
                                  color: Colors.deepOrange)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("100",
                              style: TextStyle(
                                  color: Colors.cyan,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => BookedDrivers()));
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Color(0xFF072A6C)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(2, 2))
                          ]),
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Booked Drivers",
                                    style: TextStyle(
                                        color: Color(0xFF072A6C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Icon(Icons.person, color: Colors.deepOrange)
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("18",
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => UnBookedDrivers()));
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Color(0xFF072A6C)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(2, 2))
                          ]),
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "UnBooked Drivers",
                                    style: TextStyle(
                                        color: Color(0xFF072A6C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Icon(Icons.person_add_disabled,
                                    color: Colors.deepOrange)
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("32",
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          adminProvider.center == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 3,
                                  offset: Offset(3, 10))
                            ]),
                        child: TextField(
                          onTap: () async {
                            Prediction? p = await PlacesAutocomplete.show(
                                offset: 0,
                                radius: 1000,
                                strictbounds: false,
                                region: "NG",
                                language: "EN",
                                context: context,
                                mode: Mode.overlay,
                                apiKey: GOOGLE_MAPS_API_KEY,
                                sessionToken: "eeeeeeeee",
                                components: [
                                  new Component(Component.country, "NG")
                                ],
                                types: [],
                                hint: "Search City",
                                startText: "");
                            if (p != null) {
                              PlacesDetailsResponse detail =
                                  await places.getDetailsByPlaceId(p.placeId!);
                              double lat = detail.result.geometry!.location.lat;
                              double lng = detail.result.geometry!.location.lng;
                              if (mapController != null) {
                                mapController!.moveCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                        target: LatLng(lat, lng), zoom: 15.0),
                                  ),
                                );
                              }
                            }
                          },
                          textInputAction: TextInputAction.go,
                          //controller: vendorProvider.destinationController,
                          cursorColor: Colors.blue.shade900,
                          decoration: InputDecoration(
                            prefixIcon: Text(" "),
                            hintText: "Enter a place to check driver",
                            hintStyle: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 300,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: adminProvider.center!, zoom: 13),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        myLocationEnabled: true,
                        mapType: MapType.normal,
                        tiltGesturesEnabled: true,
                        compassEnabled: false,
                        markers: adminProvider.markers,
                        //onCameraMove: appState.onCameraMove,
                        polylines: adminProvider.poly,
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
