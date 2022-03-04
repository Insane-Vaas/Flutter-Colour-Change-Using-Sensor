import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const methodChannel = MethodChannel('com.lightapp.light/method');
  static const pressureChannel = EventChannel('com.lightapp.light/intensity');

  String _sensorAvailable = 'Unknown';
  double _intensityReading = 0;
  StreamSubscription? pressureSubscription;

  Future<void> _checkAvailability() async {
    try {
      var available = await methodChannel.invokeMethod('isSensorAvailable');
      setState(() {
        _sensorAvailable = available.toString();
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  _startReading() {
    pressureSubscription =
        pressureChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _intensityReading = event;
      });
    });
  }

  _stopReading() {
    setState(() {
      _intensityReading = 0;
    });
    pressureSubscription?.cancel();
  }

  @override
  initState() {
    super.initState();
    _startReading();
  }

  List<Color> colors = [
    Colors.grey.shade900,
    Colors.grey.shade600,
    Colors.grey.shade500,
    Colors.grey.shade300,
    Colors.grey.shade100,
    Colors.white
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: (_intensityReading < 100)
            ? ((_intensityReading < 70)
                ? (_intensityReading < 50
                    ? (_intensityReading < 30
                        ? (_intensityReading < 20 ? colors[0] : colors[1])
                        : colors[2])
                    : colors[3])
                : colors[4])
            : colors[5],
        child: Align(
          alignment: Alignment.center,
          child: _intensityReading == 0
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text(
                    "Hello",
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      color: _intensityReading < 100
                          ? ((_intensityReading < 70)
                              ? (_intensityReading < 50
                                  ? (_intensityReading < 30
                                      ? (_intensityReading < 20
                                          ? colors[5]
                                          : colors[4])
                                      : colors[3])
                                  : colors[2])
                              : colors[1])
                          : colors[0],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
