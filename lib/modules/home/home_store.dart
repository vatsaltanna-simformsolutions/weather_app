import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/apibase/interfaces/repository.dart';
import 'package:weather_app/apibase/network_state_store.dart';
import 'package:weather_app/apibase/repository.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/model/locations.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/services/data_store/data_store_base.dart';
import 'package:weather_app/services/data_store/sp_data_store.dart';
import 'package:weather_app/services/geolocator/geo_locator.dart';
import 'package:weather_app/services/geolocator/geo_locator_base.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/values/constants.dart';
import 'package:weather_app/values/enumeration.dart';
import 'package:weather_app/values/strings.dart';

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
  Coord currentPosition = Constants.defaultCoords;

  Future<void> init() async {
    final lat = await _dataStore.retrieveStoredLat();
    final lon = await _dataStore.retrieveStoredLong();

    if (lat != null && lon != null) {
      _setCoords(Coord(
        lon: lon,
        lat: lat,
      ));
    }

    _getPosition().then((value) {
      if ((value.lat != lat || value.lon != lon)) {
        _setCoords(value);
      }
    });
  }

  Future<Coord> _getPosition() async {
    try {
      return (await _locator.getPosition())?.coord ?? Constants.defaultCoords;
    } catch (e) {
      ScaffoldMessenger.of(navigator.context).showSnackBar(const SnackBar(
        content: Text(AppStrings.unableToGetLocation),
        duration: Duration(seconds: 6),
      ));
      return Constants.defaultCoords;
    }
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
            try {
              weather = await _repository.getCurrentWeather(
                currentPosition.lat ?? Constants.defaultCoords.lat!,
                currentPosition.lon ?? Constants.defaultCoords.lon!,
              );

              currentPosition = weather?.coord ?? currentPosition;

              _setMeta();

              state = NetworkState.success;

              _dataStore.setCurrentWeather(weather);
            } catch (e) {
              state = NetworkState.error;
              serverError = '$e';
            }
          },
          localCall: () {
            weather = _dataStore.getCurrentWeather(currentPosition);
          });
    } catch (e) {
      state = NetworkState.error;
      serverError = e.toString();
    }
  }

  Future<void> _setMeta() async {
    await _dataStore.storeDataTime(DateTime.now());
    await _dataStore
        .storeLat(currentPosition.lat ?? Constants.defaultCoords.lat!);
    await _dataStore
        .storeLong(currentPosition.lon ?? Constants.defaultCoords.lon!);
  }

  Future<void>? getDaysForecast() async {
    try {
      _checkAndPerformCallback(
          currentLat: currentPosition.lat ?? Constants.defaultCoords.lat!,
          currentLong: currentPosition.lon ?? Constants.defaultCoords.lon!,
          apiCall: () async {
            try {
              daysForecast = await _repository.getDaysForecast(
                currentPosition.lat ?? Constants.defaultCoords.lat!,
                currentPosition.lon ?? Constants.defaultCoords.lon!,
                15,
              );

              state = NetworkState.success;

              try {
                _dataStore.setDaysForecast(daysForecast);
              } catch (e) {
                debugPrint('$e');
              }
            } catch (e) {
              state = NetworkState.error;
            }
          },
          localCall: () {
            daysForecast = _dataStore.getDaysForecast(currentPosition);

            state = NetworkState.success;
          });
    } catch (e) {
      state = NetworkState.error;
      serverError = e.toString();
    }
  }

  Future<void>? getCityNames(String cityName) async {
    try {
      locations = await _repository.getCityNames(name: cityName);
    } catch (e) {}
  }

  void dispose() {
    getIt<SettingsStore>().removeCallback(_refresh);
  }

  void _refresh() {}

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

    final dist = _calculateDistance(currentLat, currentLong,
        lastStoredLat ?? currentLat, lastStoredLong ?? currentLong);

    if (lastStoredTime == null ||
        currentTime.difference(lastStoredTime).inMinutes >=
            getIt<SettingsStore>().frequency.minutes ||
        dist >= 10) {
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
