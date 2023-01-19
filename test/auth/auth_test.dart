import 'package:expense_tracker/models/general_response.dart';
import 'package:expense_tracker/repository/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateMocks([
  AuthRepoImpl,
], customMocks: [
  // ignore: deprecated_member_use

  // ignore: deprecated_member_use
  MockSpec<GeneralResponse>(returnNullOnMissingStub: true),
])
void main() {
  group("testing sign in", () {
    final authServiceImpl = MockAuthRepoImpl();
    final mockResponse = MockGeneralResponse();

    test("Test to see if the sign in completes successfully", () {
      when(mockResponse.message).thenReturn("successful");

      when(authServiceImpl.signIn(
              email: "hello@getnada.com", password: "password"))
          .thenAnswer((_) => Future.value(mockResponse));
      expect("successful", mockResponse.message);
    });

    test("Test to see if the sign in fails", () {
      when(authServiceImpl.signIn(
              email: "hello@getnada.com", password: "password"))
          .thenAnswer((_) => Future.value(mockResponse));

      expect(mockResponse.message, isNot(""));
    });
  });

  group("testing sign up", () {
    final authServiceImpl = MockAuthRepoImpl();
    final mockResponse = MockGeneralResponse();
    test("Test to see if the sign up completes successfully", () {
      when(mockResponse.message).thenReturn("successful");

      when(authServiceImpl.signUp(
              name: "hello", email: "hello@getnada.com", password: "password"))
          .thenAnswer((_) => Future.value(mockResponse));
      expect("successful", mockResponse.message);
    });

    test("Test to see if the sign up fails", () {
      when(authServiceImpl.signUp(
              name: "hello", email: "hello@getnada.com", password: "password"))
          .thenAnswer((_) => Future.value(mockResponse));
      expect(mockResponse.message, isNot(""));
    });
  });
}
