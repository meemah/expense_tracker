import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/models/income_model.dart';
import 'package:expense_tracker/service/networking_service/api_constants.dart';
import 'package:expense_tracker/utils/locator.dart';

import '../service/networking_service/network_service.dart';

abstract class IncomeRepo {
  Future<GeneralResponse> addIncome(
      {required String nameOfRevenue, required double amount});
  Future<List<IncomeModel>> getIncome();
}

class IncomeRepoImpl extends IncomeRepo {
  final NetworkService _networkService = serviceLocator<NetworkService>();

  @override
  Future<GeneralResponse> addIncome(
      {required String nameOfRevenue, required double amount}) async {
    final response = await _networkService.postData(
        url: ApiConstants.income,
        data: {"nameOfRevenue": nameOfRevenue, "amount": amount});

    return GeneralResponse.fromJson(response);
  }

  @override
  Future<List<IncomeModel>> getIncome() async {
    final response = await _networkService.getData(
      url: ApiConstants.income,
    );

    return List<IncomeModel>.from(response["data"].map(
      (x) => IncomeModel.fromJson(x),
    )).toList();
  }
}
