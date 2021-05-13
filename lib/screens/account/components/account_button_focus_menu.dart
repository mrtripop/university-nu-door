import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:test_door/main_component/textField.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/services/database.dart';

import 'account_qrscanner.dart';

class ButtonFocusMenu extends StatefulWidget {
  const ButtonFocusMenu({
    Key key,
    @required this.size,
    @required this.user,
  }) : super(key: key);

  final Size size;
  final UserClass user;

  @override
  _ButtonFocusMenuState createState() => _ButtonFocusMenuState();
}

class _ButtonFocusMenuState extends State<ButtonFocusMenu> {
  String qrCode = 'Unknown';

  void addmember(
      BuildContext context, String memberid, CollectionReference firestore) {
    firestore.doc(memberid).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        //write data
        DatabaseService(uid: widget.user.uid).addMember(
            memberid, doc.data()['displayName'], doc.data()['email'], 'member');
        DatabaseService(uid: memberid).editUserData(widget.user.uid, 'member');
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          borderSide: BorderSide(color: Colors.blue, width: 2),
          width: widget.size.width * 0.95,
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
          body: Center(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    'ไม่พบหมายเลขบัญชีผู้ใช้นี้ในระบบ',
                  ),
                ],
              ),
            ),
          ),
        )..show();
      }
    });
  }

  void deleteMember(String memberid, CollectionReference firestore) {
    firestore.doc(widget.user.uid).collection('member').doc(memberid).delete();
    DatabaseService(uid: memberid).editUserData(memberid, 'master');
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
      print('This qrcode: ${this.qrCode}');
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController memberuid = TextEditingController();
    TextEditingController deleteMemberuid = TextEditingController();

    final firestore = FirebaseFirestore.instance.collection('home');
    return FocusedMenuHolder(
        blurSize: 1,
        blurBackgroundColor: Colors.white,
        openWithTap: true,
        child: Container(
          margin: EdgeInsets.all(8),
          height: 60,
          width: 60,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/add_account.svg",
              width: 50,
            ),
          ),
        ),
        menuOffset: 20,
        onPressed: () {},
        menuItems: [
          FocusedMenuItem(
              title: Text('Add'),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.WARNING,
                  borderSide: BorderSide(color: Colors.amber, width: 2),
                  width: widget.size.width * 0.95,
                  btnOkText: 'OKAY',
                  btnCancelText: 'CANCEL',
                  buttonsBorderRadius: BorderRadius.all(Radius.circular(14)),
                  headerAnimationLoop: false,
                  animType: AnimType.TOPSLIDE,
                  title: 'Add Member',
                  body: Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                        'กรุณาอย่าส่งเลข UID ให้คนภายนอกครอบครัวของท่านเด็ดขาด เพื่อป้องกันอันตรายและความเป็นส่วนตัวของท่าน'),
                  ),
                  showCloseIcon: true,
                  btnCancelOnPress: () {
                    Navigator.of(context).pop();
                  },
                  btnOkOnPress: () {
                    firestore.doc(widget.user.uid).get().then((value) {
                      if (value.data()['status'] == "master") {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          width: widget.size.width * 0.95,
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            // member add firestore database
                            if (memberuid.text != "") {
                              addmember(context, memberuid.text, firestore);
                              memberuid.clear();
                            }
                            if (this.qrCode != "") {
                              addmember(context, this.qrCode, firestore);
                            }
                          },
                          body: Center(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Text(
                                    'กรอกหมายเลข UID สมาชิกของท่าน',
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  MyTextField(
                                    labelText: 'UID member',
                                    hintText: 'Enter member UID',
                                    controller: memberuid,
                                  ),
                                  SizedBox(height: 10),
                                  ////////////////
                                  QRscan(
                                    onPressed: () {
                                      scanQRCode();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )..show();
                      }
                      // });
                      else {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          width: widget.size.width * 0.95,
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                          body: Center(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Text(
                                    'กรุณาให้ Master เพิ่มบัญชีผู้ใช้เท่านั้น',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )..show();
                      }
                    }); ////
                  },
                )..show();
              }),
          FocusedMenuItem(
            backgroundColor: Colors.red,
            title: Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              firestore.doc(widget.user.uid).get().then((value) {
                if (value.data()['status'] == "master") {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    width: widget.size.width * 0.95,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      // member delete firestore database
                      if (deleteMemberuid.text != "") {
                        deleteMember(deleteMemberuid.text, firestore);
                        deleteMemberuid.clear();
                      }
                      if (this.qrCode != "") {
                        deleteMember(this.qrCode, firestore);
                      }
                    },
                    body: Center(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              'กรอกหมายเลข UID สมาชิกของท่าน',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                              labelText: 'UID member',
                              hintText: 'Enter member UID',
                              controller: deleteMemberuid,
                            ),
                            QRscan(
                              onPressed: () {
                                scanQRCode();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )..show();
                } else {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    width: widget.size.width * 0.95,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                    body: Center(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              'กรุณาให้ Master ลบบัญชีผู้ใช้เท่านั้น',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )..show();
                }
              });
            },
          ),
        ]);
  }
}
