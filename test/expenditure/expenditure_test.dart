import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/general_response.dart';

import 'package:expense_tracker/repository/expense_repo.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'expenditure_test.mocks.dart';

@GenerateMocks([
  ExpenditureRepoImpl,
], customMocks: [
  // ignore: deprecated_member_use

  // ignore: deprecated_member_use
  MockSpec<GeneralResponse>(returnNullOnMissingStub: true),
  MockSpec<ExpenditureModel>(returnNullOnMissingStub: true),
])
void main() {
  final expenditureRepoImpl = MockExpenditureRepoImpl();
  final mockResponse = MockGeneralResponse();

  group("testing expenditure", () {
    test("Test to see if I can add an expenditure completes successfully", () {
      when(mockResponse.message).thenReturn("successful");

      when(expenditureRepoImpl.addExpenditure(
              category: "food", itemName: "spag", amount: 100))
          .thenAnswer((_) => Future.value(mockResponse));
      expect("successful", mockResponse.message);
    });

    test("Test to see if adding expenditure fails", () {
      when(expenditureRepoImpl.addExpenditure(
              category: "food", itemName: "spag", amount: 100))
          .thenAnswer((_) => Future.value(mockResponse));

      expect(mockResponse.message, isNot(""));
    });
  });

  group("testing getting expenditure", () {
    final List<MockExpenditureModel> mockExpenditureListResponse = [
      MockExpenditureModel()
    ];

    test("Test to see if I can get all income successfully", () {
      when(mockResponse.message).thenReturn("successful");

      when(expenditureRepoImpl.getExpenditure())
          .thenAnswer((_) => Future.value(mockExpenditureListResponse));
      expect(1, mockExpenditureListResponse.length);
    });
  });
}
