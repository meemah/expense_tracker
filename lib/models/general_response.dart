import 'dart:convert';

GeneralResponse? generalResponseFromJson(String str) =>
    GeneralResponse.fromJson(json.decode(str));

class GeneralResponse {
  GeneralResponse({this.message, this.token});

  String? message;
  String? token;
  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(message: json["message"], token: json["accessToken"]);
}
