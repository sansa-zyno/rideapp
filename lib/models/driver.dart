class DriverModel {
  static const ID = "id";
  static const NAME = "name";
  static const LATITUDE = "latitude";
  static const LONGITUDE = "longitude";
  static const HEADING = "heading";
  static const POSITION = "position";
  static const CAR = "car";
  static const PLATE = "plate";
  static const PHOTO = "photo";
  static const RATING = "rating";
  static const VOTES = "votes";
  static const PHONE = "phone";

  String? _id;
  String? _name;
  String? _email;
  String? _photo;
  String? _phone;
  bool _booked = false;
  //double _rating;
  //int _votes;
  DriverPosition _position;
  Car _car;

  DriverModel(this._id, this._name, this._email, this._phone, this._photo,
      this._position, this._car, this._booked);

//  getters
  String get id => _id!;
  String get name => _name!;
  String get photo => _photo!;
  String get phone => _phone!;
  DriverPosition get position => _position;
  Car get car => _car;
  bool get booked => _booked;
  //double get rating => _rating;
  //int get votes => _votes;

  /*DriverModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    _phone = snapshot.data()[PHONE];
    _token = snapshot.data()[TOKEN];
    _photo = snapshot.data()[PHOTO];
    _votes = snapshot.data()[VOTES];
    _trips = snapshot.data()[TRIPS];
    _rating = snapshot.data()[RATING];
  }*/

  static List<DriverModel> drivers = [
    DriverModel(
        "1",
        "John Benson",
        "johnbenson@gmail.com",
        "090405090000",
        "images/male.png",
        DriverPosition(heading: 3.0, lat: 6.81944, lng: 3.91731),
        Car(name: "Toyota", plateNo: "XYZ", image: "images/car.png"),
        false),
    DriverModel(
        "2",
        "John Doe",
        "johndoe@gmail.com",
        "090405090000",
        "images/male.png",
        DriverPosition(heading: 4.0, lat: 6.90000, lng: 3.90000),
        Car(name: "Camry", plateNo: "ABC", image: "images/car.png"),
        false),
    DriverModel(
        "3",
        "Solomon Benson",
        "solomonbenson@gmail.com",
        "090405090000",
        "images/male.png",
        DriverPosition(heading: 5.0, lat: 6.601838, lng: 3.351486),
        Car(name: "Pigeot", plateNo: "WXY", image: "images/taxi.png"),
        true),
    DriverModel(
        "4",
        "Clement Joshua",
        "clementjoshua@gmail.com",
        "090405090000",
        "images/male.png",
        DriverPosition(heading: 6.0, lat: 6.50000, lng: 3.500000),
        Car(name: "Jeep", plateNo: "EFG", image: "images/car.png"),
        false),
    DriverModel(
        "5",
        "Joshua Benson",
        "joshuabenson@gmail.com",
        "090405090000",
        "images/male.png",
        DriverPosition(heading: 7.0, lat: 7.842958, lng: 3.936844),
        Car(name: "Hummer", plateNo: "IJK", image: "images/taxi.png"),
        true)
  ];
}

class DriverPosition {
  final double lat;
  final double lng;
  final double heading;

  DriverPosition({required this.lat, required this.lng, required this.heading});
}

class Car {
  String? name;
  String? plateNo;
  String? image;
  Car({required this.name, required this.plateNo, required this.image});
}
