import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/services/data_store/data_store_base.dart';
import 'package:weather_app/values/enumeration.dart';

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
    final data = _prefs.getString(SharedPrefsKeys.getCurrentWeather);
    if (data?.isEmpty ?? true) return null;

    return CurrentWeather.fromJson(json.decode(data!));
  }

  @override
  Future<bool> setCurrentWeather(CurrentWeather? weather) {
    if (weather == null) return Future.value(false);

    return _prefs.setString(
        SharedPrefsKeys.getCurrentWeather, json.encode(weather.toJson()));
  }

  @override
  Future<bool> setDaysForecast(DaysForecast? daysForecast) {
    if (daysForecast?.city?.coord == null) return Future.value(false);
    return _prefs.setString(
        SharedPrefsKeys.getDaysForecast, json.encode(daysForecast?.toJson()));
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

  @override
  ReloadFrequencies getReloadFrequency() {
    return ReloadFrequencies.fromInt(
        _prefs.getInt(SharedPrefsKeys.reloadFrequencyKey));
  }

  @override
  TemperatureUnit getTemperatureUnit() {
    return TemperatureUnit.fromInt(
        _prefs.getInt(SharedPrefsKeys.temperatureUnitKey));
  }

  @override
  Future<bool> setReloadFrequency(ReloadFrequencies frequency) {
    return _prefs.setInt(SharedPrefsKeys.reloadFrequencyKey, frequency.index);
  }

  @override
  Future<bool> setTemperatureUnit(TemperatureUnit unit) {
    return _prefs.setInt(SharedPrefsKeys.temperatureUnitKey, unit.index);
  }

  /// Provides saved shared preferences value based on enum key
  @override
  dynamic getSharedProperty({
    required String keyEnum,
  }) {
    return _prefs.getString(keyEnum);
  }

  /// Sets value to provided key as key-value pair in shared preferences
  @override
  Future<bool> setSharedProperty({
    required dynamic value,
    required String keyEnum,
  }) async {
    if (value == null) return false;
    return switch (value.runtimeType) {
      bool => _prefs.setBool(keyEnum, value as bool),
      int => _prefs.setInt(keyEnum, value as int),
      double => _prefs.setDouble(keyEnum, value as double),
      _ => _prefs.setString(keyEnum, value.toString()),
    };
  }
}

class SharedPrefsKeys {
  const SharedPrefsKeys._();

  static const lastStoredTime = 'lastStoredTime';
  static const lastLat = 'lastLat';
  static const lastLong = 'lastLong';
  static const getCurrentWeather = 'getCurrentWeather';
  static const getDaysForecast = 'getDaysForecast';
  static const temperatureUnitKey = 'temperature-key';
  static const reloadFrequencyKey = 'reload-frequency-key';
}
