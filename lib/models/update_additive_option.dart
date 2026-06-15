// To parse this JSON data, do
//
//     final updateAdditiveOptionModel = updateAdditiveOptionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateAdditiveOptionModel updateAdditiveOptionModelFromJson(String str) => UpdateAdditiveOptionModel.fromJson(json.decode(str));

String updateAdditiveOptionModelToJson(UpdateAdditiveOptionModel data) => json.encode(data.toJson());

class UpdateAdditiveOptionModel {
    final String name;
    final int price;
    final bool isAvailable;

    UpdateAdditiveOptionModel({
        required this.name,
        required this.price,
        required this.isAvailable
    });

    factory UpdateAdditiveOptionModel.fromJson(Map<String, dynamic> json) => UpdateAdditiveOptionModel(
        name: json["name"],
        price: json["price"],
        isAvailable: json["isAvailable"]
        
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "isAvailable": isAvailable
    };
}
