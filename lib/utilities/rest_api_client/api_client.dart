import 'package:api/api.dart';
import 'package:dio/dio.dart';

import 'api_interceptor.dart';

class RestAPIClient extends APIClient {
  RestAPIClient._();
  static final RestAPIClient _instance = RestAPIClient._();
  factory RestAPIClient() => _instance;
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: BaseURLs.development.schemes + BaseURLs.development.basePath,
    ),
  )..interceptors.add(APIInterceptor());

  @override
  Future<APIResponse> execute({required APIRequest request}) async {
    try {
      final options = Options(
        method: request.method.value,
        headers: request.headers,
        contentType: request.contentType,
      );
      Response response = await dio.request(
        request.path,
        options: options,
        queryParameters: request.parameters,
        data: request.body,
      );
      return APIResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection Timeout Exception');
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Connection Receive Timeout Exception');
      } else if (e.type == DioErrorType.cancel) {
        throw Exception('Cancel Request Exception');
      } else if (e.type == DioErrorType.other) {
        throw Exception('Unknown Exception');
      } else if (e.type == DioErrorType.sendTimeout) {
        throw Exception('Send Timeout Exception');
      } else if (e.type == DioErrorType.response) {
        switch (e.response?.statusCode) {
          case 400:
            throw Exception('Bad Request');
          case 401:
            throw Exception('Authorization Exception');
          case 403:
            throw Exception('Forbidden');
          case 404:
            throw Exception('Not Found');
          case 429:
            throw Exception('Too Many Request');
          case 500:
            throw Exception('Internal Server Exception');
          case 501:
            throw Exception('Not Implemented');
          case 502:
            throw Exception('Bad Gateway');
          case 503:
            throw Exception('Service Unavailable');
          case 504:
            throw Exception('Gateway Timed Out');
          default:
            throw Exception('Invalid Exception');
        }
      } else {
        throw e.response?.data['message'] ?? '';
      }
    } catch (e) {
      rethrow;
    }
  }
}
