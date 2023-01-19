import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/models/income_model.dart';
import 'package:expense_tracker/repository/income_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'income_test.mocks.dart';

@GenerateMocks([
  IncomeRepoImpl,
], customMocks: [
  // ignore: deprecated_member_use

  // ignore: deprecated_member_use
  MockSpec<IncomeModel>(returnNullOnMissingStub: true),
  MockSpec<GeneralResponse>(returnNullOnMissingStub: true),
])
void main() {
  final incomeRepoImpl = MockIncomeRepoImpl();
  final mockResponse = MockGeneralResponse();

  group("testing Income", () {
    test("Test to see if I can add an income completes successfully", () {
      when(mockResponse.message).thenReturn("successful");

      when(incomeRepoImpl.addIncome(nameOfRevenue: "food", amount: 1000))
          .thenAnswer((_) => Future.value(mockResponse));
      expect("successful", mockResponse.message);
    });

    test("Test to see if adding income fails", () {
      when(incomeRepoImpl.addIncome(nameOfRevenue: "food", amount: 1000))
          .thenAnswer((_) => Future.value(mockResponse));

      expect(mockResponse.message, isNot(""));
    });
  });

  group("testing getting income", () {
    final List<MockIncomeModel> mockIncomeListResponse = [MockIncomeModel()];

    test("Test to see if I can get all income successfully", () {
      when(mockResponse.message).thenReturn("successful");

      when(incomeRepoImpl.getIncome())
          .thenAnswer((_) => Future.value(mockIncomeListResponse));
      expect(1, mockIncomeListResponse.length);
    });
  });
}
