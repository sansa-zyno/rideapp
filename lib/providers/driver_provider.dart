import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ShowForDriver {
  RIDER, /*TRIP*/
}

class DriverProvider extends ChangeNotifier {
  DriverProvider() {
    _setCustomMapPin();
    _getUserLocation().then(
        (value) => Geolocator.getPositionStream().listen(_updatePosition));
  }

  Position? position;
  static LatLng? _center;
  ShowForDriver? showForDriver;
  bool hasNewRequest = false;
  LatLng? destinationCoordinates;
  LatLng? pickupCoordinates;

  //getters
  LatLng? get center => _center;
  Set<Marker> get markers => _markers;
  Set<Polyline> get poly => _poly;

  Set<Marker> _markers = {};
  //  this polys will be displayed on the map
  Set<Polyline> _poly = {};

  //   taxi pin
  BitmapDescriptor? carPin;
  //   location pin
  BitmapDescriptor? locationPin;

  _updatePosition(Position newPosition) {
    position = newPosition;
    log("update postion from driver");

    notifyListeners();
  }

  Future<Position> _getUserLocation() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    Future<Position> getLocation() async {
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }

    position = await getLocation();
    /* List<Placemark> placemark =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    if (prefs.getString(COUNTRY) == null) {
      String country = placemark[0].isoCountryCode!.toLowerCase();
      await prefs.setString(COUNTRY, country);
    }*/

    _center = LatLng(position!.latitude, position!.longitude);
    notifyListeners();
    return position!;
  }

  _setCustomMapPin() async {
    carPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/taxi.png');

    locationPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/pin.png');
  }
}
