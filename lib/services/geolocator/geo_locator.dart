import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/geolocator/geo_locator_base.dart';
import 'package:weather_app/values/strings.dart';

class WeatherAppGeoLocator extends GeoLocatorBase {
  static final locator = WeatherAppGeoLocator._();

  WeatherAppGeoLocator._();

  @override
  Future<Position>? getPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw ApiErrorStrings.locationPermissionDeniedMsg;
      }
    } else if (permission == LocationPermission.deniedForever) {
      throw ApiErrorStrings.locationPermissionDeniedForeverMsg;
    }
    return await Geolocator.getCurrentPosition();
  }
}
