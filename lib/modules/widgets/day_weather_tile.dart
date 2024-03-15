import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/strings.dart';

class DayWeatherTile extends StatelessWidget {
  const DayWeatherTile(
      {super.key,
      required this.index,
      required this.day,
      this.icon,
      this.min,
      this.max});

  final int index;
  final String? icon;
  final double? min;
  final double? max;
  final String day;

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              day,
              style: AppColors.lightColorText.copyWith(fontSize: 20),
            ),
          ),
          icon != null
              ? CachedNetworkImage(
                  height: 40,
                  width: 40,
                  imageUrl: icon!,
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    sprintf(AppStrings.temperatureWithDegree, [min]),
                    style: AppColors.lightColorText.copyWith(fontSize: 18),
                  ),
                  Text(
                    '/',
                    style: AppColors.lightColorText.copyWith(fontSize: 18),
                  ),
                  Text(
                    sprintf(AppStrings.temperatureWithDegree, [max]),
                    style: AppColors.lowerDarkText.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
