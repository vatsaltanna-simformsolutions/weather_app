class AppStrings {
  AppStrings._();

  static const todayTxt = 'Today';
  static const error = 'Error';
  static const loadingTxt = 'Loading';
  static const noDataAvailableTxt = 'No data available';
  static const loadingDataDesc = 'Please wait! Your weather data is loading.';
  static const search = 'Search';
  static const loadingNewData = 'Loading new data';
  static const now = 'Now';
  static const highLowTempString =
      'High: %s${Symbols.degree} • Low: %s${Symbols.degree}';
  static const feelsLikeTemp = 'Feels like %s${Symbols.degree}';
  static const temperatureWithDegree = '%s${Symbols.degree}';
  static const sevenDayForecastTxt = '7-day Forecast';
  static const viewMore = 'View More';
  static const appSettingsTxt = 'App Settings';
  static const temperatureUnitTxt = 'Temperature Unit: ';
  static const reloadFrequency = 'Reload Frequency: ';
  static const fifteenDayForecastTxt = '15-days Forecast';
  static const invalidRoute = 'Invalid Route';
  static const unableToGetLocation = 'Unable to get location.';
}

class Symbols {
  Symbols._();

  static const degree = '\u00b0';
}

class AppRoutes {
  const AppRoutes._();

  static const String txtWeatherDetails = '/weather_details';
  static const String txtSettings = '/settings';
}

class ApiErrorStrings {
  const ApiErrorStrings._();

  static const String noInternetMsg = 'No internet connection.';
  static const String somethingWrongErrorMsg =
      'Something went wrong! Please try after some time.';
  static const String somethingWentWrongTxt = 'Something went wrong';

  static const locationPermissionDeniedMsg = 'Location permissions are denied';
  static const locationPermissionDeniedForeverMsg =
      'Location permissions are permanently denied, we cannot request permissions.';
}
