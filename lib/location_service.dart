import 'package:location/location.dart';
import 'dart:async';

class LocationService {
  final Function onRoundCompleted;
  Location _location = Location();
  LocationData _startLocation;
  StreamSubscription<LocationData> _locationSubscription;

  LocationService({this.onRoundCompleted});

  Future<void> requestLocationPermission() async {
    await _location.requestPermission();
  }

  void startLocationUpdates() {
    _locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation) {
      if (_startLocation == null) {
        _startLocation = currentLocation;
      } else {
        double distance = _calculateDistance(
          _startLocation.latitude,
          _startLocation.longitude,
          currentLocation.latitude,
          currentLocation.longitude,
        );
        if (distance < 10) {
          onRoundCompleted();
          _startLocation = currentLocation;
        }
      }
    });
  }

  void stopLocationUpdates() {
    _locationSubscription?.cancel();
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;    
    var a = 0.5 - 
           cos((lat2 - lat1) * p) / 2 + 
           cos(lat1 * p) * cos(lat2 * p) * 
           (1 - cos((lon2 - lon1) * p)) / 2; 
    return 12742 * asin(sqrt(a)); // Radius of earth in kilometers
  }
}
