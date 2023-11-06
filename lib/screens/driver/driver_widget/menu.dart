import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/screens/login.dart';
import 'package:ride_app/screens/payments.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool aktivate = false;
  bool testify = false;
  bool extra = false;

  XFile? image;
  String imageUrl = "";
  String? username;
  String? useremail;

  getUserData() async {
    /*username = await LocalStorage().getString("username");
    final response =
        await HttpService.post(Api.getEmail, {"username": username});
    useremail = response.data;
    setState(() {});
    getImage();*/
  }

  getImage() async {
    /* try {
      Response res = await HttpService.postWithFiles(
          Api.getProfilePics, {"username": username});
      imageUrl = jsonDecode(res.data)[0]["avatar"];
    } catch (e) {
      imageUrl = "";
    }
    setState(() {});*/
  }

  uploadImage() async {
    /*image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Response res = await HttpService.postWithFiles(Api.changeProfilePics, {
        "username": username,
        "image": MultipartFile.fromBytes(File(image!.path).readAsBytesSync(),
            filename: image!.name)
      });
      final result = jsonDecode(res.data);
      if (result["Status"] == "succcess") {
        getImage();
        AchievementView(
          context,
          color: Color(0xFF072A6C),
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          title: "Success!",
          elevation: 20,
          subTitle: "Profile picture uploaded successfully",
          isCircle: true,
        ).show();
      } else {
        AchievementView(
          context,
          color: Colors.red,
          icon: Icon(
            Icons.bug_report,
            color: Colors.white,
          ),
          title: "Failed!",
          elevation: 20,
          subTitle: "Profile picture upload failed",
          isCircle: true,
        ).show();
      }
    }*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[600],
              ),
              currentAccountPicture: CircularProfileAvatar(
                "",
                backgroundColor: Color(0xffDCf0EF),
                initialsText: Text(
                  "+",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900,
                      fontSize: 21,
                      color: Colors.white),
                ),
                //cacheImage: true,
                borderWidth: 2,
                elevation: 10,
                radius: 50,
                onTap: () {
                  uploadImage();
                },
                child: imageUrl != ""
                    ? Image.network(
                        "https://empowermentfoodnetwork.com/office/uploads//images//${imageUrl.substring(15, (imageUrl.length))}",
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.camera_alt),
              ),
              accountName: Text("${username != null ? username : ""}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
              accountEmail: Text("${useremail != null ? useremail : ""}",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white))),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                ListTile(
                  leading: Icon(
                    Icons.payment,
                    color: Colors.blue,
                  ),
                  title: Text("Payments",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Payments()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.wallet_giftcard,
                    color: Colors.blue,
                  ),
                  title: Text("Promotions",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: EditProfile()),
                    );*/
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.time_to_leave_rounded,
                    color: Colors.blue,
                  ),
                  title: Text("My Rides",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: ChangePassword()),
                    );*/
                  },
                ),
                ListTile(
                  leading: Icon(
                    Boxicons.bx_help_circle,
                    color: Colors.blue,
                  ),
                  title: Text("Support",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: ChangePassword()),
                    );*/
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.details,
                    color: Colors.blue,
                  ),
                  title: Text("About",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: ChangePassword()),
                    );*/
                  },
                ),
                ListTile(
                  leading: Icon(
                    Boxicons.bx_log_out_circle,
                    color: Colors.blue,
                  ),
                  title: Text("Logout",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    //LocalStorage().clearPref();
                    //AppbackgroundService().stopBg();
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Sign_in_screen()),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
