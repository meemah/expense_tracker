import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/service/networking_service/api_constants.dart';
import 'package:expense_tracker/service/networking_service/network_service.dart';

import 'package:expense_tracker/utils/locator.dart';

abstract class AuthRepo {
  Future<GeneralResponse> signUp(
      {required String name, required String email, required String password});
  Future<GeneralResponse> signIn(
      {required String email, required String password});
}

class AuthRepoImpl extends AuthRepo {
  final NetworkService _networkService = serviceLocator<NetworkService>();

  @override
  Future<GeneralResponse> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final response = await _networkService.postData(
        url: ApiConstants.signUp,
        data: {"name": name, "email": email, "password": password});
    return GeneralResponse.fromJson(response);
  }

  @override
  Future<GeneralResponse> signIn(
      {required String email, required String password}) async {
    final response = await _networkService.postData(
        url: ApiConstants.signIn, data: {"email": email, "password": password});
    return GeneralResponse.fromJson(response);
  }
}
