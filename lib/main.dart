import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _connectionStatus = 'Unknown';
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    return updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດ'),
        centerTitle: true,
      ),
      body: Center(
          child: Text(
        'ສະຖານະການເຊື່ອມຕໍ່: $_connectionStatus',
        style: TextStyle(fontSize: 17),
      )),
    );
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      setState(() {
        _connectionStatus = 'ເຊື່ອມຕໍ່ອິນເຕີເນັດສຳເລັດ';
      });
    } else if (result == ConnectivityResult.none) {
      setState(() {
        _connectionStatus = 'ບໍ່ມີການເຊື່ອມຕໍ່';
      });
    } else {
      setState(() => _connectionStatus = 'ບໍ່ສາມາດກວດການເຊື່ອມຕໍ່ໄດ້');
    }
  }
}
