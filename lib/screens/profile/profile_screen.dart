import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/profile/profile_qrcode.dart';

class ProfileScreen extends StatelessWidget {
  final UserClass user;
  const ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        title: Text('User Profile'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.pinkAccent,
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.4,
                        height: double.infinity,
                        child: Container(
                          margin: EdgeInsets.all(25),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.black12,
                                spreadRadius: 3)
                          ], shape: BoxShape.circle, color: Colors.white),
                          child: SvgPicture.asset(
                            'assets/icons/male_user.svg',
                            semanticsLabel: 'Profile',
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.displayName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Status: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                      ))
                    ],
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 30),
                width: size.width,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Information',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(user.email),
                                Spacer(),
                              ]),
                          height: 60,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36)),
                              color: Colors.grey[200]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(user.uid),
                                Spacer(),
                              ]),
                          height: 60,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36)),
                              color: Colors.grey[200]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'QRcode',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        QRCode(user: user),
                      ]),
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
