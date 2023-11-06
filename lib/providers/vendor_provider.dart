import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_app/helpers/map_requests.dart';
import 'package:ride_app/helpers/style.dart';
import 'package:ride_app/models/driver.dart';
import 'package:ride_app/models/route.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;

enum Show {
  DESTINATION_SELECTION,
  PICKUP_SELECTION,
  PAYMENT_METHOD_SELECTION,
  DRIVER_FOUND,
  TRIP,
  AVAILABLE_DRIVERS
}

class VendorProvider extends ChangeNotifier {
  /// Stream
  Stream<double>? infoStream;

  VendorProvider() {
    if (infoStream == null) {
      infoStream = Stream<double>.periodic(Duration(milliseconds: 250), (x) {
        //for listening sake but List not used
        return 0.001;
      });
    }
    /*_setCustomMapPin().then((value) {
      double extra = 0;
      infoStream!.listen((event) {
        extra = extra + event;
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
    });*/
    double extra = 0;
    infoStream!.listen((event) {
      extra = extra + event;
      /*DriverModel.drivers.forEach((driver) {
          _addDriverMarker(
              driverId: driver.id,
              position: LatLng(
                  (driver.position.lat + extra), (driver.position.lng + extra)),
              rotation: driver.position.heading);
        });*/
      if (carPin != null && locationPin != null) {
        _updateMarkers(DriverModel.drivers, extra);
        log("extra value " + extra.toString());
      }
    });
    _getUserLocation().then(
        (value) => Geolocator.getPositionStream().listen(_updatePosition));
  }

  GoogleMapController? _mapController;
  Position? position;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  RouteModel? routeModel;
  double ridePrice = 0;
  Show showForVendor = Show.DESTINATION_SELECTION;
  bool payment = false;
  static LatLng? _center;
  List locations = [];
  TextEditingController destinationController = TextEditingController(text: "");
  TextEditingController pickupLocationControlelr =
      TextEditingController(text: "");
  static const PICKUP_MARKER_ID = 'pickup';
  static const LOCATION_MARKER_ID = 'location';
  //String? requestedDestination;
  //double? requestedDestinationLat;
  //double? requestedDestinationLng;
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

  //  Driver request related variables
  bool lookingForDriver = false;
  bool alertsOnUi = false;
  bool driverFound = false;
  bool driverArrived = false;
  int timeCounter = 0;
  double percentage = 0;
  Timer? periodicTimer;

  _updatePosition(Position newPosition) {
    position = newPosition;
    log("update postion from vendor");
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

  onCreate(GoogleMapController controller) {
    _mapController = controller;
    // notifyListeners();
  }

  onCameraMove(CameraPosition position) async {
    //  MOVE the pickup marker only when selecting the pickup location
    if (showForVendor == Show.PICKUP_SELECTION) {
      // _lastPosition = position.target;
      changePickupLocationAddress(address: "loading...");
      if (_markers.isNotEmpty) {
        List toRemove = [];
        if (_markers.isNotEmpty) {
          _markers.forEach((element) async {
            if (element.markerId.value == PICKUP_MARKER_ID) {
              toRemove.add(element);
            }
          });
          _markers.removeWhere((e) => toRemove.contains(e));
          pickupCoordinates = position.target;
          addPickupMarker(position.target);
          List<Placemark> placemark = await placemarkFromCoordinates(
              position.target.latitude, position.target.longitude);
          pickupLocationControlelr.text = placemark[0].name!;
          notifyListeners();
        }
      }
    }
  }

  changeWidgetShowed({Show? showWidget}) {
    showForVendor = showWidget!;
    notifyListeners();
  }

  paymentMade(bool val) {
    payment = val;
    notifyListeners();
  }

  /*changeRequestedDestination(
      {String? reqDestination, double? lat, double? lng}) {
    requestedDestination = reqDestination;
    requestedDestinationLat = lat;
    requestedDestinationLng = lng;
    notifyListeners();
  }*/

  void updateDestination({String? destination}) {
    destinationController.text = destination!;
    locations.add(destination);
    notifyListeners();
  }

  setDestination({LatLng? coordinates}) {
    destinationCoordinates = coordinates;
    notifyListeners();
  }

  setPickCoordinates({LatLng? coordinates}) {
    pickupCoordinates = coordinates;
    List toRemove = [];
    if (_markers.isNotEmpty) {
      _markers.forEach((element) async {
        if (element.markerId.value == PICKUP_MARKER_ID) {
          toRemove.add(element);
        }
      });
      _markers.removeWhere((e) => toRemove.contains(e));
      addPickupMarker(coordinates!);
    }
    _mapController!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pickupCoordinates!, zoom: 15.0),
      ),
    );
    notifyListeners();
  }

  changePickupLocationAddress({String? address}) {
    pickupLocationControlelr.text = address!;
    if (pickupCoordinates != null) {
      //_center = pickupCoordinates;
    }
    notifyListeners();
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

  setCustomMapPin(BuildContext ctx) async {
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

  //by hassan,not request but get route,update marker,_center and polyline
  Future sendRequest({LatLng? origin, LatLng? destination}) async {
    LatLng? _org;
    LatLng? _dest;

    if (origin == null && destination == null) {
      _org = pickupCoordinates;
      _dest = destinationCoordinates;
    } else {
      _org = origin;
      _dest = destination;
    }
    RouteModel route =
        await _googleMapsServices.getRouteByCoordinates(_org!, _dest!);
    routeModel = route;

    if (origin == null) {
      ridePrice =
          double.parse((routeModel!.distance.value! / 500).toStringAsFixed(2));
    }
    List<Marker> mks = _markers
        .where((element) => element.markerId.value == "location")
        .toList();
    if (mks.length >= 1) {
      _markers.remove(mks[0]);
    }
// ! another method will be created just to draw the polys and add markers
    _addLocationMarker(destinationCoordinates!, routeModel!.timeNeeded.text!,
        routeModel!.distance.text!);
    _center = destinationCoordinates;
    _createRoute(route.points, color: Colors.blue);
    _mapController!
        .animateCamera(CameraUpdate.newLatLngBounds(bounds(_markers)!, 50));
    //_routeToDestinationPolys = _poly;
    notifyListeners();
  }

  /* Future<String> sendRequest2({LatLng? origin, LatLng? destination}) async {
    RouteModel route =
        await _googleMapsServices.getRouteByCoordinates(origin!, destination!);
    return route.timeNeeded.text!;
  }*/

  // ANCHOR: MARKERS AND POLYS
  _addLocationMarker(LatLng position, String timeNeeded, String distance) {
    _markers.add(Marker(
        markerId: MarkerId(LOCATION_MARKER_ID),
        position: position,
        anchor: Offset(0, 0.85),
        infoWindow:
            InfoWindow(title: "Arrive in ${timeNeeded}", snippet: distance),
        icon: locationPin!));
    Future.delayed(Duration(milliseconds: 250), () {
      _mapController!.showMarkerInfoWindow(MarkerId(LOCATION_MARKER_ID));
    });

    notifyListeners();
  }

  addPickupMarker(LatLng position) {
    if (pickupCoordinates == null) {
      pickupCoordinates = position;
    }
    _markers.add(Marker(
        markerId: MarkerId(PICKUP_MARKER_ID),
        position: position,
        anchor: Offset(0, 0.85),
        zIndex: 3,
        infoWindow: InfoWindow(title: "Pickup", snippet: "Pickup location"),
        icon: locationPin!));
    Future.delayed(Duration(milliseconds: 250), () {
      _mapController!.showMarkerInfoWindow(MarkerId(PICKUP_MARKER_ID));
    });
    notifyListeners();
  }

  void _addDriverMarker(
      {LatLng? position, double? rotation, String? driverId}) {
    //log(position.toString());
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
    List<Marker> locationMarkers = _markers
        .where((element) => element.markerId.value == 'location')
        .toList();
    List<Marker> pickupMarkers = _markers
        .where((element) => element.markerId.value == 'pickup')
        .toList();
    clearMarkers();
    if (locationMarkers.length > 0) {
      _markers.add(locationMarkers[0]);
    }
    if (pickupMarkers.length > 0) {
      _markers.add(pickupMarkers[0]);
    }

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

  _createRoute(String decodeRoute, {Color? color}) {
    clearPoly();
    var uuid = new Uuid();
    String polyId = uuid.v1();
    _poly.add(Polyline(
        polylineId: PolylineId(polyId),
        width: 8,
        color: color ?? primary,
        onTap: () {},
        points: _convertToLatLong(_decodePoly(decodeRoute))));
    notifyListeners();
  }

  List<LatLng> _convertToLatLong(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
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

//  Timer counter for driver request
  percentageCounter({String? requestId, BuildContext? context}) {
    //lookingForDriver = true;
    //notifyListeners();
    periodicTimer = Timer.periodic(Duration(seconds: 1), (time) {
      timeCounter = timeCounter + 1;
      percentage = timeCounter / 100;
      // print("====== GOOOO $timeCounter");
      if (timeCounter == 100) {
        timeCounter = 0;
        percentage = 0;
        Navigator.pop(context!);
        showForVendor = Show.DRIVER_FOUND;
        // lookingForDriver = false;
        // _requestServices.updateRequest({"id": requestId, "status": "expired"});
        time.cancel();
        //if (alertsOnUi) {
        //Navigator.pop(context);
        //alertsOnUi = false;
        // notifyListeners();
        // }
        // requestStream.cancel();
      }
      //notifyListeners();
    });
  }

  clearPoly() {
    _poly.clear();
    notifyListeners();
  }
}
