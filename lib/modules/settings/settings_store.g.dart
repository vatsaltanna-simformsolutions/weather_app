// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  late final _$unitAtom = Atom(name: '_SettingsStore.unit', context: context);

  @override
  TemperatureUnit get unit {
    _$unitAtom.reportRead();
    return super.unit;
  }

  @override
  set unit(TemperatureUnit value) {
    _$unitAtom.reportWrite(value, super.unit, () {
      super.unit = value;
    });
  }

  late final _$frequencyAtom =
      Atom(name: '_SettingsStore.frequency', context: context);

  @override
  ReloadFrequencies get frequency {
    _$frequencyAtom.reportRead();
    return super.frequency;
  }

  @override
  set frequency(ReloadFrequencies value) {
    _$frequencyAtom.reportWrite(value, super.frequency, () {
      super.frequency = value;
    });
  }

  @override
  String toString() {
    return '''
unit: ${unit},
frequency: ${frequency}
    ''';
  }
}
