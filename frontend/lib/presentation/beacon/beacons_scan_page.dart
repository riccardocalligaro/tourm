import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/core_container.dart';
import 'package:tourm_app/data/datasource/tm_remote_datasource.dart';
import 'package:tourm_app/presentation/audioguides/audioguide_page.dart';

class BeaconsScanPage extends StatefulWidget {
  BeaconsScanPage({Key key}) : super(key: key);

  @override
  _BeaconsScanPageState createState() => _BeaconsScanPageState();
}

class _BeaconsScanPageState extends State<BeaconsScanPage> {
  StreamSubscription<MonitoringResult> _monitorStreamSubscription;
  StreamSubscription<RangingResult> _streamRanging;

  final List<Region> _currentRegions = [];

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
    regions.add(Region(identifier: '1fed74a3-c1fe-4654-b389-6bb2d2ac5ae3'));

    _monitorStreamSubscription = flutterBeacon.monitoring(regions).listen(
      (event) {
        if (event.monitoringEventType == MonitoringEventType.didEnterRegion) {
          setState(() {
            _currentRegions.add(event.region);
          });
        }

        if (event.monitoringEventType == MonitoringEventType.didExitRegion) {
          setState(() {
            _currentRegions.remove(event.region);
          });
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
                'Rilevamento posizione...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: List.generate(
                    1,
                    (index) {
                      // final region = _currentRegions[index];

                      return Card(
                        child: ListTile(
                          title: Text('Audioguida ${index + 1}'),
                          onTap: () async {
                            // final TMRemoteDatasource remoteDatasource = sl();
                            // final audioguides = await remoteDatasource
                            //     .audioguidesForBeacon(region.identifier);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    AudioguidePage(audioguides: null),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
