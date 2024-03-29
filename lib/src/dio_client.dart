import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'http_exception.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;
const kServerError =
    'The server encountered an internal error and unable to process your request.';
const kRedirectionError = 'The resource requested has been temporarily moved.';
const kBadRequestError =
    'Your client has issued a malformed or illegal request.';
const kInternetError =
    'There is poor or no internet connection, please try again later.';

class DioClient {
  Dio? _dio;
  String? baseUrl;

  final List<Interceptor>? interceptors;

  DioClient({
    required Dio dio,
    this.interceptors,
    required this.baseUrl,
  }) {
    _dio = dio;
    _dio!
      ..options.baseUrl = baseUrl!
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'}
      ..httpClientAdapter;

    if (interceptors?.isNotEmpty ?? false) {
      _dio!.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio!.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }
  }

  Future<dynamic> get(
    String? uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.get(
        uri!,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type ||
          DioErrorType.sendTimeout == e.type) {
        throw HttpException(kInternetError);
      } else if (DioErrorType.response == e.type) {
        //when api returns error then use this.

        if (e.response!.statusCode! >= 400 || e.response!.statusCode! <= 499) {
          throw HttpException(kBadRequestError);
        } else if (e.response!.statusCode! >= 300 ||
            e.response!.statusCode! <= 399) {
          throw HttpException(kRedirectionError);
        } else if (e.response!.statusCode! >= 500 ||
            e.response!.statusCode! <= 599) {
          throw HttpException(kServerError);
        }
      } else {
        throw HttpException(kServerError);
      }
    }
  }

  Future<dynamic> delete(
    String? uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio!.delete(
        uri!,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type ||
          DioErrorType.sendTimeout == e.type) {
        throw HttpException(kInternetError);
      } else if (DioErrorType.response == e.type) {
        //when api returns error then use this.

        if (e.response!.statusCode! >= 400 || e.response!.statusCode! <= 499) {
          throw HttpException(kBadRequestError);
        } else if (e.response!.statusCode! >= 300 ||
            e.response!.statusCode! <= 399) {
          throw HttpException(kRedirectionError);
        } else if (e.response!.statusCode! >= 500 ||
            e.response!.statusCode! <= 599) {
          throw HttpException(kServerError);
        }
      } else {
        throw HttpException(kServerError);
      }
    }
  }

  Future<dynamic> post(
    String? uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.post(
        uri!,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type ||
          DioErrorType.sendTimeout == e.type) {
        throw HttpException(kInternetError);
      } else if (DioErrorType.response == e.type) {
        //when api returns error then use this.

        if (e.response!.statusCode! >= 400 || e.response!.statusCode! <= 499) {
          throw HttpException(kBadRequestError);
        } else if (e.response!.statusCode! >= 300 ||
            e.response!.statusCode! <= 399) {
          throw HttpException(kRedirectionError);
        } else if (e.response!.statusCode! >= 500 ||
            e.response!.statusCode! <= 599) {
          throw HttpException(kServerError);
        }
      } else {
        throw HttpException(kServerError);
      }
    }
  }
}
