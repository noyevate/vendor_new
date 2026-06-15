// To parse this JSON data, do
//
//     final fetchAdditiveModel = fetchAdditiveModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FetchPackModel> fetchPackModelFromJson(String str) =>
    List<FetchPackModel>.from(
        json.decode(str).map((x) => FetchPackModel.fromJson(x)));

String fetchPackModelToJson(List<FetchPackModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    int safeIntParse(dynamic value) {
  if(value == null) return 0;
  if(value is int) return value;
  if(value is double) return value.toInt();
  if(value is String) {
    return int.tryParse(value.split('.').first) ?? 0;
  }
  return 0;

}

class FetchPackModel {
  final String id;
  final String restaurantId;
  final String packName;
  final String packDescription;
  final int price;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  FetchPackModel({
    required this.id,
    required this.restaurantId,
    required this.packName,
    required this.packDescription,
    required this.price,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FetchPackModel.fromJson(Map<String, dynamic> json) =>
      FetchPackModel(
        id: json["id"],
        restaurantId: json["restaurantId"],
        packName: json["packName"],
        packDescription: json["packDescription"],
        price: safeIntParse(json["price"]) ,
        isAvailable: json["isAvailable"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantId": restaurantId,
        "packName": packName,
        "packDescription": packDescription,
        "price": price,
        "isAvailable": isAvailable,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

