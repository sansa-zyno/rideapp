import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ride_app/helpers/screen_navigation.dart';
import 'package:ride_app/models/driver.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/providers/vendor_provider.dart';
import 'package:ride_app/screens/payments.dart';
import 'package:ride_app/widgets/custom_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ride_app/helpers/style.dart';

class AvailableDriversWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldState;
  AvailableDriversWidget({this.scaffoldState});
  @override
  Widget build(BuildContext context) {
    VendorProvider vendorProvider = Provider.of<VendorProvider>(context);
    List<DriverModel> drivers = DriverModel.drivers;
    return DraggableScrollableSheet(
      initialChildSize: 0.50,
      minChildSize: 0.28,
      builder: (BuildContext context, myscrollController) {
        return Container(
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(.8),
                      offset: Offset(3, 2),
                      blurRadius: 7)
                ]),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: myscrollController,
                      itemCount: drivers.take(3).toList().length,
                      itemBuilder: (ctx, index) => Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      "${drivers[index].car.image}",
                                      height: 50,
                                      width: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "${drivers[index].car.name}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("3:14pm 6 min away")
                                      ],
                                    ),
                                    Text("NGN 15,0000")
                                  ]),
                            ),
                          )),
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            offset: Offset(2, 2),
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        onTap: () {
                          changeScreen(context, Payments());
                        },
                        leading: Icon(
                          Icons.money,
                          color: Colors.blue,
                        ),
                        title: Row(
                          children: [
                            Text(
                              "Cash",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
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
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SpinKitWave(
                                                color: black,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      text:
                                                          "Looking for a driver"),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              LinearPercentIndicator(
                                                lineHeight: 4,
                                                animation: true,
                                                animationDuration: 100000,
                                                percent: 1,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.2),
                                                progressColor:
                                                    Colors.deepOrange,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        //appState
                                                        //  .cancelRequest();
                                                        /*scaffoldState!
                                                            .currentState!.
                                                            SnackBar(SnackBar(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                content: Text(
                                                                    "Request cancelled!")));*/
                                                      },
                                                      child: CustomText(
                                                        text: "Cancel Request",
                                                        color:
                                                            Colors.deepOrange,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                              vendorProvider.percentageCounter(
                                  context: context);
                            },
                            //color: Colors.blue,
                            child: Text(
                              "Confirm order",
                              style: TextStyle(color: white, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
