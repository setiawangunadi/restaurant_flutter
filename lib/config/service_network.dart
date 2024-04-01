import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:restaurant/config/constants.dart';
import 'package:restaurant/config/exception/network.dart';
import 'package:restaurant/config/exception/session_expired.dart';

class ServiceNetwork {
  final Dio dio = Dio()
    ..interceptors.add(HttpFormatter(
      includeRequest: true,
      includeRequestBody: true,
      includeResponse: true,
      includeResponseBody: true,
      includeRequestHeaders: true,
      includeRequestQueryParams: true,
      includeResponseHeaders: true,
    ));

  ServiceNetwork._privateConstructor();

  static final ServiceNetwork _instance = ServiceNetwork._privateConstructor();

  factory ServiceNetwork() => _instance;

  Future<Response> get({
    String? baseUrls,
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (baseUrls == null) {
      try {
        final response = await dio.get(
          '${Constants.baseUrl}$path',
          queryParameters: queryParameters,
          options: Options(
            headers: {"Authorization": "Bearer "},
          ),
        );
        return response;
      } on DioException catch (e) {
        _returnResponseError(e);
      } catch (e) {
        throw Exception(e);
      }
    }

    try {
      final response = await dio.get(
        '$baseUrls$path',
        queryParameters: queryParameters,
        options: Options(
          headers: {"Authorization": "Bearer "},
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> post(
      {required String path,
      dynamic data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(
        '${Constants.baseUrl}$path',
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {"Authorization": "Bearer "},
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> put({required String path, dynamic data}) async {
    try {
      final response = await dio.put(
        '${Constants.baseUrl}$path',
        data: data,
        options: Options(
          headers: {"Authorization": "Bearer "},
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  dynamic _returnResponseError(DioException e) {
    String messageDefault = 'Bad Network! Please Try Again Later!';
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw messageDefault;
      case DioExceptionType.sendTimeout:
        throw messageDefault;
      case DioExceptionType.receiveTimeout:
        throw messageDefault;
      case DioExceptionType.badResponse:
        if (e.response!.statusCode == 401) {
          throw SessionExpired(
            message: e.response?.data,
            statusCode: e.response?.statusCode,
          );
        }
        if (e.response!.statusCode == 403) {
          throw SessionExpired(
            message: e.response?.data,
            statusCode: e.response?.statusCode,
          );
        }
        if (e.response!.statusCode == 404) {
          throw Network(
            responseMessage: e.response?.data,
            httpStatus: e.response?.statusCode,
          );
        }
        if (e.response!.statusCode == 400) {
          throw SessionExpired(
            message: e.response?.data,
            statusCode: e.response?.statusCode,
          );
        }
        if (e.response!.statusCode == 502) {
          throw Network(
            responseMessage: e.response?.data,
            httpStatus: e.response?.statusCode,
          );
        }
        if (e.response!.statusCode == 500) {
          throw Network(
            responseMessage: e.response?.data,
            httpStatus: e.response?.statusCode,
          );
        }
      case DioExceptionType.cancel:
        throw 'Cancel Request To Server!';
      case DioExceptionType.unknown:
        throw 'Please Check Your Internet!';
      default:
        throw 'Unhandled error: ${e.type}';
    }
  }
}
