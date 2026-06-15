// To parse this JSON data, do
//
//     final updateAdditiveOptionModel = updateAdditiveOptionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PackModel packModelFromJson(String str) => PackModel.fromJson(json.decode(str));

String packModelToJson(PackModel data) => json.encode(data.toJson());

class PackModel {
  
  final String restaurantId;
  final String packName;
  final String packDescription;
  final int price;
  final bool isAvailable;
 

  PackModel({
    
    required this.restaurantId,
    required this.packName,
    required this.packDescription,
    required this.price,
    required this.isAvailable,
    
  });

  // Factory constructor to create a Pack instance from JSON
  factory PackModel.fromJson(Map<String, dynamic> json) {
    return PackModel(
      
      restaurantId: json['restaurantId'],
      packName: json['packName'],
      packDescription: json['packDescription'],
      price: json['price'], // Convert to double in case of null
      isAvailable: json['isAvailable'] ?? true,
      
    );
  }

  // Method to convert a Pack instance to JSON
  Map<String, dynamic> toJson() {
    return {
      
      'restaurantId': restaurantId,
      'packName': packName,
      'packDescription': packDescription,
      'price': price,
      'isAvailable': isAvailable,

    };
  }
}

