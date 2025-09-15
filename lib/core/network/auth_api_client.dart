import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:steam/config/routes/app_router.dart';
import 'package:steam/core/network/session_manager.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient._internal(this._dio);

  factory AuthApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://panel.start-team.ir/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = SessionManager.instance.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'JWT $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = SessionManager.instance.refreshToken;
            if (refreshToken != null) {
              try {
                final newTokens = await _refreshToken(refreshToken);
                await SessionManager.instance.saveSession(
                  accessToken: newTokens['access_token'],
                  refreshToken: newTokens['refresh_token'],
                  userId: newTokens['user_id'],
                );

                final newRequest = error.requestOptions;
                newRequest.headers['Authorization'] =
                    'JWT ${newTokens['access_token']}';
                final cloneReq = await dio.fetch(newRequest);
                return handler.resolve(cloneReq);
              } catch (e) {
                await SessionManager.instance.clearSession();

                GoRouter.of(navigatorKey.currentContext!).go('/login');

                return handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    message: 'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
                  ),
                );
              }
            } else {
              await SessionManager.instance.clearSession();
              GoRouter.of(navigatorKey.currentContext!).go('/login');

              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  message: 'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
                ),
              );
            }
          }

          return handler.next(error);
        },
      ),
    );

    return AuthApiClient._internal(dio);
  }

  //! for refresh token
  static Future<Map<String, dynamic>> _refreshToken(String refreshToken) async {
    final dio = Dio();
    final response = await dio.post(
      'https://panel.start-team.ir/auth/refresh/',
      data: {'refresh_token': refreshToken},
      options: Options(headers: {'Accept': 'application/json'}),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('رفرش توکن ناموفق بود');
    }
  }

  //! for http methods
  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data);
  }
}
