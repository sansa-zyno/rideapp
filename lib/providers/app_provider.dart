/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/driver.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  Position? position;
  static LatLng? _center;
  LatLng? get center => _center;

  AppProvider() {
    _getUserLocation().then(
        (value) => Geolocator.getPositionStream().listen(_updatePosition));
  }

  _updatePosition(Position newPosition) {
    position = newPosition;
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

  /*//markers
  addPickupMarker(LatLng position) {
    if (pickupCoordinates == null) {
      pickupCoordinates = position;
    }
    _markers.add(Marker(
        markerId: MarkerId(PICKUP_MARKER_ID),
        position: position,
        anchor: Offset(0, 0.85),
        zIndex: 3,
        infoWindow: InfoWindow(title: "Pickup", snippet: "location"),
        icon: locationPin!));
    notifyListeners();
  }*/
}*/
