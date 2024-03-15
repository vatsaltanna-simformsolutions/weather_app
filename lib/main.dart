import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/modules/home/home_screen.dart';
import 'package:weather_app/modules/home/home_store.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/routes.dart';
import 'package:weather_app/services/data_store/sp_data_store.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/utils/helpers/helpers.dart';
import 'package:weather_app/values/app_colors.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

NavigatorState get navigator => navigatorKey.currentState!;
GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPDataStore.store.initialize();
  setupLogging();
  runApp(const FlavoredApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
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
    getIt.registerSingleton<HomeStore>(HomeStore());
  }

  @override
  void dispose() {
    super.dispose();

    getIt<SettingsStore>().dispose();
    getIt<HomeStore>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.hideKeyboard,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        onGenerateRoute: Routes.generateRoute,
        navigatorKey: navigatorKey,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.containerColor,
          ),
        ),
      ),
    );
  }
}
