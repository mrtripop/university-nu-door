import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/bluetooth/bluetooth_screen.dart';
import 'package:test_door/screens/profile/profile_screen.dart';
import 'package:test_door/services/auth.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  final UserClass user;
  const Header({Key key, @required this.size, this.user}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            height: size.height * 0.25,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 7)
              ],
              color: appBarBGcolor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/home.png',
                        width: size.width * 0.6,
                      ),
                      Spacer(),
                      SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.2,
                        child: buildImage(context),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  Text(
                    user.displayName != null ? user.displayName : "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer()
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    final AuthService _auth = AuthService();
    return FocusedMenuHolder(
        blurSize: 1,
        blurBackgroundColor: Colors.white,
        openWithTap: true,
        child: SvgPicture.asset(
          "assets/icons/icon_home.svg",
        ),
        onPressed: () {},
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Text('Profile'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_buildContext) => ProfileScreen(
                          user: user,
                        )));
              }),
          FocusedMenuItem(
              title: Text('Setting'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_buildContext) => Bluetooth(
                          user: user,
                        )));
              }),
          FocusedMenuItem(
              title: Text('Switch Account'),
              onPressed: () async {
                await _auth.signOutGoogle();
                await _auth.signOut();
              }),
          FocusedMenuItem(
              backgroundColor: Colors.red,
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              })
        ]);
  }
}
