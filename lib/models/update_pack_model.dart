// To parse this JSON data, do
//
//     final updateAdditiveOptionModel = updateAdditiveOptionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdatePackModel updatePackModelFromJson(String str) => UpdatePackModel.fromJson(json.decode(str));

String updatePackModelToJson(UpdatePackModel data) => json.encode(data.toJson());

class UpdatePackModel {
  
  final String packName;
  final String packDescription;
  final int price;
  final bool isAvailable;
 

  UpdatePackModel({
    
    required this.packName,
    required this.packDescription,
    required this.price,
    required this.isAvailable,
    
  });

  // Factory constructor to create a Pack instance from JSON
  factory UpdatePackModel.fromJson(Map<String, dynamic> json) {
    return UpdatePackModel(
      
      packName: json['packName'],
      packDescription: json['packDescription'],
      price: json['price'], // Convert to double in case of null
      isAvailable: json['isAvailable'],
      
    );
  }

  // Method to convert a Pack instance to JSON
  Map<String, dynamic> toJson() {
    return {
      
      'packName': packName,
      'packDescription': packDescription,
      'price': price,
      'isAvailable': isAvailable,

    };
  }
}

