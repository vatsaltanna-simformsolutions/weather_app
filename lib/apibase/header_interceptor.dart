import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/services/data_store/sp_data_store.dart';
import 'package:weather_app/values/constants.dart';
import 'package:weather_app/values/strings.dart';

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor({this.showLogs = true});

  final bool showLogs;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final newOptions = Map<String, dynamic>.from(options.queryParameters);
    newOptions['appid'] = Constants.appId;
    handler.next(options.copyWith(queryParameters: newOptions));
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.data == null) {
      final data = SPDataStore.store
          .getSharedProperty(keyEnum: response.requestOptions.uri.toString());
      handler.resolve(data);
    } else {
      SPDataStore.store.setSharedProperty(
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
    if (err.response == null) {
      ScaffoldMessenger.of(navigator.context).showSnackBar(const SnackBar(
        content: Text(ApiErrorStrings.noInternetMsg),
        duration: Duration(seconds: 6),
      ));
    }

    handler.reject(err);
  }
}
