// To parse this JSON data, do
//
//     final otpSucessModel = otpSucessModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OtpSucessModel otpSucessModelFromJson(String str) => OtpSucessModel.fromJson(json.decode(str));

String otpSucessModelToJson(OtpSucessModel data) => json.encode(data.toJson());

class OtpSucessModel {
    final String id;
    final String firstName;
    final String lastName;
    final String username;
    final String profile;
    final String email;
    final String fcm;
    final bool verification;
    final String phone;
    final bool phoneVerification;
    final String userType;
    final String token;
    final DateTime createdAt;
    final DateTime updatedAt;

    OtpSucessModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.profile,
        required this.email,
        required this.fcm,
        required this.verification,
        required this.phone,
        required this.phoneVerification,
        required this.userType,
        required this.token,
        required this.createdAt,
        required this.updatedAt
    });

    factory OtpSucessModel.fromJson(Map<String, dynamic> json) => OtpSucessModel(
        id: json["id"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        username: json["username"] ?? "",
        fcm: json["fcm"] ?? "",
        profile: json["profile"] ?? "",
        verification: json["verification"] ?? false,
        phone: json["phone"] ?? "",
        phoneVerification: json["phoneVerification"] ?? false,
        userType: json["userType"] ?? "Vendor",
        token: json["token"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]), 
    );

    Map<String, dynamic> toJson() => {
        "d": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "fcm": fcm,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "token": token,
    };
}
