import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static Function(bool) locationPermissionHandler = (lastDate) {};

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationPermissionHandler(false);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationPermissionHandler(false);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      locationPermissionHandler(false);
      return false;
    }
    return true;
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      return null;
    }
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<Stream<Position>?> streamLocation() async{
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      return null;
    }
    try {
      final position = Geolocator.getPositionStream();
      return position;
    } catch (e) {
      return null;
    }
  }
}
