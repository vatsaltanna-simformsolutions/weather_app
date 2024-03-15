import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/extensions.dart';
import '../../values/strings.dart';
import 'splash_screen_store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashScreenStore? store;
  @override
  void initState() {
    super.initState();
    store = SplashScreenStore();
    store?.getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Text(
            store?.weather?.name ?? 'NA'
        );
      }
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//           ],
//         ),
//       ),
//     );
//   }
// }
