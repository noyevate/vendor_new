// To parse this JSON data, do
//
//     final fetchFoodModel = fetchFoodModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FetchFoodModel> fetchFoodModelFromJson(String str) => List<FetchFoodModel>.from(json.decode(str).map((x) => FetchFoodModel.fromJson(x)));

String fetchFoodModelToJson(List<FetchFoodModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchFoodModel {
    final String id;
    final String title;
    final String time;
    final List<String> foodTags;
    final String category;
    final List<String> foodType;
    final String code;
    final bool isAvailable;
    final String restaurant;
    final double rating;
    final String ratingCount;
    final String description;
    final int price;
    final String priceDescription;
    final List<FetchedAdditive> additive;
    final List<FetchedPack> pack;
    final List<String> imageUrl;
    final String restaurantCategory;
    final bool restaurantCategoryAvailable;
    final DateTime createdAt;
    final DateTime updatedAt;
    

    FetchFoodModel({
        required this.id,
        required this.title,
        required this.time,
        required this.foodTags,
        required this.category,
        required this.foodType,
        required this.code,
        required this.isAvailable,
        required this.restaurant,
        required this.rating,
        required this.ratingCount,
        required this.description,
        required this.price,
        required this.priceDescription,
        required this.additive,
        required this.pack,
        required this.imageUrl,
        required this.restaurantCategory,
        required this.restaurantCategoryAvailable,
        required this.createdAt,
        required this.updatedAt,
        
    });

    factory FetchFoodModel.fromJson(Map<String, dynamic> json) => FetchFoodModel(
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        category: json["category"],
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        code: json["code"],
        isAvailable: json["isAvailable"],
        restaurant: json["restaurant"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        description: json["description"],
        price: json["price"],
        priceDescription: json["priceDescription"],
        additive: List<FetchedAdditive>.from(json["additive"].map((x) => FetchedAdditive.fromJson(x))),
        pack: List<FetchedPack>.from(json["pack"].map((x) => FetchedPack.fromJson(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        restaurantCategory: json["restaurant_category"],
        restaurantCategoryAvailable: json["restaurantCategoryAvailable"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
       
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": time,
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
        "category": category,
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        "code": code,
        "isAvailable": isAvailable,
        "restaurant": restaurant,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        "priceDescription": priceDescription,
        "additive": List<dynamic>.from(additive.map((x) => x.toJson())),
        "pack": List<dynamic>.from(pack.map((x) => x.toJson())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "restaurantCategoryAvailable": restaurantCategoryAvailable,
        "restaurant_category": restaurantCategory,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
       
    };
}

class FetchedAdditive {
    final String restaurantId;
    final String additiveTitle;
    final List<FetchedAdditiveOption> options;
    final int max;
    final int min;
    final bool isAvailable;

    FetchedAdditive({
        required this.restaurantId,
        required this.additiveTitle,
        required this.options,
        required this.max,
        required this.min,
        required this.isAvailable,
    });

    factory FetchedAdditive.fromJson(Map<String, dynamic> json) => FetchedAdditive(
        restaurantId: json["restaurantId"],
        additiveTitle: json["additiveTitle"],
        options: List<FetchedAdditiveOption>.from(json["options"].map((x) => FetchedAdditiveOption.fromJson(x))),
        max: json["max"],
        min: json["min"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "additiveTitle": additiveTitle,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "max": max,
        "min": min,
        "isAvailable": isAvailable,
    };
}

class FetchedAdditiveOption {
    final String id;
    final String additiveName;
    final int price;
    final bool isAvailable;

    FetchedAdditiveOption({
        required this.id,
        required this.additiveName,
        required this.price,
        required this.isAvailable,
    });

    factory FetchedAdditiveOption.fromJson(Map<String, dynamic> json) => FetchedAdditiveOption(
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

class FetchedPack {
    final String restaurantId;
    final String packName;
    final String packDescription;
    final int price;
    final bool isAvailable;

    FetchedPack({
        required this.restaurantId,
        required this.packName,
        required this.packDescription,
        required this.price,
        required this.isAvailable,
    });

    factory FetchedPack.fromJson(Map<String, dynamic> json) => FetchedPack(
        restaurantId: json["restaurantId"],
        packName: json["packName"],
        packDescription: json["packDescription"],
        price: json["price"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "packName": packName,
        "packDescription": packDescription,
        "price": price,
        "isAvailable": isAvailable,
    };
}
