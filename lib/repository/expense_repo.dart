import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/service/networking_service/api_constants.dart';
import 'package:expense_tracker/utils/locator.dart';

import '../service/networking_service/network_service.dart';

abstract class ExpenditureRepo {
  Future<GeneralResponse> addExpenditure(
      {required String category,
      required String itemName,
      required double amount});
  Future<List<ExpenditureModel>> getExpenditure();
}

class ExpenditureRepoImpl extends ExpenditureRepo {
  final NetworkService _networkService = serviceLocator<NetworkService>();

  @override
  Future<GeneralResponse> addExpenditure(
      {required String category,
      required String itemName,
      required double amount}) async {
    final response = await _networkService.postData(
        url: ApiConstants.expenditure,
        data: {
          "category": category,
          "nameOfItem": itemName,
          "estimatedAmount": amount
        });

    return GeneralResponse.fromJson(response);
  }

  @override
  Future<List<ExpenditureModel>> getExpenditure() async {
    final response = await _networkService.getData(
      url: ApiConstants.expenditure,
    );

    return List<ExpenditureModel>.from(response["data"].map(
      (x) => ExpenditureModel.fromJson(x),
    )).toList();
  }
}
