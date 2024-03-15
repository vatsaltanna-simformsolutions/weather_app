# Weather App

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/c542227c93544dcc8d695a7dcf101c4e)](https://app.codacy.com/gh/vatsaltanna-simformsolutions/weather_app/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

Video Preview Link: [Preview.mp4](https://github.com/vatsaltanna-simformsolutions/weather_app/raw/main/preview/video.mp4)

Android App Link: [Weather App](https://github.com/vatsaltanna-simformsolutions/weather_app/raw/main/preview/weather_app.apk)

## Requirements
- IDE: An Integrated Development Environment to view and run the code.
  - Recommanded: Android Studio Giraffe (2022.3.1 Patch 4) or higher
- Android SDK (required for Android apps)
  - NOTE: If you are using Android Studio as an IDE, you won't need to do any additional setup for this.
- Flutter 3.13.0
  - Check [this](https://docs.flutter.dev/get-started/install) flutter setup guide to properly install flutter.
- XCode: 15.2 or higher (required for iOS apps)

## Minimum requirements

- Android Kitkat 4.4 or higher
- iOS 12 or higher

## Setup & Run
Ensure you have installed and setup all the necessary components before proceeding with the following steps. You're in the project's root directory.

- Step 1: Run Flutter Doctor by executing the following command and making sure it has no issues. If there are any issues, fix them before proceeding to the next step.
  ```shell 
  flutter doctor
  ```

- Step 2: Clone the repository from the Git Hub using the below command.
  ```shell 
  git clone https://github.com/vatsaltanna-simformsolutions/weather_app.git 
  ```

- Step 3: Open the project in your preferred IDE.

- Step 4: Get the API key from the *[OpenWeather](https://openweathermap.org/api)* and set the `appId` variable at *`lib > values > constants.dart`* file.
  ```dart 
  static const appId = '[Paste your key here]';
  /// If the api key is "abddsjddhdhdhdhdh", it will be like following after pasting it.
  /// static const appId = 'abddsjddhdhdhdhdh';
  ```
- Step 5: Run `flutter pub get`.
- Step 6: Generate all the required files by running the following command.
  ```shell 
  flutter pub run build_runner build --delete-conflicting-outputs 
  ```

- Step 7: Make sure an emulator is running. Or a physical device is connected to the system.
- Step 8: Run the Flutter app using the following command.
  ```shell
  flutter run
  ```

## APIs
We've used the OpenWeather API to get the weather data. Make sure you have a startup subscription plan for this API.

Also, we have used the Open-Meteo API to get the location data.

## Resources & References
- [OpenWeather](https://openweathermap.org/)
- [Open-Meteo](https://open-meteo.com/)
- UI Reference: Android's Weather app.
- MVVM Architecture
- MobX state management

## Development Tools:
- Android Studio Giraffe
- Flutter SDK 3.13.0
- XCode 15.2
- Postman