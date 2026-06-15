// To parse this JSON data, do
//
//     final additiveModel = additiveModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AdditiveModel> additiveModelFromJson(String str) => List<AdditiveModel>.from(json.decode(str).map((x) => AdditiveModel.fromJson(x)));

String additiveModelToJson(List<AdditiveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdditiveModel {
    final int id;
    final String title;
    final List<Option> options;

    AdditiveModel({
        required this.id,
        required this.title,
        required this.options,
    });

    factory AdditiveModel.fromJson(Map<String, dynamic> json) => AdditiveModel(
        id: json["id"],
        title: json["title"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
    };
}

class Option {
    final String name;
    final int price;

    Option({
        required this.name,
        required this.price,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
    };
}
