import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';

class BeaconsScanPage extends StatefulWidget {
  BeaconsScanPage({Key key}) : super(key: key);

  @override
  _BeaconsScanPageState createState() => _BeaconsScanPageState();
}

class _BeaconsScanPageState extends State<BeaconsScanPage> {
  StreamSubscription<MonitoringResult> _monitorStreamSubscription;
  StreamSubscription<RangingResult> _streamRanging;
  @override
  void initState() {
    initScan();

    super.initState();
  }

  void initScan() async {
    // if you want to manage manual checking about the required permissions
    await flutterBeacon.initializeScanning;

    // or if you want to include automatic checking permission
    await flutterBeacon.initializeAndCheckScanning;

    final regions = <Region>[];
    regions.add(Region(identifier: 'com.beacon'));

    _monitorStreamSubscription = flutterBeacon.monitoring(regions).listen(
      (event) {
        print("got event ${event.toJson}");
        if (event.monitoringEventType == MonitoringEventType.didEnterRegion) {
          print('entering ${event.region} ${event.region.identifier}');
        }

        if (event.monitoringEventType == MonitoringEventType.didExitRegion) {
          print('exiting ${event.region}');
        }
      },
    );
  }

  @override
  void dispose() {
    _monitorStreamSubscription.cancel();
    _streamRanging.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TMColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Hero(
                tag: 'fab',
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.headset,
                    size: 82,
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Text(
                'Searching for audioguides...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
