// To parse this JSON data, do
//
//     final requestResetOtp = requestResetOtpFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RequestResetOtp requestResetOtpFromJson(String str) => RequestResetOtp.fromJson(json.decode(str));

String requestResetOtpToJson(RequestResetOtp data) => json.encode(data.toJson());

class RequestResetOtp {
    final bool status;
    final String message;
    final User user;

    RequestResetOtp({
        required this.status,
        required this.message,
        required this.user,
    });

    factory RequestResetOtp.fromJson(Map<String, dynamic> json) => RequestResetOtp(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    final String id;
    final String firstName;
    final String lastName;
    final String phone;
    final String email;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
    };
}
