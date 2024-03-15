import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/modules/home/home_store.dart';
import 'package:weather_app/services/data_store/data_store_base.dart';
import 'package:weather_app/services/shared_prefs_keys.dart';

import '../../model/current_weather.dart';

class SPDataStore extends DataStoreBase {
  static final store = SPDataStore._();

  SPDataStore._();

  late final SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  CurrentWeather? getCurrentWeather(Coord coordinates) {
    final data = _prefs.getString(_generateKeyForCurrentWeather(coordinates));
    if (data?.isEmpty ?? true) return null;

    return CurrentWeather.fromJson(json.decode(data!));
  }

  @override
  Future<bool> setDaysForecast(DaysForecast? daysForecast) {
    if (daysForecast?.city?.coord == null) return Future.value(false);
    return _prefs.setString(
        SharedPrefsKeys.getDaysForecast,
        json.encode(daysForecast?.toJson()));
  }

  @override
  DaysForecast? getDaysForecast(Coord coordinates) {
    final data = _prefs.getString(SharedPrefsKeys.getDaysForecast);
    if (data?.isEmpty ?? true) return null;

    return DaysForecast.fromJson(json.decode(data!));
  }

  @override
  Future<void> storeDataTime(DateTime dateTime) async {
    await _prefs.setString(
        SharedPrefsKeys.lastStoredTime, dateTime.toIso8601String());
  }
  @override
  Future<DateTime?> retrieveDataTime() async {
    final storedTime = _prefs.getString(SharedPrefsKeys.lastStoredTime);
    return storedTime != null ? DateTime.parse(storedTime) : null;
  }

  @override
  Future<void> storeLat(double lat) async {
    await _prefs.setDouble(SharedPrefsKeys.lastLat, lat);
  }

  @override
  Future<void> storeLong(double long) async {
    await _prefs.setDouble(SharedPrefsKeys.lastLong, long);
  }

  @override
  Future<double?> retrieveStoredLat() async {
    return _prefs.getDouble(SharedPrefsKeys.lastLat);
  }

  @override
  Future<double?> retrieveStoredLong() async {
    return _prefs.getDouble(SharedPrefsKeys.lastLong);
  }

}

String _generateKeyForDaysForecast(Coord coordinates) {
  return 'days-forecast-${coordinates.lat}-${coordinates.lon}';
}

String _generateKeyForCurrentWeather(Coord coordinates) {
  return 'current-weather-${coordinates.lat}-${coordinates.lon}';
}
