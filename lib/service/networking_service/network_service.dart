import 'package:dio/dio.dart';
import 'package:expense_tracker/service/networking_service/app_exceptions.dart';
import 'package:expense_tracker/service/secure_storage/secure_storage.dart';
import 'package:expense_tracker/utils/app_constants/storage_keys.dart';
import 'package:expense_tracker/utils/locator.dart';

abstract class NetworkService {
  Future<dynamic> getData({required url});
  Future<dynamic> postData({required url, required Map data});
}

class NetworkClientImpl extends NetworkService {
  final Dio _dio = Dio();

  NetworkClientImpl() {
    _dio.options.baseUrl = "https://personal-expense-tracker.up.railway.app/";
    _dio.options.connectTimeout = 15000;
    _dio.options.receiveTimeout = 9000;
    _dio.options.responseType = ResponseType.json;
    _dio.interceptors.add(AuthorizationTokenInjector());
  }

  @override
  Future<dynamic> getData({required url}) async {
    try {
      final response = await _dio.get(
        url,
      );

      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  @override
  Future postData({required url, required Map data}) async {
    try {
      final response = await _dio.post(url, data: data);

      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

class AuthorizationTokenInjector extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final SecureStorageService secureStorageService =
        serviceLocator<SecureStorageService>();
    String? token =
        await secureStorageService.read(key: StorageKey.accessToken);
    if (token != null) {
      options.headers["Authorization"] = token;
    }
    super.onRequest(options, handler);
  }
}
