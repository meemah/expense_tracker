import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List expenseType = [
  "Food",
  "Transport",
  "Utilities",
  "Housing",
  "HealthCare",
  "Entertainment",
  "Personal",
  "Gift",
  "Clothing",
  "Groceries",
  "Other"
];

class TransactionType {
  final String type;
  final Color transactionColor;
  final IconData icon;

  TransactionType(
      {required this.type, required this.transactionColor, required this.icon});

  static final List<TransactionType> incomeTransactions = [
    TransactionType(
        type: "Savings",
        transactionColor: const Color(0xffEF6C00).withOpacity(0.5),
        icon: Icons.savings_sharp),
    TransactionType(
        type: "Salary",
        transactionColor: const Color(0xff3F51B5).withOpacity(0.5),
        icon: Icons.payment),
    TransactionType(
        type: "Remittance",
        transactionColor: const Color(0xff006064).withOpacity(0.8),
        icon: Icons.money_off_csred_outlined),
    TransactionType(
        type: "Others",
        transactionColor: const Color(0xff4527A0).withOpacity(0.5),
        icon: Icons.onetwothree),
  ];
  static final List<TransactionType> expenditureTransactions = [
    TransactionType(
        type: "Food",
        transactionColor: const Color(0xffEF6C00).withOpacity(0.5),
        icon: Icons.lunch_dining_rounded),
    TransactionType(
        type: "Transport",
        transactionColor: const Color(0xffFCE4EC),
        icon: Icons.commute),
    TransactionType(
        type: "Utilities",
        transactionColor: const Color(0xff42A5F5).withOpacity(0.5),
        icon: Icons.electrical_services),
    TransactionType(
        type: "Housing",
        transactionColor: const Color(0xff3F51B5).withOpacity(0.5),
        icon: Icons.bedroom_child),
    TransactionType(
        type: "HealthCare",
        transactionColor: const Color(0xffFFC400).withOpacity(0.5),
        icon: Icons.health_and_safety),
    TransactionType(
        type: "Entertainment",
        transactionColor: const Color(0xff3F51B5).withOpacity(0.2),
        icon: CupertinoIcons.game_controller),
    TransactionType(
        type: "Personal",
        transactionColor: const Color(0xff4527A0).withOpacity(0.5),
        icon: Icons.local_laundry_service),
    TransactionType(
        type: "Gift",
        transactionColor: const Color(0xffFF80AB).withOpacity(0.8),
        icon: Icons.card_giftcard),
    TransactionType(
        type: "Clothing",
        transactionColor: const Color(0xff80DEEA),
        icon: Icons.card_giftcard),
    TransactionType(
        type: "Groceries",
        transactionColor: const Color(0xffB2EBF2),
        icon: Icons.local_grocery_store),
    TransactionType(
        type: "Others",
        transactionColor: const Color(0xff006064).withOpacity(0.8),
        icon: Icons.onetwothree),
  ];

  static TransactionType getExpenditureTransaction({required String type}) {
    return expenditureTransactions.firstWhere(
      (element) => element.type.toLowerCase() == type.toLowerCase(),
      orElse: () {
        return expenditureTransactions[expenditureTransactions.length - 1];
      },
    );
  }

  static TransactionType getIncomeTransaction({required String type}) {
    return incomeTransactions.firstWhere(
      (element) => element.type.toLowerCase() == type.toLowerCase(),
      orElse: () {
        return incomeTransactions[incomeTransactions.length - 1];
      },
    );
  }

  @override
  String toString() {
    return type;
  }
}
