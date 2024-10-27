import 'package:dio/dio.dart';

import '../exceptions/trivia_exceptions.dart';

class TriviaInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic> &&
        (response.data as Map).containsKey('response_code')) {
      final int responseCode =
          int.parse((response.data as Map)['response_code'].toString());

      switch (responseCode) {
        case 1:
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: NoResultsException(),
            ),
          );
        case 2:
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: InvalidParameterException(),
            ),
          );
        case 3:
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: TokenNotFoundException(),
            ),
          );
        case 4:
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: TokenEmptyException(),
            ),
          );
        default:
          break;
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.data is Map<String, dynamic> &&
        (err.response?.data as Map).containsKey('response_code')) {
      final int responseCode =
          int.parse((err.response?.data as Map)['response_code'].toString());

      switch (responseCode) {
        case 5:
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: RateLimitException(),
            ),
          );
        default:
          break;
      }
    }
    handler.next(err);
  }
}
