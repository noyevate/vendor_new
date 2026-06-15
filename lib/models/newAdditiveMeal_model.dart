// To parse this JSON data, do
//
//     final newAdditiveMealPage = newAdditiveMealPageFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

NewAdditiveMealPage newAdditiveMealPageFromJson(String str) => NewAdditiveMealPage.fromJson(json.decode(str));

String newAdditiveMealPageToJson(NewAdditiveMealPage data) => json.encode(data.toJson());

class NewAdditiveMealPage {
    final bool status;
    final String message;
    final String restaurantId;
    final String additiveTitle;
    final List<NewAdditiveOptions> options;
    final int max;
    final int min;
    final bool isAvailable;
    final String id;
    final int v;

    NewAdditiveMealPage({
        required this.status,
        required this.message,
        required this.restaurantId,
        required this.additiveTitle,
        required this.options,
        required this.max,
        required this.min,
        required this.isAvailable,
        required this.id,
        required this.v,
    });

    factory NewAdditiveMealPage.fromJson(Map<String, dynamic> json) => NewAdditiveMealPage(
        status: json["status"],
        message: json["message"],
        restaurantId: json["restaurantId"],
        additiveTitle: json["additiveTitle"],
        options: List<NewAdditiveOptions>.from(json["options"].map((x) => NewAdditiveOptions.fromJson(x))),
        max: json["max"],
        min: json["min"],
        isAvailable: json["isAvailable"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "restaurantId": restaurantId,
        "additiveTitle": additiveTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "max": max,
        "min": min,
        "isAvailable": isAvailable,
        "_id": id,
        "__v": v,
    };
}

class NewAdditiveOptions {
    final String id;
    final String additiveName;
    final int price;
    final bool isAvailable;

    NewAdditiveOptions({
        required this.id,
        required this.additiveName,
        required this.price,
        required this.isAvailable,
    });

    factory NewAdditiveOptions.fromJson(Map<String, dynamic> json) => NewAdditiveOptions(
        id: json["id"],
        additiveName: json["additiveName"],
        price: json["price"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "additiveName": additiveName,
        "price": price,
        "isAvailable": isAvailable,
    };
}
