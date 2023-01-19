import 'dart:convert';

class IncomeModel {
  final String? id;
  final String? nameOfRevenue;
  final int? amount;

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        id: json["id"],
        nameOfRevenue: json["nameOfRevenue"],
        amount: json["amount"],
      );

  IncomeModel({this.id, this.nameOfRevenue, this.amount});
}

IncomeModel? incomeModelFromJson(String str) =>
    IncomeModel.fromJson(json.decode(str));
