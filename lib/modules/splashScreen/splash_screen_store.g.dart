// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashScreenStore on _SplashScreenStore, Store {
  late final _$weatherAtom =
      Atom(name: '_SplashScreenStore.weather', context: context);

  @override
  Temperatures? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(Temperatures? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  @override
  String toString() {
    return '''
weather: ${weather}
    ''';
  }
}
