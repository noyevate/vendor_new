// To parse this JSON data, do
//
//     final fetchAdditiveModel = fetchAdditiveModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FetchAdditiveModel> fetchAdditiveModelFromJson(String str) => List<FetchAdditiveModel>.from(json.decode(str).map((x) => FetchAdditiveModel.fromJson(x)));

String fetchAdditiveModelToJson(List<FetchAdditiveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchAdditiveModel {
    final String id;
    final String restaurantId;
    final String additiveTitle;
    final List<Option> options;
    final int max;
    final int min;
    final bool isAvailable;
    final DateTime createdAt;
    final DateTime updatedAt;

    FetchAdditiveModel({
        required this.id,
        required this.restaurantId,
        required this.additiveTitle,
        required this.options,
        required this.max,
        required this.min,
        required this.isAvailable,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FetchAdditiveModel.fromJson(Map<String, dynamic> json) => FetchAdditiveModel(
        id: json["id"],
        restaurantId: json["restaurantId"],
        additiveTitle: json["additiveTitle"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        max: json["max"],
        min: json["min"],
        isAvailable: json["isAvailable"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantId": restaurantId,
        "additiveTitle": additiveTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "max": max,
        "min": min,
        "isAvailable": isAvailable,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Option {
    final String additiveName;
    final int price;
    final bool isAvailable;
    final String id;

    Option({
        required this.additiveName,
        required this.price,
        required this.isAvailable,
        required this.id,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        additiveName: json["additiveName"],
        price: json["price"],
        isAvailable: json["isAvailable"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "additiveName": additiveName,
        "price": price,
        "isAvailable": isAvailable,
        "id": id,
    };
}
