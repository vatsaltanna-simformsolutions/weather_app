import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sprintf/sprintf.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/modules/home/home_store.dart';
import 'package:weather_app/modules/home/search_bar.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/modules/widgets/day_weather_tile.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/utils/helpers/helpers.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/enumeration.dart';
import 'package:weather_app/values/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SettingsStore get settingStore => getIt.get<SettingsStore>();

  final _searchNode = FocusNode();

  @override
  void initState() {
    super.initState();

    getIt<HomeStore>().init();
  }

  @override
  Widget build(BuildContext context) {
    final homeStore = getIt<HomeStore>();
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Observer(builder: (context) {
          if (homeStore.weather == null) {
            if (homeStore.state.isFailed) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        AppStrings.error,
                        style: AppColors.darkColorText.copyWith(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.noDataAvailableTxt,
                        style: AppColors.lowerDarkText.copyWith(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.darkColor,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppStrings.loadingTxt,
                      style: AppColors.darkColorText.copyWith(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.loadingDataDesc,
                      style: AppColors.lowerDarkText.copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
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
                        focusNode: _searchNode,
                        itemClick: homeStore.setLocation,
                        hint: homeStore.weather?.name ?? AppStrings.search,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Observer(builder: (context) {
                  return AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: homeStore.state.isLoading
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.loadingNewData,
                                style: AppColors.darkColorText.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(width: double.maxFinite),
                  );
                }),
                Text(
                  AppStrings.now,
                  style: AppColors.darkColorText.copyWith(fontSize: 20),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      sprintf(AppStrings.temperatureWithDegree, [
                        settingStore.getFromKelvin(
                            homeStore.weather!.weatherData!.temp!)
                      ]),
                      style: AppColors.darkColorText.copyWith(fontSize: 40),
                    ),
                    const SizedBox(width: 10),
                    if (homeStore.weather?.weather?.first.icon != null)
                      CachedNetworkImage(
                        imageUrl:
                            getIconUrl(homeStore.weather!.weather!.first.icon!),
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
                          sprintf(AppStrings.feelsLikeTemp, [
                            settingStore.getFromKelvin(
                                homeStore.weather!.weatherData!.temp!)
                          ]),
                          style: AppColors.lowerDarkText.copyWith(fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  sprintf(AppStrings.highLowTempString, [
                    settingStore.getFromKelvin(
                        homeStore.weather!.weatherData!.tempMax!),
                    settingStore.getFromKelvin(
                        homeStore.weather!.weatherData!.tempMin!),
                  ]),
                  style: AppColors.lowerDarkText.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 26),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      AppStrings.sevenDayForecastTxt,
                      style: AppColors.darkColorText.copyWith(fontSize: 20),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _searchNode.unfocus();
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
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    itemCount:
                        math.min(7, homeStore.daysForecast?.list?.length ?? 0),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 14,
                    ),
                    itemBuilder: (_, index) {
                      return DayWeatherTile(
                        index: index,
                        icon: homeStore.daysForecast?.list?[index].weather
                                    ?.first.icon ==
                                null
                            ? null
                            : getIconUrl(homeStore.daysForecast!.list![index]
                                .weather!.first.icon!),
                        min: settingStore.getFromKelvin(
                            homeStore.daysForecast!.list![index].temp!.min!),
                        max: settingStore.getFromKelvin(
                            homeStore.daysForecast!.list![index].temp!.max!),
                        day: index == 0
                            ? AppStrings.todayTxt
                            : getWeek(dateFromTimeStamp(
                                homeStore.daysForecast!.list![index].dt!)),
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
