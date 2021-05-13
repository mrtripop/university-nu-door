import 'package:flutter/material.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/account/account_screen.dart';
import 'package:test_door/screens/home/components/home_body.dart';
import 'package:test_door/screens/timeline/timeline_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserClass user;
  const HomeScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      HomeBody(
        user: widget.user,
      ),
      TimelineScreen(
        user: widget.user,
      ),
      AccountScreen(
        user: widget.user,
      ),
    ];

    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
