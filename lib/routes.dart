import 'package:flutter/material.dart';
import 'package:weather_app/modules/settings/settings_screen.dart';
import 'package:weather_app/modules/splashScreen/splash_screen.dart';
import 'package:weather_app/modules/weather_details/weather_details_screen.dart';

import 'utils/common_widgets/invalid_route.dart';
import 'utils/extensions.dart';
import 'values/strings.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({
      required Widget widget,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<void>(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }

    switch (settings.name) {
      case AppRoutes.txtAfterSplash:
        return getRoute(
          widget: const SplashScreen(),
        );
      case AppRoutes.txtWeatherDetails:
        return getRoute(
          widget: const WeatherDetail(),
        );
      case AppRoutes.txtSettings:
        return getRoute(
          widget: const SettingsPage(),
        );

      /// An invalid route. User shouldn't see this, it's for debugging purpose
      /// only.
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
