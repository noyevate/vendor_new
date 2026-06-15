// // To parse this JSON data, do
// //
// //     final orderModel = orderModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

// String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class OrderModel {
//     final String id;
//     final String userId;
//     final List<OrderItem> orderItems;
//     final int orderTotal;
//     final int orderSubId;
//     final int deliveryFee;
//     final int grandTotal;
//     final String deliveryAddress;
//     final String restaurantAddress;
//     final String paymentMethod;
//     final String paymentStatus;
//     final String orderStatus;
//     final String restaurantId;
//     final List<double> restaurantCoords;
//     final List<double> recipientCoords;
//     final String riderId;
//     final int rating;
//     final bool restaurantRating;
//     final bool riderRating;
//     final String feedback;
//     final String promoCode;
//     final int discountAmount;
//     final String notes;
//     final String customerName;
//     final String customerPhone;
//     final bool riderAssigned;
//     final List<dynamic> rejectedBy;
//     final String customerFcm;
//     final String restaurantFcm;
//     final String riderStatus;
//     final String riderFcm;
//     final DateTime createdAt;
//     final DateTime updatedAt;
    

//     OrderModel({
//         required this.id,
//         required this.userId,
//         required this.orderItems,
//         required this.orderTotal,
//         required this.orderSubId,
//         required this.deliveryFee,
//         required this.grandTotal,
//         required this.deliveryAddress,
//         required this.restaurantAddress,
//         required this.paymentMethod,
//         required this.paymentStatus,
//         required this.orderStatus,
//         required this.restaurantId,
//         required this.restaurantCoords,
//         required this.recipientCoords,
//         required this.riderId,
//         required this.rating,
//         required this.restaurantRating,
//         required this.riderRating, 
//         required this.feedback,
//         required this.promoCode,
//         required this.discountAmount,
//         required this.notes,
//         required this.customerName,
//         required this.customerPhone,
//         required this.riderAssigned,
//         required this.rejectedBy,
//         required this.customerFcm,
//         required this.restaurantFcm,
//         required this.riderStatus,
//         required this.riderFcm,
//         required this.createdAt,
//         required this.updatedAt,
        
//     });

//     factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
//         id: json["_id"],
//         userId: json["userId"]!,
//         orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
//         orderTotal: json["orderTotal"],
//         orderSubId: json["orderSubId"],
//         deliveryFee: json["deliveryFee"],
//         grandTotal: json["grandTotal"],
//         deliveryAddress: json["deliveryAddress"],
//         restaurantAddress: json["restaurantAddress"]!,
//         paymentMethod: json["paymentMethod"],
//         paymentStatus: json["paymentStatus"],
//         orderStatus: json["orderStatus"]!,
//         restaurantId: json["restaurantId"]!,
//         restaurantCoords: List<double>.from(json["restaurantCoords"].map((x) => x?.toDouble())),
//         recipientCoords: List<double>.from(json["recipientCoords"].map((x) => x?.toDouble())),
//         riderId: json["riderId"],
//         rating: json["rating"],
//         restaurantRating: json["restaurantRating"],
//         riderRating: json["riderRating"],
//         feedback: json["feedback"],
//         promoCode: json["PromoCode"]!,
//         discountAmount: json["discountAmount"],
//         notes: json["notes"],
//         customerName: json["customerName"],
//         customerPhone: json["customerPhone"],
//         riderAssigned: json["riderAssigned"],
//         rejectedBy: List<dynamic>.from(json["rejectedBy"].map((x) => x)),
//         customerFcm: json["customerFcm"],
//         restaurantFcm: json["restaurantFcm"],
//         riderStatus: json["riderStatus"],
//         riderFcm: json["riderFcm"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
        
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
//         "orderTotal": orderTotal,
//         "orderSubId": orderSubId,
//         "deliveryFee": deliveryFee,
//         "grandTotal": grandTotal,
//         "deliveryAddress": deliveryAddress,
//         "restaurantAddress": restaurantAddress,
//         "paymentMethod": paymentMethod,
//         "paymentStatus": paymentStatus,
//         "orderStatus": orderStatus,
//         "restaurantId": restaurantId,
//         "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
//         "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
//         "riderId": riderId,
//         "rating": rating,
//         "restaurantRating": restaurantRating,
//         "riderRating": riderRating,
//         "feedback": feedback,
//         "PromoCode": promoCode,
//         "discountAmount": discountAmount,
//         "notes": notes,
//         "customerName": customerName,
//         "customerPhone": customerPhone,
//         "riderAssigned": riderAssigned,
//         "rejectedBy": List<dynamic>.from(rejectedBy.map((x) => x)),
//         "customerFcm": customerFcm,
//         "restaurantFcm": restaurantFcm,
//         "riderStatus": riderStatus,
//         "riderFcm": riderFcm,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//     };
// }


// class OrderItem {
//     final String foodId;
//     final int numberOfPack;
//     final List<Additive> additives;
//     final String instruction;
//     final String id;
//     final DateTime createdAt;
//     final DateTime updatedAt;

//     OrderItem({
//         required this.foodId,
//         required this.numberOfPack,
//         required this.additives,
//         required this.instruction,
//         required this.id,
//         required this.createdAt,
//         required this.updatedAt,
//     });

//     factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//         foodId: json["foodId"],
//         numberOfPack: json["numberOfPack"],
//         additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
//         instruction: json["instruction"],
//         id: json["_id"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "foodId": foodId,
//         "numberOfPack": numberOfPack,
//         "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
//         "instruction": instruction,
//         "_id": id,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//     };
// }

// class Additive {
//     final String foodTitle;
//     final int foodPrice;
//     final int foodCount;
//     final String name;
//     final int price;
//     final int quantity;
//     final int packCount;

//     Additive({
//         required this.foodTitle,
//         required this.foodPrice,
//         required this.foodCount,
//         required this.name,
//         required this.price,
//         required this.quantity,
//         required this.packCount,
//     });

//     factory Additive.fromJson(Map<String, dynamic> json) => Additive(
//         foodTitle: json["foodTitle"],
//         foodPrice: json["foodPrice"],
//         foodCount: json["foodCount"],
//         name: json["name"],
//         price: json["price"],
//         quantity: json["quantity"],
//         packCount: json["packCount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "foodTitle": foodTitle,
//         "foodPrice": foodPrice,
//         "foodCount": foodCount,
//         "name": name,
//         "price": price,
//         "quantity": quantity,
//         "packCount": packCount,
//     };
// }






// models/order_model.dart
import 'dart:convert';

// Helper function to parse a JSON string containing a list of orders.
List<OrderModel> orderModelFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData is! List) {
    print("Error: Expected a List of orders but got something else.");
    return [];
  }
  
  final List<OrderModel> orderList = [];
  for (var orderJson in jsonData) {
    try {
      orderList.add(OrderModel.fromJson(orderJson));
    } catch (e, s) {
      print("=" * 50);
      print("ERROR: Failed to parse a single OrderModel item.");
      print("Error Details: $e");
      print("Problematic JSON object: ${json.encode(orderJson)}");
      print("Stack Trace: $s");
      print("=" * 50);
    }
  }
  return orderList;
}

// Universal helper for safe boolean parsing.
bool _parseBool(dynamic value) {
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  if (value is int) return value == 1;
  return false;
}

// Helper for safe integer parsing from String or int/double.
int _safeIntParse(dynamic value) {
  if (value == null) return 0;
  return int.tryParse(value.toString().split('.').first) ?? 0;
}

class OrderModel {
    final String id;
    final String userId;
    final int orderTotal;
    final int orderSubId;
    final int deliveryFee;
    final String customerFcm;
    final String restaurantFcm;
    final String riderFcm;
    final int grandTotal;
    final String restaurantAddress;
    final String paymentMethod;
    final String paymentStatus;
    final String orderStatus;
    final String riderStatus;
    final String riderId;
    final int rating;
    final bool restaurantRating;
    final bool riderRating;
    final String feedback;
    final String promoCode;
    final String customerName;
    final String customerPhone;
    final int discountAmount;
    final String notes;
    final bool riderAssigned;
    final List<double> restaurantCoords;
    final List<double> recipientCoords;
    final List<dynamic> rejectedBy;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String? deliveryAddressId;
    final String restaurantId;
    final List<OrderItem> orderItems;

    OrderModel({
        required this.id, required this.userId, required this.orderTotal,
        required this.orderSubId, required this.deliveryFee, required this.customerFcm,
        required this.restaurantFcm, required this.riderFcm, required this.grandTotal,
        required this.restaurantAddress, required this.paymentMethod, required this.paymentStatus,
        required this.orderStatus, required this.riderStatus, required this.riderId,
        required this.rating, required this.restaurantRating, required this.riderRating,
        required this.feedback, required this.promoCode, required this.customerName,
        required this.customerPhone, required this.discountAmount, required this.notes,
        required this.riderAssigned, required this.restaurantCoords, required this.recipientCoords,
        required this.rejectedBy, required this.createdAt, required this.updatedAt,
        this.deliveryAddressId, required this.restaurantId, required this.orderItems,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"] ?? '',
        userId: json["userId"] ?? '',
        orderTotal: _safeIntParse(json["orderTotal"]),
        orderSubId: json["orderSubId"] ?? 0,
        deliveryFee: _safeIntParse(json["deliveryFee"]),
        customerFcm: json["customerFcm"] ?? '',
        restaurantFcm: json["restaurantFcm"] ?? '',
        riderFcm: json["riderFcm"] ?? '',
        grandTotal: _safeIntParse(json["grandTotal"]),
        restaurantAddress: json["restaurantAddress"] ?? '',
        paymentMethod: json["paymentMethod"] ?? '',
        paymentStatus: json["paymentStatus"] ?? '',
        orderStatus: json["orderStatus"] ?? '',
        riderStatus: json["riderStatus"] ?? '',
        riderId: json["riderId"] ?? '',
        rating: json["rating"] ?? 0,
        restaurantRating: _parseBool(json["restaurantRating"]),
        riderRating: _parseBool(json["riderRating"]),
        feedback: json["feedback"] ?? '',
        promoCode: json["PromoCode"] ?? '',
        customerName: json["customerName"] ?? '',
        customerPhone: json["customerPhone"] ?? '',
        discountAmount: _safeIntParse(json["discountAmount"]),
        notes: json["notes"] ?? '',
        riderAssigned: _parseBool(json["riderAssigned"]),
        restaurantCoords: json["restaurantCoords"] == null ? [] : List<double>.from(json["restaurantCoords"].map((x) => x?.toDouble())),
        recipientCoords: json["recipientCoords"] == null ? [] : List<double>.from(json["recipientCoords"].map((x) => x?.toDouble())),
        rejectedBy: json["rejectedBy"] == null ? [] : List<dynamic>.from(json["rejectedBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deliveryAddressId: json["deliveryAddressId"],
        restaurantId: json["restaurantId"] ?? '',
        orderItems: json["orderItems"] == null ? [] : List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
    );
}

class OrderItem {
    final String id;
    final int quantity;
    final List<Additive> additives;
    final String instruction;
    final int price;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String orderId;
    final String foodId;
    final Food food;

    OrderItem({
        required this.id, required this.quantity, required this.additives,
        required this.instruction, required this.price, required this.createdAt,
        required this.updatedAt, required this.orderId, required this.foodId,
        required this.food,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"] ?? '',
        quantity: json["quantity"] ?? 0,
        additives: json["additives"] == null ? [] : List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
        instruction: json["instruction"] ?? '',
        price: _safeIntParse(json["price"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        orderId: json["orderId"] ?? '',
        foodId: json["foodId"] ?? '',
        food: json["food"] == null ? Food.empty() : Food.fromJson(json["food"]),
    );
}

class Additive {
    final String name;
    final int price;
    final int quantity;
    final int foodCount;
    final int foodPrice;
    final String foodTitle;
    final int packCount;
    Additive({required this.name, required this.price, required this.quantity, required this.foodCount, required this.foodPrice, required this.foodTitle, required this.packCount });
    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        name: json["name"] ?? '',
        price: json["price"] ?? 0,
        quantity: json["quantity"] ?? 0,
        foodCount: json['foodCount'] ?? 0,
        foodPrice: json['foodPrice'] ?? 0,
        foodTitle: json['foodTitle'] ?? '',
        packCount: json['packCount'] ?? 0


    );
}

class Food {
    final String id;
    final String title;
    final List<String> imageUrl;
    final int price;

    Food({
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.price,
    });

    factory Food.empty() => Food(id: '', title: 'Unknown', imageUrl: [], price: 0);

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        imageUrl: json["imageUrl"] == null ? [] : List<String>.from(json["imageUrl"].map((x) => x)),
        price: _safeIntParse(json["price"]),
    );
}
