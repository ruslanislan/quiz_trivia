import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static const _baseUrl = 'https://opentdb.com';

  final Dio _dio = Dio();

  Dio get dio => _dio;

  DioClient() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        enabled: kDebugMode,
      ),
    );
  }

  void addInterceptors(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  void removeInterceptors(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }
}
