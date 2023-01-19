// ignore_for_file: unnecessary_string_escapes

mixin Validators {
  static String? validateUserName(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Name cannot be empty';
      }
      return null;
    }
    return null;
  }

  static String? validateFieldEmpty(
    String? value,
  ) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Field is compulsory';
      }
      return null;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value != null) {
      if (value.length < 8) {
        return 'Password has to be 8 letters';
      }
      return null;
    }
    return null;
  }

  static String? isEmail(String? email,
      {String error = "Enter a valid email address"}) {
    return _isEmail(email)! ? null : error;
  }

  static bool? _isEmail(String? email) {
    if (email != null) {
      // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
      String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
          "\\@" +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
          "(" +
          "\\." +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
          ")+";
      return RegExp(p).hasMatch(email);
    }
    return null;
  }
}
