import 'package:weather_app/model/coord.dart';

class Constants {
  const Constants._();

  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const geoBaseUrl = 'https://geocoding-api.open-meteo.com/v1/';

  static const appId = 'a306aa90cac06cde9440bccf0c8eb26d';

  static final defaultCoords = Coord(
    lat: 24.4539,
    lon: 54.3773,
  );
}
