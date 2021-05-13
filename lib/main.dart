import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:test_door/constants.dart';
import 'package:test_door/screens/wrapper.dart';
import 'package:test_door/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:test_door/models/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return someThingError();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserClass>.value(
            value: AuthService().user,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: kBackgroundColor,
                primaryColor: kPrimaryColor,
                textTheme:
                    Theme.of(context).textTheme.apply(bodyColor: kTextColor),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: Wrapper(),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget someThingError() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Test'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Column(
          children: [
            Center(
                child:
                    Text('Snapshot.hashError is Complete. Check in main.dart'))
          ],
        ),
      ),
    );
  }
}
