import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/models/income_model.dart';
import 'package:expense_tracker/repository/income_repo.dart';
import 'package:expense_tracker/service/networking_service/data_response.dart';
import 'package:expense_tracker/utils/locator.dart';
import 'package:flutter/material.dart';

class IncomeViewmodel extends ChangeNotifier {
  IncomeViewmodel() {
    getAllIncome();
  }
  final IncomeRepo _incomeRepo = serviceLocator<IncomeRepo>();
  NetworkDataResponse<String> _saveIncomeResponse = NetworkDataResponse.idle();

  NetworkDataResponse<String> get saveIncomeResponse => _saveIncomeResponse;

  set saveIncomeResponse(NetworkDataResponse<String> saveIncomeResponse) {
    _saveIncomeResponse = saveIncomeResponse;
    notifyListeners();
  }

  NetworkDataResponse<List<IncomeModel>> _getIncomeResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<List<IncomeModel>> get getIncomeResponse =>
      _getIncomeResponse;

  set getIncomeResponse(
      NetworkDataResponse<List<IncomeModel>> getIncomeResponse) {
    _getIncomeResponse = getIncomeResponse;
    notifyListeners();
  }

  int _totalIncome = 0;

  int get totalIncome => _totalIncome;

  set totalIncome(int totalIncome) {
    _totalIncome = totalIncome;
    notifyListeners();
  }

  getAllIncome() async {
    try {
      getIncomeResponse = NetworkDataResponse.loading("getting all income");
      List<IncomeModel> income = await _incomeRepo.getIncome();

      if (income.isNotEmpty) {
        totalIncome = (income
                .map(((e) => e.amount))
                .toList()
                .reduce((value, element) => ((value ?? 0) + (element ?? 0))) ??
            0);
      }

      getIncomeResponse = NetworkDataResponse.completed(income);
    } catch (e) {
      getIncomeResponse = NetworkDataResponse.error(e.toString());
    }
  }

  saveIncome({required String nameOfRevenue, required double amount}) async {
    try {
      saveIncomeResponse = NetworkDataResponse.loading("save expense");
      GeneralResponse response = await _incomeRepo.addIncome(
          nameOfRevenue: nameOfRevenue, amount: amount);
      if (getIncomeResponse.data != null) {
        getIncomeResponse.data!.add(
            IncomeModel(nameOfRevenue: nameOfRevenue, amount: amount.toInt()));
        totalIncome += amount.toInt();
      }

      saveIncomeResponse = NetworkDataResponse.completed(response.message);
    } catch (e) {
      saveIncomeResponse = NetworkDataResponse.error(e.toString());
    }
  }
}
