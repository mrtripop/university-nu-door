import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/home/components/home_button_control_door.dart';
import 'package:test_door/screens/home/components/home_feature_zone.dart';
import 'package:test_door/services/database.dart';
import 'home_header.dart';

class HomeBody extends StatefulWidget {
  final UserClass user;
  const HomeBody({Key key, this.user}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final referenceDatabase = FirebaseDatabase.instance;
  final firestore = FirebaseFirestore.instance;

  String stateDoor = "CLOSE";
  String assistState = "off";
  bool tapAssist = false;
  bool tapUnlock = false;
  String unlockState = "Lock";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Header(
              size: size,
              user: widget.user,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            //button
            Container(
              height: 200,
              child: ButtonRealtime(
                user: widget.user,
              ),
            ),
            SizedBox(
              height: size.height * 0.15,
            ),
            FeatureZone(
              size: size,
              assistState: assistState,
              tapAssist: tapAssist,
              unlockState: unlockState,
              tapUnlock: tapUnlock,
              onPressedRight: () {
                // firebase realtime database
                setState(() {
                  if (tapAssist) {
                    tapAssist = false;
                    assistState = "Off";
                  } else {
                    tapAssist = true;
                    assistState = "On";
                  }
                });
              },
              onPressedLeft: () {
                // firebase realtime database
                setState(() {
                  if (tapUnlock) {
                    tapUnlock = false;
                    unlockState = "Lock";
                  } else {
                    tapUnlock = true;
                    unlockState = "Unlock";
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class ButtonRealtime extends StatefulWidget {
  const ButtonRealtime({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserClass user;

  @override
  _ButtonRealtimeState createState() => _ButtonRealtimeState();
}

class _ButtonRealtimeState extends State<ButtonRealtime> {
  final referenceDatabase = FirebaseDatabase.instance;
  final firestore = FirebaseFirestore.instance;

  String stateDoor = "CLOSE";
  String assistState = "off";
  bool tapAssist = false;
  bool tapUnlock = false;
  String unlockState = "Lock";

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    final CollectionReference timeline = firestore.collection('home');

    DateTime now = DateTime.now();
    String date = "${now.day}-${now.month}-${now.year}";
    String time = "${now.hour}:${now.minute}:${now.second}";

    return FutureBuilder<DocumentSnapshot>(
        future: DatabaseService(uid: widget.user.uid).userinfo,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            print(data);
            return ButtonControlDoor(
              stateDoor: stateDoor,
              onPressed: () {
                setState(() {
                  stateDoor == 'CLOSE'
                      ? stateDoor = 'OPEN'
                      : stateDoor = 'CLOSE';
                });
                timeline.doc(data['masterID']).collection('timeline').add({
                  "uid": widget.user.uid,
                  "displayName": widget.user.displayName,
                  "command": stateDoor,
                  "unlock": false,
                  "date": date,
                  "time": time,
                  "create": FieldValue.serverTimestamp(),
                });
                ref.child(data['masterID']).child('command').set({
                  "stateDoor": stateDoor,
                  "uid": widget.user.uid,
                }).asStream();
              },
            );
          }
          return Container(
            color: Colors.white,
          );
        });
  }
}
