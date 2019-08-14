import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Future<AndroidDeviceInfo> _getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo;
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel("aidl");

  Future _print(String method) async {
    print(method);
    platform.invokeMethod(method);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getDeviceInfo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Dploy.PRINT"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: _getDeviceInfo(),
          builder: (c, s) {
            return Column(
              children: <Widget>[
                Text(
                  "My Device: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Model: " + (s.data as AndroidDeviceInfo).model),
                Text("Type: " + (s.data as AndroidDeviceInfo).type),
                Text("Version: " +
                    (s.data as AndroidDeviceInfo).version.release),
                Text("Manufacturer: " +
                    (s.data as AndroidDeviceInfo).manufacturer),
                Text("Is Physical: " +
                    (s.data as AndroidDeviceInfo).isPhysicalDevice.toString()),
                Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => _print("print"),
                      child: Text(
                        "Print empty line",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                    FlatButton(
                      onPressed: () => _print("barcode"),
                      child: Text(
                        "Print barcode",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                    FlatButton(
                      onPressed: () => _print("qr"),
                      child: Text(
                        "Print QR",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                    FlatButton(
                      onPressed: () => _print("bitmap"),
                      child: Text(
                        "Print Bitmap",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                  ],
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            );
          },
        ),
      ),
    );
  }
}
