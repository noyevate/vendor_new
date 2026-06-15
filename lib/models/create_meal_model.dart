// To parse this JSON data, do
//
//     final createFoodModel = createFoodModelFromJson(jsonString);ßß

import 'package:meta/meta.dart';
import 'dart:convert';

CreateFoodModel createFoodModelFromJson(String str) =>
    CreateFoodModel.fromJson(json.decode(str));

String createFoodModelToJson(CreateFoodModel data) =>
    json.encode(data.toJson());

class CreateFoodModel {
  final String title;
  final String time;
  final List<String> foodTags;
  final String categoryId;
  final List<String> foodType;
  final String code;
  final bool isAvailable;
  final String restaurantId;
  final double rating;
  final String ratingCount;
  final String description;
  final int price;
  final String priceDescription;
  final List<MealAdditive> additive;
  final List<MealPack> pack;
  final List<String> imageUrl;
  final String restaurantCategory;

  CreateFoodModel({
    required this.title,
    required this.time,
    required this.foodTags,
    required this.categoryId,
    required this.foodType,
    required this.code,
    required this.isAvailable,
    required this.restaurantId,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.price,
    required this.priceDescription,
    required this.additive,
    required this.pack,
    required this.imageUrl,
    required this.restaurantCategory,
  });

  factory CreateFoodModel.fromJson(Map<String, dynamic> json) =>
      CreateFoodModel(
        title: json["title"],
        time: json["time"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        categoryId: json["categoryId"],
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        code: json["code"],
        isAvailable: json["isAvailable"],
        restaurantId: json["restaurantId"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        description: json["description"],
        price: json["price"],
        priceDescription: json["priceDescription"],
        additive: List<MealAdditive>.from(
            json["additive"].map((x) => MealAdditive.fromJson(x))),
        pack:
            List<MealPack>.from(json["pack"].map((x) => MealPack.fromJson(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        restaurantCategory: json["restaurant_category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "time": time,
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
        "categoryId": categoryId,
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        "code": code,
        "isAvailable": isAvailable,
        "restaurantId": restaurantId,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        "priceDescription": priceDescription,
        "additive": List<dynamic>.from(additive.map((x) => x.toJson())),
        "pack": List<dynamic>.from(pack.map((x) => x.toJson())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "restaurant_category": restaurantCategory,
      };
}

class MealAdditive {
  final String id;
  final String restaurantId;
  final String additiveTitle;
  final List<MealAdditiveOption> options;
  final int max;
  final int min;
  final bool isAvailable;

  MealAdditive({
    required this.id,
    required this.restaurantId,
    required this.additiveTitle,
    required this.options,
    required this.max,
    required this.min,
    required this.isAvailable,
  });

  factory MealAdditive.fromJson(Map<String, dynamic> json) => MealAdditive(
        id: json["id"],
        restaurantId: json["restaurantId"],
        additiveTitle: json["additiveTitle"],
        options: List<MealAdditiveOption>.from(
            json["options"].map((x) => MealAdditiveOption.fromJson(x))),
        max: json["max"],
        min: json["min"],
        isAvailable: json["isAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantId": restaurantId,
        "additiveTitle": additiveTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "max": max,
        "min": min,
        "isAvailable": isAvailable,
      };
}

class MealAdditiveOption {
  final String id;
  final String additiveName;
  final int price;
  final bool isAvailable;

  MealAdditiveOption({
    required this.id,
    required this.additiveName,
    required this.price,
    required this.isAvailable,
  });

  factory MealAdditiveOption.fromJson(Map<String, dynamic> json) =>
      MealAdditiveOption(
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

class MealPack {
  final String restaurantId;
  final String id;
  final String packName;
  final String packDescription;
  final int price;
  final bool isAvailable;

  MealPack({
    required this.restaurantId,
    required this.id,
    required this.packName,
    required this.packDescription,
    required this.price,
    required this.isAvailable,
  });

  factory MealPack.fromJson(Map<String, dynamic> json) => MealPack(
        restaurantId: json["restaurantId"],
        id: json["id"],
        packName: json["packName"],
        packDescription: json["packDescription"],
        price: json["price"],
        isAvailable: json["isAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "id": id,
        "packName": packName,
        "packDescription": packDescription,
        "price": price,
        "isAvailable": isAvailable,
      };
}
