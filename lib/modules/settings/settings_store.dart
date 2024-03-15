import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:weather_app/services/data_store/sp_data_store.dart';
import 'package:weather_app/utils/helpers/helpers.dart';
import 'package:weather_app/values/enumeration.dart';

import '../../apibase/network_state_store.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore extends NetworkStateStore with Store {
  _SettingsStore() {
    _init();
  }

  Timer? _timer;
  final _callbacks = <Function>[];

  @observable
  TemperatureUnit unit = TemperatureUnit.celsius;

  @observable
  ReloadFrequencies frequency = ReloadFrequencies.m10;

  void _init() {
    final freq = SPDataStore.store.getReloadFrequency();
    final unit = SPDataStore.store.getTemperatureUnit();

    setUnit(unit);
    setFrequency(freq);
  }

  void setUnit(TemperatureUnit? newUnit) {
    unit = newUnit ?? unit;
    SPDataStore.store.setTemperatureUnit(unit);
  }

  void setFrequency(ReloadFrequencies? newFrequencies) {
    frequency = newFrequencies ?? frequency;
    SPDataStore.store.setReloadFrequency(frequency);

    _resetTimer();
  }

  double getFromKelvin(double kelvin) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return kelvin;

      case TemperatureUnit.celsius:
        return double.parse((kelvin - 273.15).toStringAsFixed(2));

      case TemperatureUnit.fahrenheit:
        return double.parse(
            ((kelvin - 273.15) * 9 / 5 + 32).toStringAsFixed(2));
    }
  }

  void dispose() {
    _timer?.cancel();
    _callbacks.clear();
  }

  void registerCallback(Function function) {
    if (!_callbacks.contains(function)) {
      _callbacks.add(function);
    }
  }

  void removeCallback(Function function) {
    _callbacks.remove(function);
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(frequency.duration, (timer) {
      _callbacks.forEach(safeRun);
    });
  }
}
