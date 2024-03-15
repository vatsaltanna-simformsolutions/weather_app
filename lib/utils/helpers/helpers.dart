import 'package:logging/logging.dart';

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {});
}

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

void safeRun(Function function) {
  try {
    function();
  } catch (e) {} // Suppress error...
}

String getIconUrl(String iconId) {
  return 'https://openweathermap.org/img/wn/${iconId.substring(0, iconId.length - 1)}d@2x.png';
}
