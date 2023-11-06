import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ride_app/models/driver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;

class AdminProvider extends ChangeNotifier {
  /// Stream
  Stream<double>? infoStream2;
  double extra = 0;
  AdminProvider() {
    if (infoStream2 == null) {
      infoStream2 = Stream<double>.periodic(Duration(milliseconds: 250), (x) {
        //for listening sake but List not used
        return 0.00001;
      });
    }
    _setCustomMapPin().then((value) {
      infoStream2!.listen((event) {
        extra = extra + event;
        notifyListeners();
        /*DriverModel.drivers.forEach((driver) {
          _addDriverMarker(
              driverId: driver.id,
              position: LatLng(
                  (driver.position.lat + extra), (driver.position.lng + extra)),
              rotation: driver.position.heading);
        });*/
        _updateMarkers(DriverModel.drivers, extra);
        log(extra.toString());
      });
    });
    _getUserLocation().then(
        (value) => Geolocator.getPositionStream().listen(_updatePosition));
  }

  Position? position;
  static LatLng? _center;

  //getters
  Set<Marker> get markers => _markers;
  Set<Polyline> get poly => _poly;
  LatLng? get center => _center;

  Set<Marker> _markers = {};
  //  this polys will be displayed on the map
  Set<Polyline> _poly = {};

  //   taxi pin
  BitmapDescriptor? carPin;
  //   location pin
  BitmapDescriptor? locationPin;

  _updatePosition(Position newPosition) {
    position = newPosition;
    log("update postion from admin");

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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future _setCustomMapPin() async {
    //ImageConfiguration configuration = createLocalImageConfiguration(ctx);
    final Uint8List markerIcon = await getBytesFromAsset('images/taxi.png', 25);
    carPin = BitmapDescriptor.fromBytes(markerIcon);

    /* carPin = await BitmapDescriptor.fromAssetImage(
        //ImageConfiguration(devicePixelRatio: 2.5), 'images/taxi.png');
        //ImageConfiguration(devicePixelRatio: 1.5, size: Size(10, 10)),
        configuration,
        'images/taxi.png');*/

    log("done for car pin");

    locationPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/pin.png');
  }

  void _addDriverMarker(
      {LatLng? position, double? rotation, String? driverId}) {
    var uuid = new Uuid();
    String markerId = uuid.v1();
    _markers.add(Marker(
        markerId: MarkerId(markerId),
        position: position!,
        rotation: rotation!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(1, 1),
        icon: carPin!));
  }

  _updateMarkers(List<DriverModel> drivers, double extra) {
//    this code will ensure that when the driver markers are updated the location marker wont be deleted
    clearMarkers();

//    here we are updating the drivers markers
    drivers.forEach((DriverModel driver) {
      _addDriverMarker(
          driverId: driver.id,
          position: LatLng(
              (driver.position.lat + extra), (driver.position.lng - extra)),
          rotation: (driver.position.heading + extra));
    });
  }

  clearMarkers() {
    _markers.clear();
    notifyListeners();
  }

  LatLngBounds? bounds(Set<Marker>? markers) {
    if (markers == null || markers.isEmpty) return null;
    return createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }
}
