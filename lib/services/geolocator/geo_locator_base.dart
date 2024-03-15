import 'package:geolocator/geolocator.dart';

abstract class GeoLocatorBase {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position>? getPosition();
}