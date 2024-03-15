import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/coord.dart';

/// provides extension to get a dependency from provider
extension ContextExtension on BuildContext {
  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    if (!currentFocus.hasPrimaryFocus) {
      FocusScope.of(this).requestFocus(FocusNode());
    }
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  void pop<T>([T? result]) => Navigator.pop<T>(this, result);
}

extension CoordExtension on Position {
  Coord get coord => Coord(lon: longitude, lat: latitude);
}
