import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, @required this.device});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.devices),
        title: Text(device.name ?? "Unknown device"),
        subtitle: Text(device.address.toString()),
        trailing: TextButton(
          child: Text(
            'Setting',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
        ),
      ),
    );
  }
}
