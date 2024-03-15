import 'dart:async';

import 'package:dio/dio.dart';
import 'package:weather_app/services/shared_prefs.dart';
import 'package:weather_app/values/constants.dart';

import '../utils/network_utils.dart';
import 'api_logger.dart';

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor({this.showLogs = true});

  final bool showLogs;

  final APILogger _logger = APILogger();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final internet = await NetworkUtils.instance.checkHasInternet();
    final newOptions = Map<String, dynamic>.from(options.queryParameters);
    // if (internet) {
    // final token = await checkToken();
    // if (token?.isNotEmpty ?? false) {
    //   options.headers.putIfAbsent('Authorization', () => token);
    // }
    newOptions['appid'] = Constants.appId;
    print(newOptions.toString());
    // option
    // _logger.printSuccessLog(
    //   apiMethod: options.method,
    //   responseBody: options.data.toString(),
    //   parameters: options.queryParameters,
    //   url: '${options.baseUrl}${options.path}',
    //   token: options.headers['Authentication'].toString(),
    // );
    // } else {
    //   // TODO(username): Show no internet dialog or toast here.
    // }
    handler.next(options.copyWith(queryParameters: newOptions));
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode == 401) {
      // TODO(username): Handle token expired
    }
    // _logger.printSuccessLog(
    //   apiMethod: response.requestOptions.method,
    //   responseBody: response.data.toString(),
    //   parameters: 'response.requestOptions.data as Object',
    //   url: '${response.realUri.scheme}://${response.realUri.authority}'
    //       '${response.realUri.path}',
    //   token:  '',
    //   isRequest: false,
    // );
    if (response.data == null) {
      final data = SharedPrefs.getSharedProperty(
          keyEnum: response.requestOptions.uri.toString());
      handler.resolve(data);
    } else {
      SharedPrefs.setSharedProperty(
        keyEnum: response.requestOptions.uri.toString(),
        value: response.data.toString(),
      );

      handler.resolve(response);
    }
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (err.response != null) {
      _logger.printErrorLog(
        responseBody: err.response!.data.toString(),
        parameters: err.response!.requestOptions.data as Object,
        url:
            '${err.response!.realUri.scheme}://${err.response!.realUri.authority}'
            '${err.response!.realUri.path}',
        token: err.response!.headers.value('Authentication') ?? '',
        errorString: err.response!.statusMessage ?? 'No message found',
        statusCode: err.response!.statusCode ?? -1,
      );
    }

    handler.reject(err);
  }

// Future<String?> checkToken() async =>
//     SecureStorage.getValue(key: SecureStorageKeys.kAccessToken);
}
