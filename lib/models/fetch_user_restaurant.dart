// To parse this JSON data, do
//
//     final fetchUserRestaurantModel = fetchUserRestaurantModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FetchUserRestaurantModel fetchUserRestaurantModelFromJson(String str) => FetchUserRestaurantModel.fromJson(json.decode(str));

String fetchUserRestaurantModelToJson(FetchUserRestaurantModel data) => json.encode(data.toJson());

class FetchUserRestaurantModel {
    final Coords coords;
    final String id;
    final String title;
    final List<Time> time;
    final String imageUrl;
    final List<String> foods;
    final bool pickup;
    final String restaurantMail;
    final bool delivery;
    final bool isAvailabe;
    final String phone;
    final String code;
    final String logoUrl;
    final String userId;
    final double rating;
    final String ratingCount;
    final String verification;
    final String verificationMessage;
    final List<dynamic> restaurantCategories;
    final DateTime createdAt;
    final DateTime updatedAt;

    FetchUserRestaurantModel({
        required this.coords,
        required this.id,
        required this.title,
        required this.time,
        required this.imageUrl,
        required this.foods,
        required this.pickup,
        required this.restaurantMail,
        required this.delivery,
        required this.isAvailabe,
        required this.phone,
        required this.code,
        required this.logoUrl,
        required this.userId,
        required this.rating,
        required this.ratingCount,
        required this.verification,
        required this.verificationMessage,
        required this.restaurantCategories,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FetchUserRestaurantModel.fromJson(Map<String, dynamic> json) => FetchUserRestaurantModel(
        coords: Coords.fromJson(json["coords"]),
        id: json["_id"],
        title: json["title"],
        time: List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
        imageUrl: json["imageUrl"],
        foods: List<String>.from(json["foods"].map((x) => x)),
        pickup: json["pickup"],
        restaurantMail: json["restaurantMail"],
        delivery: json["delivery"],
        isAvailabe: json["isAvailabe"],
        phone: json["phone"],
        code: json["code"],
        logoUrl: json["logoUrl"],
        userId: json["userId"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        verification: json["verification"],
        verificationMessage: json["verificationMessage"],
        restaurantCategories: List<dynamic>.from(json["restaurant_categories"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "coords": coords.toJson(),
        "_id": id,
        "title": title,
        "time": List<dynamic>.from(time.map((x) => x.toJson())),
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x)),
        "pickup": pickup,
        "restaurantMail": restaurantMail,
        "delivery": delivery,
        "isAvailabe": isAvailabe,
        "phone": phone,
        "code": code,
        "logoUrl": logoUrl,
        "userId": userId,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verification,
        "verificationMessage": verificationMessage,
        "restaurant_categories": List<dynamic>.from(restaurantCategories.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Coords {
    final String id;
    final double latitude;
    final double longitude;
    final String address;
    final String title;
    final double latitudeDelta;
    final double longitudeDelta;

    Coords({
        required this.id,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.title,
        required this.latitudeDelta,
        required this.longitudeDelta,
    });

    factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
    };
}

class Time {
  final String orderType;
  final String day;
  final String open;
  final String close;
  final String? orderCutOffTime; // Nullable for Instant delivery
  final String? menuReadyTime; // Nullable for Instant delivery

  Time({
    required this.orderType,
    required this.day,
    required this.open,
    required this.close,
    this.orderCutOffTime,
    this.menuReadyTime,
  }) {
    // Validation logic for orderType
    if (orderType != 'Pre-order' && orderType != 'Instant delivery') {
      throw ArgumentError('Invalid orderType: must be "Pre-order" or "Instant delivery".');
    }

    // Additional checks based on orderType
    if (orderType == 'Pre-order' && (orderCutOffTime == null || menuReadyTime == null)) {
      throw ArgumentError('Pre-order requires orderCutOffTime and menuReadyTime.');
    }

    if (orderType == 'Instant delivery' && (orderCutOffTime != null || menuReadyTime != null)) {
      throw ArgumentError('Instant delivery should not have orderCutOffTime or menuReadyTime.');
    }
  }

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      orderType: json["orderType"],
      day: json["day"],
      open: json["open"],
      close: json["close"],
      orderCutOffTime: json["orderCutOffTime"],
      menuReadyTime: json["menuReadyTime"],
    );
  }

  Map<String, dynamic> toJson() => {
        "orderType": orderType,
        "day": day,
        "open": open,
        "close": close,
        "orderCutOffTime": orderCutOffTime,
        "menuReadyTime": menuReadyTime,
      };
}



