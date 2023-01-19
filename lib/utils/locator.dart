import 'package:expense_tracker/repository/auth_repo.dart';
import 'package:expense_tracker/repository/expense_repo.dart';
import 'package:expense_tracker/repository/income_repo.dart';
import 'package:expense_tracker/service/secure_storage/secure_storage.dart';
import 'package:expense_tracker/utils/dark_theme/dark_theme_pref.dart';
import 'package:get_it/get_it.dart';

import '../service/networking_service/network_service.dart';

final serviceLocator = GetIt.instance;

Future<void> locatorSetUp() async {
  serviceLocator
      .registerLazySingleton<ThemePreference>(() => ThemePreferenceImpl());
  serviceLocator
      .registerLazySingleton<NetworkService>(() => NetworkClientImpl());
  serviceLocator.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  serviceLocator.registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl());
  serviceLocator.registerLazySingleton<IncomeRepo>(() => IncomeRepoImpl());
  serviceLocator
      .registerLazySingleton<ExpenditureRepo>(() => ExpenditureRepoImpl());
}
