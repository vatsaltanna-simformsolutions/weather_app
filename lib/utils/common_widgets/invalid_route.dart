import 'package:flutter/material.dart';
import 'package:weather_app/values/strings.dart';

class InvalidRoute extends StatelessWidget {
  const InvalidRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.invalidRoute),
      ),
    );
  }
}
