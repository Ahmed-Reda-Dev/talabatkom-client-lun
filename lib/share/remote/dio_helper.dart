import 'dart:developer';

import 'package:dio/dio.dart';

class Api {
  final baseUrl = 'https://dev.talabatcom.sa/Admin/';

  static late Dio _dio;

  static init({
    required Map<String, dynamic> headers,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://dev.talabatcom.sa/Admin/',
        receiveDataWhenStatusError: true,
        headers: headers,
      ),
    );
  }

  static Future<Response> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
      );
    } on DioError catch (e) {
      log(e.message!);
      rethrow;
    }
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: data,
        // options: Options(
        //   responseType: ResponseType.stream,
        // ),
      );
    } on DioError catch (e) {
      log(e.message!);
      rethrow;
    }
  }

  static Future<Response> put({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
      );
    } on DioError catch (e) {
      log(e.message!);
      rethrow;
    }
  }

  static Future<Response> delete({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
      );
    } on DioError catch (e) {
      log(e.message!);
      rethrow;
    }
  }

  static Future<Response> patch({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
      );
    } on DioError catch (e) {
      log(e.message!);
      rethrow;
    }
  }
}
