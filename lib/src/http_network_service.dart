import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_network_service/src/dio_client.dart';

import 'http_exception.dart';

class HttpNetworkService {
  static late DioClient _dioClient;

  static init({
    required String? baseUrl,
  }) {
    var dio = Dio();

    _dioClient = DioClient(
      baseUrl: baseUrl,
      dio: dio,
    );
  }

  //it sends a get request using dio package with exception handling
  static Future getRequest(
      {String? uri,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await _dioClient.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );

      return response;
    } on HttpException catch (e) {
      throw e.message;
    }
  }

  //it sends a post request using dio package with exception handling
  static Future postRequest({
    String? uri,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dioClient.post(
        uri,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        data: data,
        onSendProgress: onSendProgress,
      );
      return response;
    } on HttpException catch (e) {
      throw e.message;
    }
  }

  //it sends a delete request using dio package with exception handling
  static Future deleteRequest(
      {String? uri,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final response = await _dioClient.delete(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
      );
      return response;
    } on HttpException catch (e) {
      throw e.message;
    }
  }

  //Send single or multiple images to server using dio
  static Future sendImagesRequest(
      {required String? uri,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      required List<File> images,
      required String? fileName}) async {
    try {
      var formData = FormData();

      images.forEach((image) async {
        formData.files.add(MapEntry(
          fileName!,
          await MultipartFile.fromFile(
            '${image.path}',
            filename: fileName,
          ),
        ));
      });

      final response = await _dioClient.post(
        uri,
        data: formData,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on HttpException catch (e) {
      throw e.message;
    }
  }
}
