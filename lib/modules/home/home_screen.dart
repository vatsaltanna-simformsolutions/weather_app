import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather_app/main_dev.dart';
import 'package:weather_app/modules/home/home_store.dart';
import 'package:weather_app/modules/home/search_bar.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/utils/helpers/helpers.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SettingsStore get settingStore => getIt.get<SettingsStore>();

  @override
  void initState() {
    super.initState();
    final homeStore = getIt.registerSingleton<HomeStore>(HomeStore());
    homeStore.init();
  }

  @override
  Widget build(BuildContext context) {
    final homeStore = getIt<HomeStore>();
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Observer(builder: (context) {
          if (homeStore.weather == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.darkColor,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SearchBarWithSuggestions(
                        itemClick: homeStore.setLocation, hint: homeStore.weather?.name ?? AppStrings.search,
                      ),
                    ),
                  ],
                ),

                ///
                const SizedBox(height: 20),
                Text(
                  AppStrings.now,
                  style: AppColors.darkColorText.copyWith(fontSize: 20),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${settingStore.getFromKelvin(homeStore.weather!.main!.temp!)}\u00b0',
                      style: AppColors.darkColorText.copyWith(fontSize: 40),
                    ),
                    const SizedBox(width: 10),
                    Image.network(
                      getIconUrl(homeStore.weather!.weather!.first.icon ?? ''),
                      height: 40,
                      width: 40,
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          homeStore.weather!.weather!.first.main!,
                          style: AppColors.darkColorText.copyWith(fontSize: 20),
                        ),
                        Text(
                          '${AppStrings.feelsLike} ${settingStore.getFromKelvin(homeStore.weather!.main!.temp!)}\u00b0',
                          style: AppColors.lowerDarkText.copyWith(fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${AppStrings.high} ${settingStore.getFromKelvin(homeStore.weather!.main!.tempMax!)}\u00b0 '
                  '• ${AppStrings.low} ${settingStore.getFromKelvin(homeStore.weather!.main!.tempMin!)}\u00b0',
                  style: AppColors.lowerDarkText.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      AppStrings.sevenDayForecast,
                      style: AppColors.darkColorText.copyWith(fontSize: 20),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.txtWeatherDetails);
                      },
                      child: Text(
                        AppStrings.viewMore,
                        style: AppColors.darkColorText.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: homeStore.daysForecast?.list?.length ?? 0,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.containerColor,
                          borderRadius: index == 0
                              ? const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
                              : const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                index == 0
                                    ? AppStrings.today
                                    : getWeek(dateFromTimeStamp(homeStore
                                    .daysForecast!.list![index].dt!)),
                                style: AppColors.lightColorText
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Image.network(
                                getIconUrl(homeStore
                                    .daysForecast
                                    ?.list?[index]
                                    .weather!
                                    .first
                                    .icon ??
                                    ''),
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Text(
                              '${settingStore.getFromKelvin(homeStore.daysForecast!.list![index].temp!.max!)}\u00b0',
                              style: AppColors.lightColorText
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              '/${settingStore.getFromKelvin(homeStore.daysForecast!.list![index].temp!.min!)}\u00b0',
                              style: AppColors.lowerDarkText
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

String getIconUrl(String iconId) {
  return 'https://openweathermap.org/img/wn/${iconId.substring(0, iconId.length - 1)}d@2x.png';
}
