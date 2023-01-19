import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/service/secure_storage/secure_storage.dart';
import 'package:expense_tracker/utils/app_constants/storage_keys.dart';
import 'package:expense_tracker/utils/locator.dart';
import 'package:flutter/material.dart';

import '../repository/auth_repo.dart';
import '../service/networking_service/data_response.dart';

class SignInViewmodel extends ChangeNotifier {
  final AuthRepo _authRepo = serviceLocator<AuthRepo>();
  final SecureStorageService _secureStorageService =
      serviceLocator<SecureStorageService>();
  NetworkDataResponse<bool> _signInResponse = NetworkDataResponse.idle();

  NetworkDataResponse<bool> get signInResponse => _signInResponse;

  set signInResponse(NetworkDataResponse<bool> signInResponse) {
    _signInResponse = signInResponse;
    notifyListeners();
  }

  signIn({required String email, required String password}) async {
    try {
      signInResponse = NetworkDataResponse.loading("Signing up");
      GeneralResponse generalResponse =
          await _authRepo.signIn(email: email, password: password);
      _secureStorageService.write(
          key: StorageKey.accessToken, value: generalResponse.token ?? "");
      signInResponse = NetworkDataResponse.completed(true);
    } catch (e) {
      signInResponse = NetworkDataResponse.error(e.toString());
    }
  }

  signOut() {
    _secureStorageService.delete(key: StorageKey.accessToken);
  }
}
