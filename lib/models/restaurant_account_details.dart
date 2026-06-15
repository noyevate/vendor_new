// To parse this JSON data, do
//
//     final restaurantAccountDetails = restaurantAccountDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RestaurantAccountDetails restaurantAccountDetailsFromJson(String str) =>
    RestaurantAccountDetails.fromJson(json.decode(str));

String restaurantAccountDetailsToJson(RestaurantAccountDetails data) =>
    json.encode(data.toJson());

class RestaurantAccountDetails {
  // String? restaurantId;
  final String accountName;
  final String accountNumber;
  final String bank;

  RestaurantAccountDetails({
    // this.restaurantId,
    required this.accountName,
    required this.accountNumber,
    required this.bank,
  });

  factory RestaurantAccountDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantAccountDetails(
        // restaurantId: json["restaurantId"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bank: json["bank"],
      );

  Map<String, dynamic> toJson() => {
        // "restaurantId": restaurantId,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bank": bank,
      };
}
