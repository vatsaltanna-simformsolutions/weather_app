import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/modules/settings/settings_store.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/enumeration.dart';
import 'package:weather_app/values/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  SettingsStore get store => getIt.get<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    const scaffoldColor = Color(0xff453b32);
    Color containerColor = const Color(0xff261F14);

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          AppStrings.appSettingsTxt,
          style: AppColors.darkColorText.copyWith(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: SettingTitle(
                        title: AppStrings.temperatureUnitTxt,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Observer(builder: (context) {
                      return _DropDownMenu<TemperatureUnit>(
                        onSelected: store.setUnit,
                        entries: TemperatureUnit.values
                            .map(
                              (e) => DropdownMenuEntry(
                                value: e,
                                label: e.display,
                              ),
                            )
                            .toList(),
                        value: store.unit,
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: SettingTitle(
                        title: AppStrings.reloadFrequency,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Observer(builder: (context) {
                      return _DropDownMenu<ReloadFrequencies>(
                        onSelected: store.setFrequency,
                        entries: ReloadFrequencies.values
                            .map(
                              (e) =>
                                  DropdownMenuEntry(value: e, label: e.display),
                            )
                            .toList(),
                        value: store.frequency,
                      );
                    }),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class SettingTitle extends StatelessWidget {
  const SettingTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        color: Color(0xfff7f3f0),
      ),
    );
  }
}

class _DropDownMenu<T> extends StatelessWidget {
  const _DropDownMenu({
    super.key,
    required this.entries,
    this.value,
    required this.onSelected,
  });

  final List<DropdownMenuEntry<T>> entries;
  final T? value;
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    const light = Color(0xfff7f3f0);

    const border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: light,
        style: BorderStyle.none,
      ),
    );

    const dropdownDecoration = InputDecorationTheme(
      border: border,
      focusedBorder: border,
      errorBorder: border,
      enabledBorder: border,
      disabledBorder: border,
      iconColor: light,
      suffixIconColor: light,
    );

    final menuStyle = MenuStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(const Color(0xffFEDEB6)),
    );

    return DropdownMenu(
      menuStyle: menuStyle,
      initialSelection: value,
      onSelected: onSelected,
      inputDecorationTheme: dropdownDecoration,
      textStyle: const TextStyle(color: light),
      dropdownMenuEntries: entries,
    );
  }
}
