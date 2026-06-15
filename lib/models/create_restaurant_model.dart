// To parse this JSON data, do
//
//     final createRestaurant = createRestaurantFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateRestaurant createRestaurantFromJson(String str) =>
    CreateRestaurant.fromJson(json.decode(str));

String createRestaurantToJson(CreateRestaurant data) =>
    json.encode(data.toJson());

class CreateRestaurant {
  final String title;
  final String userId;
  final String imageUrl;
  final String logoUrl;
  final String restaurantMail;
  final String phone;
  final String code;
  final String restaurantFcm;
  String? accountName;
  String? accountNumber;
  String? bank;
  final double latitude;
  final double longitude;
  final String address;
  final String addressTitle;
  final double latitudeDelta;
  final double longitudeDelta;

  CreateRestaurant(
      {required this.title,
      required this.userId,
      required this.imageUrl,
      required this.logoUrl,
      required this.restaurantMail,
      required this.phone,
      required this.code,
      required this.restaurantFcm,
      this.accountName,
      this.accountNumber,
      this.bank,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.addressTitle,
      required this.latitudeDelta,
      required this.longitudeDelta});

  factory CreateRestaurant.fromJson(Map<String, dynamic> json) =>
      CreateRestaurant(
        title: json["title"],
        userId: json["userId"],
        imageUrl: json["imageUrl"],
        logoUrl: json["logoUrl"],
        restaurantMail: json["restaurantMail"],
        phone: json["phone"],
        code: json["code"],
        restaurantFcm: json["restaurantFcm"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bank: json["bank"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        addressTitle: json["addressTitle"],
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "userId": userId,
        "imageUrl": imageUrl,
        "logoUrl": logoUrl,
        "restaurantMail": restaurantMail,
        "phone": phone,
        "code": code,
        "restaurantFcm": restaurantFcm,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bank": bank,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "addressTitle": addressTitle,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
      };
}

// class Cordinates {
//     final String id;
    

//     Cordinates({
//         required this.id,
//         required this.latitude,
//         required this.longitude,
//         required this.address,
//         required this.title,
//         required this.latitudeDelta,
//         required this.longitudeDelta,
//     });

//     factory Cordinates.fromJson(Map<String, dynamic> json) => Cordinates(
//         id: json["id"],
//         latitude: json["latitude"]?.toDouble(),
//         longitude: json["longitude"]?.toDouble(),
//         address: json["address"],
//         title: json["title"],
//         latitudeDelta: json["latitudeDelta"]?.toDouble(),
//         longitudeDelta: json["longitudeDelta"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "latitude": latitude,
//         "longitude": longitude,
//         "address": address,
//         "title": title,
//         "latitudeDelta": latitudeDelta,
//         "longitudeDelta": longitudeDelta,
//     };
// }
