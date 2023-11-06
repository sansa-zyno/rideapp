import 'package:flutter/material.dart';
import 'package:ride_app/helpers/stars_method.dart';
import 'package:ride_app/helpers/style.dart';
import 'package:ride_app/providers/driver_provider.dart';
import 'package:ride_app/screens/driver/driver_widget/menu.dart';
import 'package:ride_app/screens/driver/driver_widget/rider_draggable.dart';
import 'package:ride_app/screens/driver/ride_request.dart';
import 'package:ride_app/widgets/custom_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
//import "package:google_maps_webservice/places.dart";
//GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

class DriverHome extends StatefulWidget {
  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_deviceToken();
    //_updatePosition();
    /* fcm.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppStateProvider _app =
          Provider.of<AppStateProvider>(context, listen: false);
      _app.handleNotificationData(message.data);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppStateProvider _app =
          Provider.of<AppStateProvider>(context, listen: false);
      _app.handleNotificationData(message.data);
    });*/
  }

  /*_deviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);

    if (_user.userModel.token != preferences.getString('token')) {
      Provider.of<UserProvider>(context, listen: false).saveDeviceToken();
    }
  }*/

  /* _updatePosition() async {
    //    this section down here will update the drivers current position on the DB when the app is opened
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _id = _prefs.getString("id");
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);
    AppStateProvider _app =
        Provider.of<AppStateProvider>(context, listen: false);
    _user.updateUserData({"id": _id, "position": _app.position.toJson()});
  }*/

  @override
  Widget build(BuildContext context) {
    // AppStateProvider appState = Provider.of<AppStateProvider>(context);
    // UserProvider userProvider = Provider.of<UserProvider>(context);
    DriverProvider driverProvider = Provider.of<DriverProvider>(context);
    Widget home = SafeArea(
      child: Scaffold(
          key: scaffoldState,
          drawer: Menu(),
          body: Stack(
            children: [
              MapScreen(scaffoldState),
              Positioned(
                  top: 60,
                  left: MediaQuery.of(context).size.width / 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [BoxShadow(color: grey, blurRadius: 17)]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child:
                                  true //userProvider.userModel?.photo == null
                                      ? CircleAvatar(
                                          radius: 30,
                                          child: Icon(
                                            Icons.person_outline,
                                            size: 25,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              "" //userProvider.userModel?.photo
                                              ),
                                        ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text:
                                        "Driver A", //userProvider.userModel?.name,
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  stars(
                                      rating:
                                          10, //userProvider.userModel.rating,
                                      votes: 4 //userProvider.userModel.votes
                                      )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              //  ANCHOR Draggable DRIVER
              Visibility(
                  visible: driverProvider.showForDriver == ShowForDriver.RIDER,
                  child: RiderWidget()),
            ],
          )),
    );

    switch (driverProvider.hasNewRequest) {
      case false:
        return home;
      case true:
        return RideRequestScreen();
      default:
        return home;
    }
  }
}

class MapScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  MapScreen(this.scaffoldState);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //GoogleMapsPlaces googlePlaces;
  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();
  String position = "postion";

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    // AppProvider app = Provider.of<AppProvider>(context);
    DriverProvider driverProvider = Provider.of<DriverProvider>(context);
    return driverProvider.center == null
        ? Center(child: CircularProgressIndicator())
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: driverProvider.center!, zoom: 15),
                //onMapCreated: appState.onCreate,
                myLocationEnabled: true,
                mapType: MapType.normal,
                tiltGesturesEnabled: true,
                compassEnabled: false,
                markers: driverProvider.markers,
                //onCameraMove: appState.onCameraMove,
                polylines: driverProvider.poly,
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
}
