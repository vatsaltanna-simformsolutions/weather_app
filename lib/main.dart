import 'package:flutter/material.dart';
import 'package:weather_app/main_dev.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/services/data_store/sp_data_store.dart';

import 'app_config.dart';
import 'flavors/flavor.dart';
import 'flavors/flavor_config.dart';
import 'flavors/flavor_values.dart';
import 'services/shared_prefs.dart';
import 'utils/helpers/helpers.dart';
import 'values/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialise();
  await SPDataStore.store.initialize();
  setupLogging();
  runApp(const FlavoredApp());
}

class FlavoredApp extends StatefulWidget {
  const FlavoredApp({super.key});

  @override
  State<FlavoredApp> createState() => _FlavoredAppState();
}

class _FlavoredAppState extends State<FlavoredApp> {
  @override
  void initState() {
    super.initState();

    getIt.registerSingleton<SettingsStore>(SettingsStore());
  }

  @override
  void dispose() {
    super.dispose();

    getIt<SettingsStore>().dispose();
  }

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
