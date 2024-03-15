import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/days_forecast.dart';

abstract class DataStoreBase {
  CurrentWeather? getCurrentWeather(Coord coordinates);

  DaysForecast? getDaysForecast(Coord coordinates);

  Future<bool> setDaysForecast(DaysForecast? daysForecast);

  Future<DateTime?> retrieveDataTime();

  Future<void> storeDataTime(DateTime dateTime);

  Future<void> storeLat(double lat);

  Future<void> storeLong(double long);

  Future<double?> retrieveStoredLat();

  Future<double?> retrieveStoredLong();
}
