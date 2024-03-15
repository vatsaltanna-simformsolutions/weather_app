import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/apibase/interfaces/repository.dart';
import 'package:weather_app/apibase/repository.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/main_dev.dart';
import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/model/locations.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/services/data_store/data_store_base.dart';
import 'package:weather_app/services/data_store/sp_data_store.dart';
import 'package:weather_app/services/geolocator/geo_locator.dart';
import 'package:weather_app/services/geolocator/geo_locator_base.dart';
import 'package:weather_app/services/shared_prefs.dart';
import 'package:weather_app/services/shared_prefs_keys.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/values/constants.dart';
import 'package:weather_app/values/enumeration.dart';

import '../../apibase/network_state_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore extends NetworkStateStore with Store {
  _HomeStore({
    GeoLocatorBase? locator,
    RepositoryBase? repository,
    DataStoreBase? dataStore,
  })  : _locator = locator ?? WeatherAppGeoLocator.locator,
        _repository = repository ?? Repository.instance,
        _dataStore = dataStore ?? SPDataStore.store {
    getIt<SettingsStore>().registerCallback(_refresh);
  }

  final GeoLocatorBase _locator;
  final RepositoryBase _repository;
  final DataStoreBase _dataStore;

  @observable
  CurrentWeather? weather;

  @observable
  CurrentWeather? hourlyWeather;

  @observable
  Locations? locations;

  @observable
  DaysForecast? daysForecast;

  @observable
  String? locationError;

  @observable
  Coord currentPosition = Constants.defaultCoords;

  Future<void> init() async {
    Coord? pos;

    try {
      final lat = await _dataStore.retrieveStoredLat();
      final lon = await _dataStore.retrieveStoredLong();

      if (lat != null && lon != null) {
        pos = Coord(
          lon: lon,
          lat: lat,
        );
      } else {
        pos = (await _locator.getPosition())?.coord;
      }
    } catch (e) {
      locationError = '$e';
    }

    _setCoords(Coord(
      lon: pos?.lon ?? currentPosition.lon,
      lat: pos?.lat ?? currentPosition.lat,
    ));
  }

  void setLocation(Result result) {
    FocusScope.of(navigator.context).unfocus();

    _setCoords(Coord(
      lat: result.latitude,
      lon: result.longitude,
    ));
  }

  void _setCoords(Coord coord) {
    currentPosition = coord;

    getCurrentWeather();
    getDaysForecast();
  }

  Future<void>? getCurrentWeather() async {
    try {
      state = NetworkState.loading;
      _checkAndPerformCallback(
          currentLat: currentPosition.lat ?? Constants.defaultCoords.lat!,
          currentLong: currentPosition.lon ?? Constants.defaultCoords.lon!,
          apiCall: () async {
            weather = await _repository.getCurrentWeather(
              currentPosition.lat ?? Constants.defaultCoords.lat!,
              currentPosition.lon ?? Constants.defaultCoords.lon!,
            );

            state = NetworkState.success;

            SharedPrefs.setSharedProperty(
                keyEnum: SharedPrefsKeys.getCurrentWeather,
                value: jsonEncode(weather?.toJson()));
          },
          localCall: () {
            final data = SharedPrefs.getSharedProperty(
                keyEnum: SharedPrefsKeys.getCurrentWeather);

            weather = CurrentWeather.fromJson(jsonDecode(data));
          });
    } catch (e) {
      state = NetworkState.error;
      serverError = e.toString();
    }
  }

  Future<void>? getDaysForecast() async {
    try {
      _checkAndPerformCallback(
          currentLat: currentPosition.lat ?? Constants.defaultCoords.lat!,
          currentLong: currentPosition.lon ?? Constants.defaultCoords.lon!,
          apiCall: () async {
            daysForecast = await _repository.getDaysForecast(
              currentPosition.lat ?? Constants.defaultCoords.lat!,
              currentPosition.lon ?? Constants.defaultCoords.lon!,
              7,
            );
            state = NetworkState.success;

            try {
              _dataStore.setDaysForecast(daysForecast);
            } catch (e) {
              debugPrint('$e');
            }
          },
          localCall: () {
            daysForecast = _dataStore.getDaysForecast(currentPosition);

            state = NetworkState.success;
          });
    } catch (e) {
      state = NetworkState.error;
      print(e);
      serverError = e.toString();
    }
  }

  Future<void>? getCityNames(String cityName) async {
    try {
      locations = await _repository.getCityNames(name: cityName);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    getIt<SettingsStore>().removeCallback(_refresh);
  }

  void _refresh() {
    print(DateTime.now());
  }

  Future<void> _checkAndPerformCallback({
    required Function() apiCall,
    required Function() localCall,
    required double currentLat,
    required double currentLong,
  }) async {
    final lastStoredTime = await _dataStore.retrieveDataTime();
    final lastStoredLat = await _dataStore.retrieveStoredLat();
    final lastStoredLong = await _dataStore.retrieveStoredLong();
    final currentTime = DateTime.now();
    double? dist;
    if (lastStoredLat != null && lastStoredLong != null) {
      dist = _calculateDistance(currentLat, currentLong,
          lastStoredLat ?? currentLat, lastStoredLong ?? currentLong);
    }

    if (lastStoredTime == null ||
        currentTime.difference(lastStoredTime).inMinutes >=
            getIt<SettingsStore>().frequency.minutes ||
        (dist != null && dist > 10)) {
      await _dataStore.storeDataTime(currentTime);
      await _dataStore.storeLat(currentLat);
      await _dataStore.storeLong(currentLong);
      apiCall();
    } else {
      localCall();
    }
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
