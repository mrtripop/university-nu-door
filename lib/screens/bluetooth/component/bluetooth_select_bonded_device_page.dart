import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:test_door/main_component/loading.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/bluetooth/component/%E0%B8%B4bluetooth_device_list_entry.dart';

class SelectBondedDevicePage extends StatefulWidget {
  final bool checkAvailability;
  final Function onCahtPage;
  final UserClass user;

  const SelectBondedDevicePage({
    this.checkAvailability = true,
    @required this.onCahtPage,
    @required this.user,
  });

  @override
  _SelectBondedDevicePage createState() => new _SelectBondedDevicePage();
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  final FlutterBluetoothSerial flutterBlue = FlutterBluetoothSerial.instance;
  List<_DeviceWithAvailability> devices = [];

  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
  bool _isDiscovering;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    flutterBlue.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });
    _startDiscovery();
  }

  void _startDiscovery() {
    setState(() {
      loading = true;
    });
    _discoveryStreamSubscription = flutterBlue.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;
          }
        }
      });
    });
    _discoveryStreamSubscription.onDone(() {
      setState(() {
        _isDiscovering = false;
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = devices
        .map(
          (_device) => BluetoothDeviceListEntry(
            device: _device.device,
            onTap: () {
              if (_device.device.name == "ESP32-Door") {
                widget.onCahtPage(
                  _device.device,
                );
              }
            },
          ),
        )
        .toList();
    return loading
        ? Loading()
        : ListView(
            children: list,
          );
  }
}
