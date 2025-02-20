// lib/bluetooth_connection_manager.dart

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothConnectionManager {
  static final BluetoothConnectionManager _instance = BluetoothConnectionManager._internal();
  BluetoothConnection? connection;

  factory BluetoothConnectionManager() {
    return _instance;
  }

  BluetoothConnectionManager._internal();

  Future<void> connect(BluetoothDevice device) async {
    if (connection != null && connection!.isConnected) {
      return; // Already connected
    }
    connection = await BluetoothConnection.toAddress(device.address);
  }

  void disconnect() {
    connection?.dispose();
    connection = null;
  }

  bool isConnected() {
    return connection != null && connection!.isConnected;
  }
}
