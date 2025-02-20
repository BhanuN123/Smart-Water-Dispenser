import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homescreen(),
    );
  }
}

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Page1(),
    Page3(),
  ];

  // Function to update the current index
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Smart Water Dispenser'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the current index
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bluetooth_connected,
              color: Colors.blue,
              size: 30,
            ),
            label: 'Pair',
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the buttons
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center, // Center the buttons vertically
        children: [
          ElevatedButton(
            onPressed: () {
              sendData("a");
            },
            child: Text(
              "50 ML",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              sendData("b");
            },
            child: Text(
              "100 ML",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              sendData("c");
            },
            child: Text(
              "150 ML",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              sendData("d");
            },
            child: Text(
              "200 ML",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              sendData("e");
            },
            child: Text(
              "250 ML",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  void sendData(String data) async {
    final connection = BluetoothConnectionManager().connection;

    if (connection != null && connection.isConnected) {
      connection.output
          .add(Uint8List.fromList(data.codeUnits)); // Send data as bytes
      await connection.output.allSent;
      print("Sent: $data");
    } else {
      print("No device connected.");
    }
  }
}

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  List<BluetoothDevice> devicesList = [];
  BluetoothDevice? connectedDevice;
  BluetoothConnection? connection;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  Future<void> startScan() async {
    setState(() {
      isScanning = true;
      devicesList.clear();
    });

    // Get bonded (paired) devices
    devicesList = await FlutterBluetoothSerial.instance.getBondedDevices();

    setState(() {
      isScanning = false;
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await BluetoothConnectionManager()
        .connect(device); // Use the singleton to connect
    setState(() {
      connectedDevice = device;
    });
  }

  @override
  void dispose() {
    // Do not dispose the connection here to keep it alive across pages
    // BluetoothConnectionManager().disconnect(); // Uncomment if you want to disconnect when leaving this page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          isScanning
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: startScan,
            child: Text("Scan for Paired Devices"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: devicesList.length,
              itemBuilder: (context, index) {
                final device = devicesList[index];
                return ListTile(
                  title: Text(device.name ?? "Unknown Device"),
                  subtitle: Text(device.address),
                  onTap: () => connectToDevice(device),
                );
              },
            ),
          ),
          connectedDevice != null
              ? Column(
            children: [
              Text("Connected to: ${connectedDevice!.name}"),
              ElevatedButton(
                onPressed: () => sendData("Hello Ardiuno"),
                child: Text("send Data"),
              )
            ],
          )
              : Text("No device connected"),
        ],
      ),
    );
  }

  void sendData(String data) async {
    final connection = BluetoothConnectionManager().connection;

    if (connection != null && connection.isConnected) {
      connection.output
          .add(Uint8List.fromList(data.codeUnits)); // Send data as bytes
      await connection.output.allSent;
      print("Sent: $data");
    } else {
      print("No device connected.");
    }
  }
}