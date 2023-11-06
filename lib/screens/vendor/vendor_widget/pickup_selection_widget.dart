import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:ride_app/providers/vendor_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:ride_app/helpers/constants.dart';
import 'package:ride_app/helpers/style.dart';
import '../../../widgets/custom_text.dart';

class PickupSelectionWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldState;

  const PickupSelectionWidget({this.scaffoldState});
  @override
  Widget build(BuildContext context) {
    //UserProvider userProvider = Provider.of<UserProvider>(context);
    //AppStateProvider appState = Provider.of<AppStateProvider>(context);
    VendorProvider vendorProvider = Provider.of<VendorProvider>(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.28,
      builder: (BuildContext context, myscrollController) {
        return Container(
          decoration: BoxDecoration(
              color: white,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                            topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: grey.withOpacity(.8),
                    offset: Offset(3, 2),
                    blurRadius: 7)
              ]),
          child: ListView(
            controller: myscrollController,
            children: [
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Move the pin to adjust pickup location",
                    size: 12,
                    weight: FontWeight.w300,
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  color: grey.withOpacity(.3),
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
                            reqDestination: p.description, lat: lat, lng: lng);
                        vendorProvider.updateDestination(destination: p.description);*/
                        LatLng coordinates = LatLng(lat, lng);
                        vendorProvider.setPickCoordinates(
                            coordinates: coordinates);
                        vendorProvider.changePickupLocationAddress(
                            address: p.description);
                      }
                    },
                    textInputAction: TextInputAction.go,
                    controller: vendorProvider.pickupLocationControlelr,
                    cursorColor: Colors.blue.shade900,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 15),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.location_on,
                          color: primary,
                        ),
                      ),
                      hintText: "Pick up location",
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
                width: double.infinity,
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      vendorProvider.changeWidgetShowed(
                          showWidget: Show.AVAILABLE_DRIVERS);
                      await vendorProvider.sendRequest();
                    },
                    // color: Colors.blue,
                    child: Text(
                      "Confirm Pickup",
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
