import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/apibase/repository.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/model/response/weather.dart';
import 'package:weather_app/values/enumeration.dart';

import '../../apibase/network_state_store.dart';
import '../../utils/network_utils.dart';

part 'weather_details_store.g.dart';

class WeatherDetailsStore = _WeatherDetailsStore with _$WeatherDetailsStore;

abstract class _WeatherDetailsStore extends NetworkStateStore with Store {
  @observable
  DaysForecast? weather;

  Future<void>? getDaysForecast() async {
    try {
      state = NetworkState.loading;
      weather = await Repository.instance.getDaysForecast(44.34, 10.99, 15);

      state = NetworkState.success;
    } catch (e) {
      state = NetworkState.error;
      print(e);
      serverError = e.toString();
    }
  }
}
