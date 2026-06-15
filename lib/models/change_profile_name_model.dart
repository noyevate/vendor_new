// To parse this JSON data, do
//
//     final changeProfileName = changeProfileNameFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangeProfileName changeProfileNameFromJson(String str) => ChangeProfileName.fromJson(json.decode(str));

String changeProfileNameToJson(ChangeProfileName data) => json.encode(data.toJson());

class ChangeProfileName {
    final bool status;
    final UpdatedUser updatedUser;
    final String message;

    ChangeProfileName({
        required this.status,
        required this.updatedUser,
        required this.message,
    });

    factory ChangeProfileName.fromJson(Map<String, dynamic> json) => ChangeProfileName(
        status: json["status"],
        updatedUser: UpdatedUser.fromJson(json["updatedUser"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "updatedUser": updatedUser.toJson(),
        "message": message,
    };
}

class UpdatedUser {
    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final dynamic otp;
    final String fcm;
    final String password;
    final String pin;
    final dynamic otpExpires;
    final bool verification;
    final String phone;
    final bool phoneVerification;
    final String userType;
    final DateTime createdAt;
    final DateTime updatedAt;

    UpdatedUser({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.otp,
        required this.fcm,
        required this.password,
        required this.pin,
        required this.otpExpires,
        required this.verification,
        required this.phone,
        required this.phoneVerification,
        required this.userType,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UpdatedUser.fromJson(Map<String, dynamic> json) => UpdatedUser(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        otp: json["otp"],
        fcm: json["fcm"],
        password: json["password"],
        pin: json["pin"],
        otpExpires: json["otpExpires"],
        verification: json["verification"],
        phone: json["phone"],
        phoneVerification: json["phoneVerification"],
        userType: json["userType"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "otp": otp,
        "fcm": fcm,
        "password": password,
        "pin": pin,
        "otpExpires": otpExpires,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
