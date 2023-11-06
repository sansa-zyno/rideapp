import 'package:flutter/material.dart';
import 'package:ride_app/providers/vendor_provider.dart';
import 'package:provider/provider.dart';
import 'package:ride_app/helpers/style.dart';
import '../../../widgets/custom_text.dart';

class DriverFoundWidget extends StatelessWidget {
  //final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  @override
  Widget build(BuildContext context) {
    //AppStateProvider appState = Provider.of<AppStateProvider>(context);
    VendorProvider vendorProvider = Provider.of<VendorProvider>(context);

    return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.05,
        maxChildSize: 0.8,
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
                    Container(
                        child: true // appState.driverArrived == false
                            ? CustomText(
                                text: "Your ride arrives in 30 minutes",
                                // 'Your ride arrives in ${appState.routeModel.timeNeeded.text}',
                                size: 12,
                                weight: FontWeight.w300,
                              )
                            : CustomText(
                                text: 'Your ride has arrived',
                                size: 12,
                                color: green,
                                weight: FontWeight.w500,
                              )),
                  ],
                ),
                Divider(),
                ListTile(
                  leading: Container(
                    child: true
                        //appState.driverModel?.photo  == null
                        ? CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.person_outline,
                              size: 25,
                            ),
                          )
                        : CircleAvatar(
                            radius: 30,
                            //backgroundImage: NetworkImage(appState.driverModel?.photo),
                          ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    "Mr Adesoji Samuel\n", //appState.driverModel.name + "\n",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "Toyota", // appState.driverModel.car,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300)),
                          ], style: TextStyle(color: black))),
                    ],
                  ),
                  subtitle: ElevatedButton(
                      //color: Colors.grey.withOpacity(0.5),
                      onPressed: null,
                      child: CustomText(
                        text: "XYZCDASERT123", // appState.driverModel.plate,
                        color: white,
                      )),
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        onPressed: () {
                          // _service.call(appState.driverModel.phone);
                        },
                        icon: Icon(Icons.call),
                      )),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CustomText(
                    text: "Ride details",
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 100,
                      width: 10,
                      child: Column(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Container(
                              height: 45,
                              width: 2,
                              color: primary,
                            ),
                          ),
                          Icon(Icons.flag),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "\nPick up location \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "${vendorProvider.pickupLocationControlelr.text.split(",").first} \n\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16)),
                      TextSpan(
                          text: "Destination \n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "${vendorProvider.destinationController.text.split(",").first} \n",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16)),
                    ], style: TextStyle(color: black))),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CustomText(
                        text: "Ride price",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CustomText(
                        text: "", //\$${appState.ridePrice}",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () {},
                    //color: red,
                    child: CustomText(
                      text: "Cancel Ride",
                      color: white,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
