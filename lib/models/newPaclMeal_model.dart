// To parse this JSON data, do
//
//     final newPackMealPage = newPackMealPageFromJson(jsonString);

// ignore_for_file: file_names

import 'package:meta/meta.dart';
import 'dart:convert';

NewPackMealPage newPackMealPageFromJson(String str) => NewPackMealPage.fromJson(json.decode(str));

String newPackMealPageToJson(NewPackMealPage data) => json.encode(data.toJson());

class NewPackMealPage {
    final bool status;
    final String message;
    final String restaurantId;
    final String packName;
    final String packDescription;
    final int price;
    final bool isAvailable;
    final String id;
    final int v;

    NewPackMealPage({
        required this.status,
        required this.message,
        required this.restaurantId,
        required this.packName,
        required this.packDescription,
        required this.price,
        required this.isAvailable,
        required this.id,
        required this.v,
    });

    factory NewPackMealPage.fromJson(Map<String, dynamic> json) => NewPackMealPage(
        status: json["status"],
        message: json["message"],
        restaurantId: json["restaurantId"],
        packName: json["packName"],
        packDescription: json["packDescription"],
        price: json["price"],
        isAvailable: json["isAvailable"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "restaurantId": restaurantId,
        "packName": packName,
        "packDescription": packDescription,
        "price": price,
        "isAvailable": isAvailable,
        "_id": id,
        "__v": v,
    };
}
