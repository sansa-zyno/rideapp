/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healitia/constant.dart';
import 'package:healitia/menu/navigationbars/user_navigationbar.dart';
import 'package:healitia/menu/navigationbars/professional_navigationbar.dart';
import 'package:healitia/services/authservice.dart';

class UserTypeSelector extends StatefulWidget {
  @override
  _UserTypeSelectorState createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  bool _prefloading = false;
  String currentUserId;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _prefloading = true;
      });
      User currentUser = await AuthService().getCurrentUser();
      setState(() {
        currentUserId = currentUser.uid;
        _prefloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _prefloading == true
          ? new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(USER_COLLECTION)
                  .doc(currentUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
//          if(snapshot.data['admin']!=null && snapshot.data['admin'] == true)
//            return AdminPanelMainPage(snapshot);
                if (snapshot.data[USER_TYPE] == TYPE_PROFESSIONAL) {
                  return ProfessionalNavigationBar(snapshot);
                }
                return UserNavigationBar(snapshot);
              }),
    );
  }
}*/
