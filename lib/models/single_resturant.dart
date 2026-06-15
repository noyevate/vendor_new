// To parse this JSON data, do
//
//     final singleRestaurant = singleRestaurantFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleRestaurant singleRestaurantFromJson(String str) =>
    SingleRestaurant.fromJson(json.decode(str));

String singleRestaurantToJson(SingleRestaurant data) =>
    json.encode(data.toJson());

class SingleRestaurant {
  final Coords coords;
  final String id;
  final String title;
  final List<dynamic> time;
  final String imageUrl;
  final List<dynamic> foods;
  final bool pickup;
  final String restaurantFcm;
  final String restaurantMail;
  final bool delivery;
  final bool isAvailabe;
  final String phone;
  final String code;
  final String accountName;
  final String accountNumber;
  final String bank;
  final String logoUrl;
  final String userId;
  final int rating;
  final String ratingCount;
  final String verification;
  final String verificationMessage;
  List<dynamic>? restaurantCategories;
  final DateTime createdAt;
  final DateTime updatedAt;

  SingleRestaurant({
    required this.coords,
    required this.id,
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.foods,
    required this.pickup,
    required this.restaurantFcm,
    required this.restaurantMail,
    required this.delivery,
    required this.isAvailabe,
    required this.phone,
    required this.code,
    required this.accountName,
    required this.accountNumber,
    required this.bank,
    required this.logoUrl,
    required this.userId,
    required this.rating,
    required this.ratingCount,
    required this.verification,
    required this.verificationMessage,
    this.restaurantCategories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SingleRestaurant.fromJson(Map<String, dynamic> json) =>
      SingleRestaurant(
        coords: Coords.fromJson(json["coords"]),
        id: json["_id"],
        title: json["title"],
        time: List<dynamic>.from(json["time"].map((x) => x)),
        imageUrl: json["imageUrl"],
        foods: List<dynamic>.from(json["foods"].map((x) => x)),
        pickup: json["pickup"],
        restaurantFcm: json["restaurantFcm"],
        restaurantMail: json["restaurantMail"],
        delivery: json["delivery"],
        isAvailabe: json["isAvailabe"],
        phone: json["phone"],
        code: json["code"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bank: json["bank"],
        logoUrl: json["logoUrl"],
        userId: json["userId"],
        rating: json["rating"],
        ratingCount: json["ratingCount"],
        verification: json["verification"],
        verificationMessage: json["verificationMessage"],
        restaurantCategories:
            List<dynamic>.from(json["restaurant_categories"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "coords": coords.toJson(),
        "_id": id,
        "title": title,
        "time": List<dynamic>.from(time.map((x) => x)),
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x)),
        "pickup": pickup,
        "restaurantFcm": restaurantFcm,
        "restaurantMail": restaurantMail,
        "delivery": delivery,
        "isAvailabe": isAvailabe,
        "phone": phone,
        "code": code,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bank": bank,
        "logoUrl": logoUrl,
        "userId": userId,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verification,
        "restaurant_categories": List<dynamic>.from(
          restaurantCategories?.map((x) => x) ?? [],
        ),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Coords {
  final String id;
  final double latitude;
  final double longitude;
  final double latitudeDelta;
  final double longitudeDelta;
  final String address;
  final String title;

  Coords({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.latitudeDelta,
    required this.longitudeDelta,
    required this.address,
    required this.title,
  });

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
        address: json["address"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
        "address": address,
        "title": title,
      };
}
