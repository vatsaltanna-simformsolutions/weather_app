// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$weatherAtom = Atom(name: '_HomeStore.weather', context: context);

  @override
  CurrentWeather? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(CurrentWeather? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  late final _$hourlyWeatherAtom =
      Atom(name: '_HomeStore.hourlyWeather', context: context);

  @override
  CurrentWeather? get hourlyWeather {
    _$hourlyWeatherAtom.reportRead();
    return super.hourlyWeather;
  }

  @override
  set hourlyWeather(CurrentWeather? value) {
    _$hourlyWeatherAtom.reportWrite(value, super.hourlyWeather, () {
      super.hourlyWeather = value;
    });
  }

  late final _$locationsAtom =
      Atom(name: '_HomeStore.locations', context: context);

  @override
  Locations? get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  @override
  set locations(Locations? value) {
    _$locationsAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  late final _$daysForecastAtom =
      Atom(name: '_HomeStore.daysForecast', context: context);

  @override
  DaysForecast? get daysForecast {
    _$daysForecastAtom.reportRead();
    return super.daysForecast;
  }

  @override
  set daysForecast(DaysForecast? value) {
    _$daysForecastAtom.reportWrite(value, super.daysForecast, () {
      super.daysForecast = value;
    });
  }

  late final _$currentPositionAtom =
      Atom(name: '_HomeStore.currentPosition', context: context);

  @override
  Coord get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(Coord value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  @override
  String toString() {
    return '''
weather: ${weather},
hourlyWeather: ${hourlyWeather},
locations: ${locations},
daysForecast: ${daysForecast},
currentPosition: ${currentPosition}
    ''';
  }
}
