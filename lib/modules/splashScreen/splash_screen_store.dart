import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/apibase/repository.dart';
import 'package:weather_app/model/response/weather.dart';

import '../../apibase/network_state_store.dart';
import '../../utils/network_utils.dart';

part 'splash_screen_store.g.dart';

class SplashScreenStore = _SplashScreenStore with _$SplashScreenStore;

abstract class _SplashScreenStore extends NetworkStateStore with Store {
  @observable
  Temperatures? weather;
  
  
  Future<void>? getCurrentWeather() {
    try {
       weather = Repository.instance.getCurrentWeather(44.34, 10.99) as Temperatures?;
    } catch (e){
      
    }
  }
  
}
