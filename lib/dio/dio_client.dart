import 'package:dio/dio.dart';

class DioClient{

  Dio? _dio;
  static DioClient _instance = DioClient._internal();

  factory DioClient(){
    return _instance;
  }

  DioClient._internal(){
    if (_dio == null){
      _dio = Dio(BaseOptions(
        baseUrl: "https://www.metaweather.com/",
        connectTimeout: 300000,
        receiveTimeout: 300000
      ));
    }
  }

  Dio get dio => _dio!;

}