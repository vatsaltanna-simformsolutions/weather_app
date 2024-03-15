import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:weather_app/utils/helpers/helpers.dart';

import '../../apibase/network_state_store.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore extends NetworkStateStore with Store {
  _SettingsStore() {
    _resetTimer();
  }

  Timer? _timer;
  List<Function> _callbacks = [];

  @observable
  TemperatureUnit unit = TemperatureUnit.celsius;

  @observable
  ReloadFrequencies frequency = ReloadFrequencies.m10;

  void setUnit(TemperatureUnit? newUnit) {
    unit = newUnit ?? unit;
  }

  void setFrequency(ReloadFrequencies? newFrequencies) {
    frequency = newFrequencies ?? frequency;
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

enum ReloadFrequencies {
  m10(10, '10 minutes'),
  m15(15, '15 minutes'),
  m30(30, '30 minutes'),
  m60(60, '1 hour');

  const ReloadFrequencies(this.minutes, this.display);

  final int minutes;
  final String display;

  Duration get duration => Duration(minutes: minutes);
}

enum TemperatureUnit {
  kelvin('Kelvin'),
  celsius('Celsius'),
  fahrenheit('Fahrenheit');

  final String display;
  const TemperatureUnit(this.display);
}
