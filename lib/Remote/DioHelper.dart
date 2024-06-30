import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
  static late  Dio dio;
  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl:'https://graduationproject-production-a5f5.up.railway.app',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> GetData(
      {
        required String url,
        Map<String,dynamic>? query,
        required String token
      })async
  {
    dio.options.headers={
      'Authorization':token
    };
    return await dio.get(url,queryParameters:query,);
  }
  static Future<Response> PostCreate (
      {
        required String url,
        Map<String,dynamic>? query,
        FormData? data,
        String? token,
      }
      )async {
    dio.options.headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': token
    };

    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> PostData (
      {
        required String url,
        Map<String,dynamic>? query,
        Map<String,dynamic>? data,
        String? token,
      }
      )async {
    dio.options.headers = {
      'Authorization': token
    };

    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> PutData({
    required String url,
    required Map<String,dynamic>data,
    String? token,
    Map<String,dynamic>? query,
  })async{
    dio.options.headers={
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization':token
    };

    return await dio.put(url,queryParameters: query,data: data);
  }
}




