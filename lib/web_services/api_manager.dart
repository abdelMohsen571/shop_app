import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiManager {
  static init() {
    Dio dio = Dio(
      BaseOptions(
        //  baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    Map<String, dynamic>? query,
    String lang = 'en',
    required String token,
  }) async {
    Dio dio = Dio();
    String url = 'https://student.valuxapps.com/api/home';
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    Response response = await dio.get(url);
    return response.data;
  }

  static Future<Response> postData({
    String url = 'https://student.valuxapps.com/api/login',
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String token = '',
  }) async {
    Dio dio = Dio();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return dio.post(url, data: data, queryParameters: query);
  }
}
