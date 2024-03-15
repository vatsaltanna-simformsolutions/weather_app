import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/modules/home/home_store.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/modules/widgets/day_weather_tile.dart';
import 'package:weather_app/utils/helpers/helpers.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/enumeration.dart';
import 'package:weather_app/values/strings.dart';

class WeatherDetail extends StatelessWidget {
  const WeatherDetail({super.key});

  SettingsStore get settingStore => getIt.get<SettingsStore>();

  HomeStore get store => getIt<HomeStore>();

  @override
  Widget build(BuildContext context) {
    TextStyle darkColorText = const TextStyle(color: Color(0xffFEDEB6));
    Color containerColor = const Color(0xff261F14);
    Color darkColor = const Color(0xffFEDEB6);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          'Forecasts',
          style: AppColors.darkColorText.copyWith(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Observer(builder: (context) {
            if (store.state == NetworkState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: darkColor,
                ),
              );
            }
            if (store.state == NetworkState.error) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      AppStrings.error,
                      style: darkColorText.copyWith(fontSize: 20),
                    ),
                    Text(
                      store.serverError ??
                          ApiErrorStrings.somethingWentWrongTxt,
                      style: darkColorText.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    AppStrings.fifteenDayForecastTxt,
                    style: darkColorText.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                      itemCount: store.daysForecast?.list?.length ?? 0,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(
                            height: 14,
                          ),
                      itemBuilder: (_, index) {
                        return DayWeatherTile(
                          index: index,
                          day: index == 0
                              ? AppStrings.todayTxt
                              : getWeek(dateFromTimeStamp(
                                  store.daysForecast!.list![index].dt!)),
                          icon: getIconUrl(store.daysForecast!.list![index]
                                  .weather!.first.icon ??
                              ''),
                          max: settingStore.getFromKelvin(
                              store.daysForecast!.list![index].temp!.max!),
                          min: settingStore.getFromKelvin(
                              store.daysForecast!.list![index].temp!.min!),
                        );
                      }),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
