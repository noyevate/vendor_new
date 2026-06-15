// To parse this JSON data, do
//
//     final additiveFoodModel = additiveFoodModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AdditiveFoodModel> additiveFoodModelFromJson(String str) => List<AdditiveFoodModel>.from(json.decode(str).map((x) => AdditiveFoodModel.fromJson(x)));

String additiveFoodModelToJson(List<AdditiveFoodModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdditiveFoodModel {
    final String id;
    final String title;
    final int price;
    final String category;

    AdditiveFoodModel({
        required this.id,
        required this.title,
        required this.price,
        required this.category,
    });

    factory AdditiveFoodModel.fromJson(Map<String, dynamic> json) => AdditiveFoodModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "category": category,
    };
}
