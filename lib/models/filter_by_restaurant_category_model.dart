// // To parse this JSON data, do
// //
// //     final restaurantCategoryModel = restaurantCategoryModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// List<RestaurantCategoryModel> restaurantCategoryModelFromJson(String str) => List<RestaurantCategoryModel>.from(json.decode(str).map((x) => RestaurantCategoryModel.fromJson(x)));

// String restaurantCategoryModelToJson(List<RestaurantCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class RestaurantCategoryModel {
//     final List<Item> items;
//     final String restaurantCategory;
//     final bool restaurantCategoryAvailable;

//     RestaurantCategoryModel({
//         required this.items,
//         required this.restaurantCategory,
//         required this.restaurantCategoryAvailable,
//     });

//     factory RestaurantCategoryModel.fromJson(Map<String, dynamic> json) => RestaurantCategoryModel(
//         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//         restaurantCategory: json["restaurant_category"],
//         restaurantCategoryAvailable: json["restaurantCategoryAvailable"],
//     );

//     Map<String, dynamic> toJson() => {
//         "items": List<dynamic>.from(items.map((x) => x.toJson())),
//         "restaurant_category": restaurantCategory,
//         "restaurantCategoryAvailable": restaurantCategoryAvailable,
//     };
// }

// class Item {
//     final String id;
//     final String title;
//     final String time;
//     final List<String> foodTags;
//     final String category;
//     final List<String> foodType;
//     final String code;
//     final bool isAvailable;
//     final String restaurant;
//     final double rating;
//     final String ratingCount;
//     final String description;
//     final int price;
//     final String priceDescription;
//     final List<Additive> additive;
//     final List<Pack> pack;
//     final List<String> imageUrl;

//     Item({
//         required this.id,
//         required this.title,
//         required this.time,
//         required this.foodTags,
//         required this.category,
//         required this.foodType,
//         required this.code,
//         required this.isAvailable,
//         required this.restaurant,
//         required this.rating,
//         required this.ratingCount,
//         required this.description,
//         required this.price,
//         required this.priceDescription,
//         required this.additive,
//         required this.pack,
//         required this.imageUrl,
//     });

//     factory Item.fromJson(Map<String, dynamic> json) => Item(
//         id: json["_id"],
//         title: json["title"],
//         time: json["time"],
//         foodTags: List<String>.from(json["foodTags"].map((x) => x)),
//         category: json["category"],
//         foodType: List<String>.from(json["foodType"].map((x) => x)),
//         code: json["code"],
//         isAvailable: json["isAvailable"],
//         restaurant: json["restaurant"],
//         rating: json["rating"],
//         ratingCount: json["ratingCount"],
//         description: json["description"],
//         price: json["price"],
//         priceDescription: json["priceDescription"],
//         additive: List<Additive>.from(json["additive"].map((x) => Additive.fromJson(x))),
//         pack: List<Pack>.from(json["pack"].map((x) => Pack.fromJson(x))),
//         imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "time": time,
//         "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
//         "category": category,
//         "foodType": List<dynamic>.from(foodType.map((x) => x)),
//         "code": code,
//         "isAvailable": isAvailable,
//         "restaurant": restaurant,
//         "rating": rating,
//         "ratingCount": ratingCount,
//         "description": description,
//         "price": price,
//         "priceDescription": priceDescription,
//         "additive": List<dynamic>.from(additive.map((x) => x.toJson())),
//         "pack": List<dynamic>.from(pack.map((x) => x.toJson())),
//         "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
//     };
// }

// class Additive {
//     final String restaurantId;
//     final String additiveTitle;
//     final List<Option> options;
//     final int max;
//     final int min;
//     final bool isAvailable;

//     Additive({
//         required this.restaurantId,
//         required this.additiveTitle,
//         required this.options,
//         required this.max,
//         required this.min,
//         required this.isAvailable,
//     });

//     factory Additive.fromJson(Map<String, dynamic> json) => Additive(
//         restaurantId: json["restaurantId"],
//         additiveTitle: json["additiveTitle"],
//         options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
//         max: json["max"],
//         min: json["min"],
//         isAvailable: json["isAvailable"],
//     );

//     Map<String, dynamic> toJson() => {
//         "restaurantId": restaurantId,
//         "additiveTitle": additiveTitle,
//         "options": List<dynamic>.from(options.map((x) => x.toJson())),
//         "max": max,
//         "min": min,
//         "isAvailable": isAvailable,
//     };
// }

// class Option {
//     final String id;
//     final String additiveName;
//     final int price;
//     final bool isAvailable;

//     Option({
//         required this.id,
//         required this.additiveName,
//         required this.price,
//         required this.isAvailable,
//     });

//     factory Option.fromJson(Map<String, dynamic> json) => Option(
//         id: json["id"],
//         additiveName: json["additiveName"],
//         price: json["price"],
//         isAvailable: json["isAvailable"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "additiveName": additiveName,
//         "price": price,
//         "isAvailable": isAvailable,
//     };
// }

// class Pack {
//     final String restaurantId;
//     final String packName;
//     final String packDescription;
//     final int price;
//     final bool isAvailable;

//     Pack({
//         required this.restaurantId,
//         required this.packName,
//         required this.packDescription,
//         required this.price,
//         required this.isAvailable,
//     });

//     factory Pack.fromJson(Map<String, dynamic> json) => Pack(
//         restaurantId: json["restaurantId"],
//         packName: json["packName"],
//         packDescription: json["packDescription"],
//         price: json["price"],
//         isAvailable: json["isAvailable"],
//     );

//     Map<String, dynamic> toJson() => {
//         "restaurantId": restaurantId,
//         "packName": packName,
//         "packDescription": packDescription,
//         "price": price,
//         "isAvailable": isAvailable,
//     };
// }



// models/restaurant_menu_model.dart

// Helper function to parse a JSON string containing a list of menu categories.
import 'dart:convert';




List<RestaurantCategoryModel> restaurantCategoryModelFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData is! List) {
    print("Error: Expected a List of menu categories but got something else.");
    return [];
  }
  
  final List<RestaurantCategoryModel> menuList = [];
  for (var menuJson in jsonData) {
    try {
      menuList.add(RestaurantCategoryModel.fromJson(menuJson));
    } catch (e, s) {
      print("=" * 50);
      print("ERROR: Failed to parse a single RestaurantMenu item.");
      print("Error Details: $e");
      print("Problematic JSON object: ${json.encode(menuJson)}");
      print("Stack Trace: $s");
      print("=" * 50);
    }
  }
  return menuList;
}

// Universal helper for safe boolean parsing.
bool _parseBool(dynamic value) {
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  if (value is int) return value == 1;
  return false;
}

int safeIntParse(dynamic value) {
  if(value == null) return 0;
  if(value is int) return value;
  if(value is double) return value.toInt();
  if(value is String) {
    return int.tryParse(value.split('.').first) ?? 0;
  }
  return 0;

}

class RestaurantCategoryModel {
    final String restaurantCategory;
    final bool restaurantCategoryAvailable;
    final List<Item> items;

    RestaurantCategoryModel({
        required this.restaurantCategory,
        required this.restaurantCategoryAvailable,
        required this.items,
    });

    factory RestaurantCategoryModel.fromJson(Map<String, dynamic> json) => RestaurantCategoryModel(
        restaurantCategory: json["restaurant_category"] ?? '',
        restaurantCategoryAvailable: _parseBool(json["restaurantCategoryAvailable"]),
        items: json["items"] == null ? [] : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );
}

class Item {
    final String id;
    final String title;
    final String time;
    final String code;
    final bool isAvailable;
    final double rating;
    final String ratingCount;
    final String description;
    final int price;
    final String? priceDescription;
    final String restaurantCategory;
    final bool restaurantCategoryAvailable;
    final List<String> foodTags;
    final List<String> foodType;
    final List<Additive> additive;
    final List<Pack> pack;
    final List<String> imageUrl;
    final String restaurantId;
    final String categoryId;
    final DateTime createdAt;
    final DateTime updatedAt;

    Item({
        required this.id, required this.title, required this.time, required this.code,
        required this.isAvailable, required this.rating, required this.ratingCount,
        required this.description, required this.price, this.priceDescription,
        required this.restaurantCategory, required this.restaurantCategoryAvailable,
        required this.foodTags, required this.foodType, required this.additive,
        required this.pack, required this.imageUrl, required this.restaurantId,
        required this.categoryId, required this.createdAt, required this.updatedAt,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        time: json["time"] ?? '',
        code: json["code"] ?? '',
        isAvailable: _parseBool(json["isAvailable"]),
        rating: double.tryParse(json["rating"]?.toString() ?? '0.0') ?? 0.0,
        ratingCount: json["ratingCount"] ?? '0',
        description: json["description"] ?? '',
        price: int.tryParse(json["price"]?.toString().split('.').first ?? '0') ?? 0,
        priceDescription: json["priceDescription"],
        restaurantCategory: json["restaurant_category"] ?? '',
        restaurantCategoryAvailable: _parseBool(json["restaurantCategoryAvailable"]),
        foodTags: json["foodTags"] == null ? [] : List<String>.from(json["foodTags"].map((x) => x)),
        foodType: json["foodType"] == null ? [] : List<String>.from(json["foodType"].map((x) => x)),
        additive: json["additive"] == null ? [] : List<Additive>.from(json["additive"].map((x) => Additive.fromJson(x))),
        pack: json["pack"] == null ? [] : List<Pack>.from(json["pack"].map((x) => Pack.fromJson(x))),
        imageUrl: json["imageUrl"] == null ? [] : List<String>.from(json["imageUrl"].map((x) => x)),
        restaurantId: json["restaurantId"] ?? '',
        categoryId: json["categoryId"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );
}


class Additive {
    final String id;
    final String additiveTitle;
    final List<Option> options;
    final int max;
    final int min;
    final bool isAvailable;

    Additive({
        required this.id,
        required this.additiveTitle,
        required this.options,
        required this.max,
        required this.min,
        required this.isAvailable,
    });

    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        id: json["id"] ?? '',
        additiveTitle: json["additiveTitle"] ?? '',
        options: json["options"] == null ? [] : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        max: json["max"] ?? 0,
        min: json["min"] ?? 0,
        isAvailable: _parseBool(json["isAvailable"]),
    );
}

class Option {
    final String id;
    final String additiveName;
    final int price;
    final bool isAvailable;

    Option({
        required this.id,
        required this.additiveName,
        required this.price,
        required this.isAvailable,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] ?? '',
        additiveName: json["additiveName"] ?? '',
        price: json["price"] ?? 0,
        isAvailable: _parseBool(json["isAvailable"]),
    );
}

class Pack {
    final String id;
    final int? price; // Price can be string or null
    final String packName;
    final bool isAvailable;
    final String restaurantId;
    final String packDescription;

    Pack({
        required this.id,
        this.price,
        required this.packName,
        required this.isAvailable,
        required this.restaurantId,
        required this.packDescription,
    });

    factory Pack.fromJson(Map<String, dynamic> json) => Pack(
        id: json["id"] ?? '',
        price: safeIntParse(json['price']),
        packName:  json["packName"] ?? '',
        isAvailable: _parseBool(json["isAvailable"]),
        restaurantId: json["restaurantId"] ?? '',
        packDescription: json["packDescription"] ?? '',
    );
}

