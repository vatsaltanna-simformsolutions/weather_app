enum NetworkState { idle, loading, success, error }

extension NetworkStateExtension on NetworkState {
  bool get isIdle => this == NetworkState.idle;

  bool get isLoading => this == NetworkState.loading;

  bool get isSuccessful => this == NetworkState.success;

  bool get isFailed => this == NetworkState.error;
}

enum SecureStorageKeys { kAccessToken }

enum ReloadFrequencies {
  m10(10, '10 minutes'),
  m15(15, '15 minutes'),
  m30(30, '30 minutes'),
  m60(60, '1 hour');

  const ReloadFrequencies(this.minutes, this.display);

  factory ReloadFrequencies.fromInt(int? index) {
    if ((index ?? 0) == 0 || index! > ReloadFrequencies.values.length) {
      return ReloadFrequencies.m10;
    }

    return ReloadFrequencies.values[index];
  }

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

  factory TemperatureUnit.fromInt(int? index) {
    if ((index ?? 0) == 0 || index! > TemperatureUnit.values.length) {
      return TemperatureUnit.celsius;
    }

    return TemperatureUnit.values[index];
  }
}
