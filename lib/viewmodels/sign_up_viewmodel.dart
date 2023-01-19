import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/repository/auth_repo.dart';
import 'package:expense_tracker/service/networking_service/data_response.dart';
import 'package:expense_tracker/service/secure_storage/secure_storage.dart';
import 'package:expense_tracker/utils/app_constants/storage_keys.dart';
import 'package:expense_tracker/utils/locator.dart';
import 'package:flutter/material.dart';

class SignUpViewmodel extends ChangeNotifier {
  final AuthRepo _authRepo = serviceLocator<AuthRepo>();
  final SecureStorageService _secureStorageService =
      serviceLocator<SecureStorageService>();
  NetworkDataResponse<bool> _signUpResponse = NetworkDataResponse.idle();

  NetworkDataResponse<bool> get signUpResponse => _signUpResponse;

  set signUpResponse(NetworkDataResponse<bool> signUpResponse) {
    _signUpResponse = signUpResponse;
    notifyListeners();
  }

  signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      signUpResponse = NetworkDataResponse.loading("Signing up");
      GeneralResponse generalResponse =
          await _authRepo.signUp(name: name, email: email, password: password);
      _secureStorageService.write(
          key: StorageKey.accessToken, value: generalResponse.token ?? "");
      signUpResponse = NetworkDataResponse.completed(true);
    } catch (e) {
      signUpResponse = NetworkDataResponse.error(e.toString());
    }
  }
}
