import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/repository/expense_repo.dart';
import 'package:expense_tracker/service/networking_service/data_response.dart';

import 'package:expense_tracker/utils/locator.dart';
import 'package:flutter/material.dart';

class ExpenditureViewmodel extends ChangeNotifier {
  ExpenditureViewmodel() {
    getAllExpenses();
  }
  final ExpenditureRepo _expenseRepo = serviceLocator<ExpenditureRepo>();
  NetworkDataResponse<List<ExpenditureModel>> _allExpenditureResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<List<ExpenditureModel>> get allExpenditureResponse =>
      _allExpenditureResponse;

  set allExpenditureResponse(
      NetworkDataResponse<List<ExpenditureModel>> allExpenditureResponse) {
    _allExpenditureResponse = allExpenditureResponse;
    notifyListeners();
  }

  NetworkDataResponse<String> _saveExpenditureResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<String> get saveExpenditureResponse =>
      _saveExpenditureResponse;

  set saveExpenditureResponse(
      NetworkDataResponse<String> saveExpenditureResponse) {
    _saveExpenditureResponse = saveExpenditureResponse;
    notifyListeners();
  }

  getAllExpenses() async {
    try {
      allExpenditureResponse =
          NetworkDataResponse.loading("getting all expense");
      List<ExpenditureModel> expenses = await _expenseRepo.getExpenditure();
      if (expenses.isNotEmpty) {
        totalExpenditure = (expenses
                .map(((e) => e.estimatedAmount))
                .toList()
                .reduce((value, element) => ((value ?? 0) + (element ?? 0))) ??
            0);
      }

      allExpenditureResponse = NetworkDataResponse.completed(expenses);
    } catch (e) {
      allExpenditureResponse = NetworkDataResponse.error(e.toString());
    }
  }

  int _totalExpenditure = 0;

  int get totalExpenditure => _totalExpenditure;

  set totalExpenditure(int totalExpenditure) {
    _totalExpenditure = totalExpenditure;
    notifyListeners();
  }

  saveExpenditure(
      {required String category,
      required String itemName,
      required double amount}) async {
    try {
      saveExpenditureResponse = NetworkDataResponse.loading("save expense");
      GeneralResponse response = await _expenseRepo.addExpenditure(
          category: category, itemName: itemName, amount: amount);
      if (allExpenditureResponse.data != null) {
        allExpenditureResponse.data!.add(ExpenditureModel(
            category: category,
            nameOfItem: itemName,
            estimatedAmount: amount.toInt()));
        totalExpenditure += amount.toInt();
      }
      saveExpenditureResponse = NetworkDataResponse.completed(response.message);
    } catch (e) {
      saveExpenditureResponse = NetworkDataResponse.error(e.toString());
    }
  }
}
