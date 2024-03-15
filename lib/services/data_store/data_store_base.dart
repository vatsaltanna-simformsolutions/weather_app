import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/values/enumeration.dart';

abstract class DataStoreBase {
  CurrentWeather? getCurrentWeather(Coord coordinates);
  Future<bool> setCurrentWeather(CurrentWeather? weather);
  DaysForecast? getDaysForecast(Coord coordinates);
  Future<bool> setDaysForecast(DaysForecast? daysForecast);
  Future<DateTime?> retrieveDataTime();
  Future<void> storeDataTime(DateTime dateTime);
  Future<void> storeLat(double lat);
  Future<void> storeLong(double long);
  Future<double?> retrieveStoredLat();
  Future<double?> retrieveStoredLong();
  ReloadFrequencies getReloadFrequency();
  Future<bool> setReloadFrequency(ReloadFrequencies frequency);
  TemperatureUnit getTemperatureUnit();
  Future<bool> setTemperatureUnit(TemperatureUnit unit);
  dynamic getSharedProperty({required String keyEnum});
  Future<bool> setSharedProperty({
    required dynamic value,
    required String keyEnum,
  });
}
