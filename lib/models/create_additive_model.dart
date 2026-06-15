

// CreateAdditiveModel createAdditiveModelFromJson(String str) => CreateAdditiveModel.fromJson(json.decode(str));

// String createAdditiveModelToJson(CreateAdditiveModel data) => json.encode(data.toJson());

// class CreateAdditiveModel {
//   final String restaurantId;
//   final String additiveTitle;
//   final String additiveName;
//   final int max;
//   final int min;
//   final int price;
//   final List<AdditiveModel> foods;  // Store AdditiveModel objects
//   final bool isAvailable;

//   CreateAdditiveModel({
//     required this.restaurantId,
//     required this.additiveTitle,
//     required this.additiveName,
//     required this.max,
//     required this.min,
//     required this.price,
//     required this.foods,
//     required this.isAvailable,
//   });

//   // Factory method to create an instance from JSON
//   factory CreateAdditiveModel.fromJson(Map<String, dynamic> json) => CreateAdditiveModel(
//     restaurantId: json["restaurantId"],
//     additiveTitle: json["additiveTitle"],
//     additiveName: json["additiveName"],
//     max: json["max"],
//     min: json["min"],
//     price: json["price"],
//     foods: List<AdditiveModel>.from(json["foods"].map((x) => AdditiveModel.fromJson(x))),  // Handle AdditiveModel list
//     isAvailable: json["isAvailable"],
//   );

// //   // Method to serialize instance to JSON
// //   Map<String, dynamic> toJson() => {
// //     "restaurantId": restaurantId,
// //     "additiveTitle": additiveTitle,
// //     "additiveName": additiveName,
// //     "max": max,
// //     "min": min,
// //     "price": price,
// //     // Convert AdditiveModel to include more fields like id, title, price, etc.
// //     "foods": List<dynamic>.from(foods.map((food) => {
// //       "id": food.id,
// //       "title": food.title,    // Additional fields
// //       "price": food.options.,
// //       "category": food.category,
// //       "isAvailable": food.isAvailable
      
// //     })),
// //     "isAvailable": isAvailable,
// //   };
// // }



// // Option class to represent individual additive names and prices
// class Option {
//   final String additiveName;  // Additive name
//   final int price;            // Price of the additive

//   Option({
//     required this.additiveName,
//     required this.price,
//   });

//   // Factory method to create an Option instance from JSON
//   factory Option.fromJson(Map<String, dynamic> json) => Option(
//         additiveName: json["additiveName"],
//         price: json["price"],
//       );

//   // Method to serialize Option instance to JSON
//   Map<String, dynamic> toJson() => {
//         "additiveName": additiveName,
//         "price": price,
//       };
// }

// // Updated CreateAdditiveModel to use the list of Option objects
// class CreateAdditiveModel {
//   final String restaurantId;
//   final String additiveTitle;
//   final int max;
//   final int min;
//   final List<Option> options;  // Store a list of Option objects (additive names and prices)
//   final bool isAvailable;

//   CreateAdditiveModel({
//     required this.restaurantId,
//     required this.additiveTitle,
//     required this.max,
//     required this.min,
//     required this.options,      // Updated to hold a list of options
//     required this.isAvailable,
//   });

//   // Factory method to create an instance from JSON
//   factory CreateAdditiveModel.fromJson(Map<String, dynamic> json) => CreateAdditiveModel(
//         restaurantId: json["restaurantId"],
//         additiveTitle: json["additiveTitle"],
//         max: json["max"],
//         min: json["min"],
//         options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),  // Map JSON list to Option objects
//         isAvailable: json["isAvailable"],
//       );

//   // Method to serialize CreateAdditiveModel instance to JSON
//   Map<String, dynamic> toJson() => {
//         "restaurantId": restaurantId,
//         "additiveTitle": additiveTitle,
//         "max": max,
//         "min": min,
//         "options": List<dynamic>.from(options.map((option) => option.toJson())),  // Convert Option list to JSON
//         "isAvailable": isAvailable,
//       };
// }

// // JSON serialization functions for CreateAdditiveModel
// CreateAdditiveModel createAdditiveModelFromJson(String str) =>
//     CreateAdditiveModel.fromJson(json.decode(str));

// String createAdditiveModelToJson(CreateAdditiveModel data) =>
//     json.encode(data.toJson());


// To parse this JSON data, do
//
//     final createAdditiveModel = createAdditiveModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateAdditiveModel createAdditiveModelFromJson(String str) => CreateAdditiveModel.fromJson(json.decode(str));

String createAdditiveModelToJson(CreateAdditiveModel data) => json.encode(data.toJson());

class CreateAdditiveModel {
    final String restaurantId;
    final String additiveTitle;
    final List<AdditiveOption> options;
    final int max;
    final int min;
    final bool isAvailable;

    CreateAdditiveModel({
        required this.restaurantId,
        required this.additiveTitle,
        required this.options,
        required this.max,
        required this.min,
        required this.isAvailable,
    });

    factory CreateAdditiveModel.fromJson(Map<String, dynamic> json) => CreateAdditiveModel(
        restaurantId: json["restaurantId"],
        additiveTitle: json["additiveTitle"],
        options: List<AdditiveOption>.from(json["options"].map((x) => AdditiveOption.fromJson(x))),
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

class AdditiveOption {
    final String id;
    final String additiveName;
    final int price;
    final bool isAvailable;


    AdditiveOption({
        required this.id,
        required this.additiveName,
        required this.price,
        required this.isAvailable,
    });

    factory AdditiveOption.fromJson(Map<String, dynamic> json) => AdditiveOption(
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
