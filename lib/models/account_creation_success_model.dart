// To parse this JSON data, do
//
//     final accountCreationSuccessModel = accountCreationSuccessModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AccountCreationSuccessModel accountCreationSuccessModelFromJson(String str) => AccountCreationSuccessModel.fromJson(json.decode(str));

String accountCreationSuccessModelToJson(AccountCreationSuccessModel data) => json.encode(data.toJson());

class AccountCreationSuccessModel {
    final bool status;
    final String message;
    final User user;
    final int price;
    final double serviceCharge;
    final Others others;

    AccountCreationSuccessModel({
        required this.status,
        required this.message,
        required this.user,
        required this.price,
        required this.serviceCharge,
        required this.others,
    });

    factory AccountCreationSuccessModel.fromJson(Map<String, dynamic> json) => AccountCreationSuccessModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        price: json["price"],
        serviceCharge: json["service_charge"]?.toDouble(),
        others: Others.fromJson(json["others"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
        "price": price,
        "service_charge": serviceCharge,
        "others": others.toJson(),
    };
}

class Others {
    final String id;
    final double minLat;
    final double maxLat;
    final double minLng;
    final double maxLng;
    final DateTime createdAt;
    final DateTime updatedAt;

    Others({
        required this.id,
        required this.minLat,
        required this.maxLat,
        required this.minLng,
        required this.maxLng,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Others.fromJson(Map<String, dynamic> json) => Others(
        id: json["_id"],
        minLat: json["minLat"]?.toDouble(),
        maxLat: json["maxLat"]?.toDouble(),
        minLng: json["minLng"]?.toDouble(),
        maxLng: json["maxLng"]?.toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "minLat": minLat,
        "maxLat": maxLat,
        "minLng": minLng,
        "maxLng": maxLng,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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