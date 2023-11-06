import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:ride_app/helpers/constants.dart';
import 'package:ride_app/helpers/style.dart';
import 'package:ride_app/providers/vendor_provider.dart';
import 'package:ride_app/screens/vendor/vendor_widget/available_drivers.dart';
import 'package:ride_app/screens/vendor/vendor_widget/menu.dart';
import 'package:ride_app/screens/vendor/vendor_widget/destination_selection.dart';
import 'package:ride_app/screens/vendor/vendor_widget/driver_found.dart';
import 'package:ride_app/screens/vendor/vendor_widget/pickup_selection_widget.dart';
import 'package:ride_app/screens/vendor/vendor_widget/trip_draggable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import "package:google_maps_webservice/places.dart";

class VendorHome extends StatefulWidget {
  VendorHome({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //FirebaseMessaging.instance.getInitialMessage();
    // _deviceToken();
    VendorProvider vendorProvider =
        Provider.of<VendorProvider>(context, listen: false);
    vendorProvider.setCustomMapPin(context);
  }

  /*_deviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);

    if (_user.userModel?.token != preferences.getString('token')) {
      Provider.of<UserProvider>(context, listen: false).saveDeviceToken();
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //UserProvider userProvider = Provider.of<UserProvider>(context);
    //AppStateProvider appState = Provider.of<AppStateProvider>(context);
    VendorProvider vendorProvider = Provider.of<VendorProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        drawer: Menu(),
        body: Stack(
          children: [
            MapScreen(scaffoldState),
            Visibility(
              visible: vendorProvider.showForVendor == Show.PICKUP_SELECTION,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                          components: [new Component(Component.country, "NG")],
                          types: [],
                          hint: "Search City",
                          startText: "");
                      if (p != null) {
                        PlacesDetailsResponse detail =
                            await places.getDetailsByPlaceId(p.placeId!);
                        double lat = detail.result.geometry!.location.lat;
                        double lng = detail.result.geometry!.location.lng;
                        /*vendorProvider.changeRequestedDestination(
                            reqDestination: p.description, lat: lat, lng: lng);*/
                        vendorProvider.updateDestination(
                            destination: p.description);
                        LatLng coordinates = LatLng(lat, lng);
                        vendorProvider.setDestination(coordinates: coordinates);
                        vendorProvider.addPickupMarker(vendorProvider.center!);
                        vendorProvider.changeWidgetShowed(
                            showWidget: Show.PICKUP_SELECTION);
                      }
                    },
                    textInputAction: TextInputAction.go,
                    controller: vendorProvider.destinationController,
                    cursorColor: Colors.blue.shade900,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          vendorProvider.changeWidgetShowed(
                              showWidget: Show.DESTINATION_SELECTION);
                        },
                      ),
                      hintText: "Enter destination",
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
            ),
            // ANCHOR Draggable
            Visibility(
                visible:
                    vendorProvider.showForVendor == Show.DESTINATION_SELECTION,
                child: DestinationSelectionWidget()),
            // ANCHOR PICK UP WIDGET
            Visibility(
              visible: vendorProvider.showForVendor == Show.PICKUP_SELECTION,
              child: PickupSelectionWidget(
                scaffoldState: scaffoldState,
              ),
            ),
            Visibility(
                visible: vendorProvider.showForVendor == Show.AVAILABLE_DRIVERS,
                child: AvailableDriversWidget(
                  scaffoldState: scaffoldState,
                )),
            //  ANCHOR Draggable DRIVER
            Visibility(
                visible: vendorProvider.showForVendor == Show.DRIVER_FOUND,
                child: DriverFoundWidget()),

            //  ANCHOR Draggable DRIVER
            Visibility(
                visible: vendorProvider.showForVendor == Show.TRIP,
                child: TripWidget()),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  MapScreen(this.scaffoldState);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapsPlaces? googlePlaces;
  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    // AppProvider app = Provider.of<AppProvider>(context);
    VendorProvider vendorProvider = Provider.of<VendorProvider>(context);

    return vendorProvider.center == null
        ? Center(child: CircularProgressIndicator())
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: vendorProvider.center!, zoom: 15),
                onMapCreated: vendorProvider.onCreate,
                /*onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },*/
                myLocationEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                rotateGesturesEnabled: true,
                markers: vendorProvider.markers,
                onCameraMove: vendorProvider.onCameraMove,
                polylines: vendorProvider.poly,
              ),
              Positioned(
                top: 10,
                left: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Center(
                    child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () {
                          scaffoldSate.currentState!.openDrawer();
                        }),
                  ),
                ),
              ),
            ],
          );
  }

  /*Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }*/
}
