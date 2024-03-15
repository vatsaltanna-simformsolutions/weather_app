import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather_app/main_dev.dart';
import 'package:weather_app/modules/home/home_screen.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/modules/weather_details/weather_details_store.dart';
import 'package:weather_app/utils/helpers/helpers.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/enumeration.dart';

class WeatherDetail extends StatefulWidget {
  const WeatherDetail({super.key});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  SettingsStore get settingStore => getIt.get<SettingsStore>();

  @override
  void initState() {
    super.initState();
    getIt.registerSingleton(WeatherDetailsStore());
    getIt.get<WeatherDetailsStore>().getDaysForecast();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle darkColorText = const TextStyle(color: Color(0xffFEDEB6));
    TextStyle lowerDarkText = const TextStyle(color: Color(0xffd1c7ba));
    TextStyle lightColorText = const TextStyle(color: Color(0xfff7f3f0));
    Color containerColor = const Color(0xff261F14);
    Color darkColor = const Color(0xffFEDEB6);
    final store = getIt<WeatherDetailsStore>();
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      "Error",
                      style: darkColorText.copyWith(fontSize: 20),
                    ),
                    Text(
                      store.serverError ?? 'Something went wrong',
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
                Text(
                  "15-days Forecast",
                  style: darkColorText.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                      itemCount: store.weather?.list?.length ?? 0,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: containerColor,
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
                                      ? 'Today'
                                      : getWeek(dateFromTimeStamp(
                                      store.weather!.list![index].dt!)),
                                  style: lightColorText.copyWith(fontSize: 20),
                                ),
                              ),
                              Expanded(
                                child: Image.network(
                                  getIconUrl(store.weather!.list![index]
                                      .weather!.first.icon ??
                                      ''),
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              Text(
                                '${settingStore.getFromKelvin(store.weather!.list![index].temp!.max!)}\u00b0',
                                style: lightColorText.copyWith(fontSize: 20),
                              ),
                              Text(
                                '/${settingStore.getFromKelvin(store.weather!.list![index].temp!.min!)}\u00b0',
                                style: lowerDarkText.copyWith(fontSize: 20),
                              ),
                            ],
                          ),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getIt.unregister<WeatherDetailsStore>();
  }
}
