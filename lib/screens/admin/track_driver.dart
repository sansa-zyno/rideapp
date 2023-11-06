import 'package:flutter/material.dart';
import 'package:ride_app/providers/admin_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TrackDriver extends StatefulWidget {
  LatLng? position;
  TrackDriver(this.position);
  @override
  _TrackDriverState createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {
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
    //    this section down here will update the Admins current position on the DB when the app is opened
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _id = _prefs.getString("id");
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);
    AppStateProvider _app =
        Provider.of<AppStateProvider>(context, listen: false);
    _user.updateUserData({"id": _id, "position": _app.position.toJson()});
  }*/

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider = Provider.of<AdminProvider>(context);
    return SafeArea(
      child: Scaffold(
          key: scaffoldState,
          // drawer: Menu(),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: widget.position!, zoom: 15),
                //onMapCreated: appState.onCreate,
                myLocationEnabled: true,
                mapType: MapType.normal,
                cameraTargetBounds: CameraTargetBounds(
                    adminProvider.bounds(adminProvider.markers)!),
                tiltGesturesEnabled: true,
                compassEnabled: false,
                markers: adminProvider.markers,
                //onCameraMove: appState.onCameraMove,
                polylines: adminProvider.poly,
              ),
              Positioned(
                top: 10,
                left: 15,
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.blue,
                      size: 30,
                    ),
                    onPressed: () {
                      // scaffoldSate.currentState!.openDrawer();
                    }),
              ),
            ],
          )),
    );
  }
}
