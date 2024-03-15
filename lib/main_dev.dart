import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_config.dart';
import 'flavors/flavor.dart';
import 'flavors/flavor_config.dart';
import 'flavors/flavor_values.dart';
import 'services/shared_prefs.dart';
import 'utils/helpers/helpers.dart';
import 'values/constants.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialise();
  setupLogging();
  runApp(const FlavoredApp());
}

class FlavoredApp extends StatelessWidget {
  const FlavoredApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorConfig(
      flavor: Flavor.dev,
      values: FlavorValues(
        baseUrl: Constants.baseUrl,
      ),
      child: const AppConfig(),
    );
  }
}
