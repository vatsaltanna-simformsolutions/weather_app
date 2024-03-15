import 'package:dio/dio.dart';
import 'package:weather_app/apibase/interfaces/repository.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/model/locations.dart';
import 'package:weather_app/values/constants.dart';

import '../model/response/invalid_response_model.dart';
import '../values/strings.dart';
import 'api_service.dart';
import 'header_interceptor.dart';

typedef ApiCallback<T> = Future<T> Function();

class Repository extends RepositoryBase {
  factory Repository() => instance;

  Repository._initialize() {
    dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));
    dio.interceptors.add(HeaderInterceptor());
    apiService = ApiService(dio);
    dio = Dio(BaseOptions(baseUrl: Constants.geoBaseUrl));
    dio.interceptors.add(HeaderInterceptor());
    apiServiceGeo = ApiService(dio);
  }

  static final Repository instance = Repository._initialize();

  late Dio dio;

  late ApiService apiService;
  late ApiService apiServiceGeo;

  @override
  Future<CurrentWeather> getCurrentWeather(double lat, double long) async {
    return _apiCall<CurrentWeather>(
        request: () => apiService.getCurrentWeather(lat: lat, long: long));
  }

  @override
  Future<CurrentWeather> getHourlyWeather(double lat, double long) async {
    return _apiCall<CurrentWeather>(
        request: () => apiService.getCurrentWeather(lat: lat, long: long));
  }

  @override
  Future<DaysForecast> getDaysForecast(
      double lat, double long, int days) async {
    return _apiCall<DaysForecast>(
        request: () =>
            apiService.getDaysForecast(lat: lat, long: long, days: days));
  }

  @override
  Future<Locations> getCityNames({required String name}) async {
    return _apiCall<Locations>(
        request: () => apiServiceGeo.getCityNames(count: 5, name: name));
  }

  Future<T> _apiCall<T>({
    required ApiCallback<T> request,
    String noDataMessage = ApiErrorStrings.somethingWrongErrorMsg,
  }) async {
    try {
      final response = await request();
      return response;
    } on String {
      rethrow;
    } on DioException catch (error) {
      if (error.response == null) {
        throw Exception(ApiErrorStrings.noInternetMsg);
      }

      switch (error.response!.statusCode) {
        case 500:
        case 503:
        case 504:
        case 403:
        case 422:
        case 404:
        default:
          final response = InvalidResponseModel.fromJson(
            error.response!.data as Map<String, dynamic>,
          );
          throw Exception(response.message ?? '');
      }
    }
  }
}
