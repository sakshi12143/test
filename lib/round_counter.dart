import 'package:flutter/material.dart';
import 'location_service.dart';
import 'package:location/location.dart';

class RoundCounter extends StatefulWidget {
  @override
  _RoundCounterState createState() => _RoundCounterState();
}

class _RoundCounterState extends State<RoundCounter> {
  int _count = 0;
  LocationService _locationService;
  LocationData _currentLocation;

  @override
  void initState() {
    super.initState();
    _locationService = LocationService(onRoundCompleted: _incrementCounter);
    _locationService.requestLocationPermission();
    _locationService.startLocationUpdates();
  }

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  @override
  void dispose() {
    _locationService.stopLocationUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pradakshina Round Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Rounds Completed: $_count'),
            SizedBox(height: 20),
            Text('Current Location: ${_currentLocation?.latitude}, ${_currentLocation?.longitude}'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _count = 0;
                });
              },
              child: Text('Reset Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
