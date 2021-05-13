import 'dart:convert';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:test_door/main_component/textField.dart';
import 'package:test_door/main_component/outlineButtonTemplate.dart';
import 'package:test_door/models/user_model.dart';

import '../../../constants.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;
  final UserClass user;

  const ChatPage({this.server, @required this.user});

  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  BluetoothConnection connection;

  final ssid = TextEditingController();
  final password = TextEditingController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;

  bool sendSuccess = false;
  bool connectionError = false;

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  void setup() {
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;

      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).onError((error, stackTrace) {
      print('error connection');
      setState(() {
        connectionError = true;
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  void _onDataReceived(Uint8List data) {
    print('Data incoming: ${ascii.decode(data)}');
  }

  void _sendMessage(String text) async {
    text = text.trim();
    ssid.clear();
    password.clear();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        // await connection.finish();
        setState(() {
          sendSuccess = true;
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    if (connectionError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Add Your Code here.
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          borderSide: BorderSide(color: Colors.red, width: 2),
          width: MediaQuery.of(context).size.width * 0.95,
          btnCancelOnPress: () {
            Navigator.of(context).pop();
          },
          btnOkOnPress: () {
            Navigator.of(context).pop();
          },
          body: Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                  'ไม่สามารถเชื่อมต่ออุปกรณ์นี้ได้ โปรดตรวจสอบสถานะอุปกรณ์ของท่าน'),
            ),
          ),
        )..show();

        setState(() {
          connectionError = false;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarBGcolor,
      ),
      body: connectionError
          ? Container(
              color: Colors.white,
            )
          : SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Center(
                        child: isConnected
                            ? Text(
                                widget.server.name,
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Device connecting',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: appBarBGcolor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36))),
                  ),
                  Flexible(
                    child: Container(
                      height: screen.height,
                      padding: EdgeInsets.all(30.0),
                      child: ListView(children: [
                        Text(
                          'WIFI settings',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          hintText: 'SSID',
                          labelText: 'WIFI name',
                          controller: ssid,
                          enabled: isConnected,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          labelText: 'password',
                          hintText: 'password',
                          controller: password,
                          enabled: isConnected,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // MyTextField(
                        //   labelText: 'UID',
                        //   hintText: 'UID',
                        //   controller: uid,
                        //   enabled: isConnected,
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        OutlinedButtonTemplate(
                          child: Text('Save'),
                          sideWidth: 1,
                          sideColor: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          colorText: Colors.white,
                          colorShadow: appBarBGcolor.withOpacity(0.2),
                          colorBG: appBarBGcolor,
                          size:
                              Size(MediaQuery.of(context).size.width * 0.4, 60),
                          elevation: 7,
                          foregroundColor: Colors.white,
                          onPressed: () {
                            if (ssid.text != "" && password.text != "") {
                              String toJson =
                                  "{\"ssid\": \"${ssid.text}\",\"password\": \"${password.text}\",\"uid\":\"${widget.user.uid}\"}";
                              print(toJson);
                              _sendMessage(toJson);
                            } else {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.ERROR,
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                width: MediaQuery.of(context).size.width * 0.95,
                                btnCancelOnPress: () {
                                  ssid.clear();
                                  password.clear();
                                },
                                body: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: Text('ท่านใส่ข้อมูลไม่ครบถ้วน'),
                                  ),
                                ),
                              )..show();
                            }
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
