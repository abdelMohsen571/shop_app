import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
        // baseUrl: 'https://student.valuxapps.com/api',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': token,
    };
    Response response = await dio.get(
      url,
      queryParameters: query,
    );
    return response;
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': token,
    };
    return dio.put(url, queryParameters: query, data: data);
  }
}
