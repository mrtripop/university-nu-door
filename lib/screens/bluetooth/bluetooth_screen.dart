import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:test_door/constants.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/bluetooth/component/bluetooth_select_bonded_device_page.dart';
import 'package:test_door/screens/bluetooth/component/chat_page.dart';

class Bluetooth extends StatelessWidget {
  final UserClass user;

  Bluetooth({@required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterBluetoothSerial.instance.requestEnable(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              child: Center(
                child: Icon(
                  Icons.bluetooth_disabled,
                  size: 200.0,
                  color: Colors.blue,
                ),
              ),
            ),
          );
        } else if (future.connectionState == ConnectionState.done) {
          return DeviceList(
            user: user,
          );
        } else {
          return NoDeviceList();
        }
      },
    );
  }
}

class DeviceList extends StatelessWidget {
  final UserClass user;

  DeviceList({@required this.user});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarBGcolor,
          elevation: 0,
        ),
        body: Container(
            height: screen.height,
            color: appBarBGcolor,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                child: Text(
                  'Paired Devices',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                height: screen.height * 0.125,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                            child: SelectBondedDevicePage(
                          onCahtPage: (device1) {
                            BluetoothDevice device = device1;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatPage(
                                    server: device,
                                    user: user,
                                  );
                                },
                              ),
                            );
                          },
                          user: user,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ])));
  }
}

class NoDeviceList extends StatelessWidget {
  const NoDeviceList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Note: เปิด Settings เพื่อเชื่อมต่อบลูทูธ',
          style: TextStyle(
              color: appBarBGcolor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
