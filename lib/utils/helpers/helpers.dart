import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

/// allows to set system icon theme (light | dark)
void setSystemIcons({required bool dark}) {
  SystemChrome.setSystemUIOverlayStyle(
    (dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light).copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {});
}

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) =>
    values.firstWhere((v) => key == enumToString(v!));

String getWeek(DateTime date) {
  return [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ][date.weekday - 1];
}

DateTime dateFromTimeStamp(int stamp) {
  return DateTime.fromMillisecondsSinceEpoch(stamp * 1000);
}

void log(ValueGetter<String> message) {
  assert(() {
    try {
      debugPrint(message());
    } catch (e) {
      // Suppress exceptions...
    }

    return true; // Never throw AssertionError;
  }(), '');
}

void safeRun(Function function) {
  try {
    function();
  } catch (e) {} // Suppress error...
}
