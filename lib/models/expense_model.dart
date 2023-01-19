import 'dart:convert';

ExpenditureModel? expenditureModelFromJson(String str) =>
    ExpenditureModel.fromJson(json.decode(str));

class ExpenditureModel {
  ExpenditureModel({
    this.id,
    this.category,
    this.nameOfItem,
    this.estimatedAmount,
  });

  String? id;
  String? category;
  String? nameOfItem;
  int? estimatedAmount;

  factory ExpenditureModel.fromJson(Map<String, dynamic> json) =>
      ExpenditureModel(
        id: json["id"],
        category: json["category"],
        nameOfItem: json["nameOfItem"],
        estimatedAmount: json["estimatedAmount"],
      );
}
