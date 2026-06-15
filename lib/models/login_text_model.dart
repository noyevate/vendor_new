// models/vendor_login_response.dart

// ignore_for_file: non_constant_identifier_names

// Helper function to parse the main JSON string
import 'dart:convert';

bool _parseBool(dynamic value, {required String fieldName}) {
  // This print statement will run for every boolean field we parse.
  print("Parsing bool for '$fieldName': received value -> '$value' of type -> ${value.runtimeType}");
  
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  if (value is int) return value == 1;
  return false; // Safely default to false if null or other type
}

VendorLogin VendorLoginFromJson(String str) => VendorLogin.fromJson(json.decode(str));




class VendorLogin {
    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final String? fcm;
    final bool verification;
    final String phone;
    final bool phoneVerification;
    final String userType;
    final DateTime createdAt;
    final DateTime updatedAt;
    final OwnedRestaurant? ownedRestaurant;
    final String userToken;

    VendorLogin({
        required this.id, required this.firstName, required this.lastName,
        required this.email, this.fcm, required this.verification,
        required this.phone, required this.phoneVerification, required this.userType,
         required this.createdAt, required this.updatedAt,
        this.ownedRestaurant, required this.userToken,
    });

    factory VendorLogin.fromJson(Map<String, dynamic> json) => VendorLogin(
        id: json["id"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        email: json["email"] ?? '',
        fcm: json["fcm"] ?? "",
        verification: _parseBool(json["verification"], fieldName: "verification"),
        phone: json["phone"] ?? '',
        phoneVerification: _parseBool(json["phoneVerification"], fieldName: "phoneVerification"),
        userType: json["userType"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        ownedRestaurant: json["ownedRestaurant"] == null ? null : OwnedRestaurant.fromJson(json["ownedRestaurant"]),
        userToken: json["userToken"] ?? '',
    );
}

class OwnedRestaurant {
    final String id;
    final String title;
    final String imageUrl;
    final bool pickup;
    final String? restaurantFcm;
    final String restaurantMail;
    final bool delivery;
    final bool isAvailabe;
    final String phone;
    final String? code;
    final String? accountName;
    final String? accountNumber;
    final String? bank;
    final String logoUrl;
    final double rating;
    final String ratingCount;
    final String verification;
    final String verificationMessage;
    final double latitude;
    final double longitude;
    final double latitudeDelta;
    final double longitudeDelta;
    final String address;
    final String addressTitle;
    final List<Time> time;
    final String userId;
    final List<RestaurantCategory>? restaurantCategories;
    final DateTime createdAt;
    final DateTime updatedAt;

    OwnedRestaurant({
        required this.id, required this.title, required this.imageUrl, required this.pickup,
        this.restaurantFcm, required this.restaurantMail, required this.delivery,
        required this.isAvailabe, required this.phone, this.code, this.accountName,
        this.accountNumber, this.bank, required this.logoUrl, required this.rating,
        required this.ratingCount, required this.verification, required this.verificationMessage,
        required this.latitude, required this.longitude, required this.latitudeDelta,
        required this.longitudeDelta, required this.address, required this.addressTitle,
        required this.time, required this.userId, this.restaurantCategories,
        required this.createdAt, required this.updatedAt,
    });

    factory OwnedRestaurant.fromJson(Map<String, dynamic> json) => OwnedRestaurant(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        pickup: _parseBool(json["pickup"], fieldName: "pickup"),
        restaurantFcm: json["restaurantFcm"],
        restaurantMail: json["restaurantMail"] ?? '',
        delivery: _parseBool(json["delivery"], fieldName: "delivery"),
        isAvailabe: _parseBool(json["isAvailabe"], fieldName: "ownedRes_isAvailable"),
        phone: json["phone"] ?? '',
        code: json["code"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bank: json["bank"],
        logoUrl: json["logoUrl"] ?? '',
        rating: double.tryParse(json["rating"]?.toString() ?? '0.0') ?? 0.0,
        ratingCount: json["ratingCount"] ?? '0',
        verification: json["verification"] ?? '',
        verificationMessage: json["verificationMessage"] ?? '',
        latitude: json["latitude"]?.toDouble() ?? 0.0,
        longitude: json["longitude"]?.toDouble() ?? 0.0,
        latitudeDelta: json["latitudeDelta"]?.toDouble() ?? 0.0,
        longitudeDelta: json["longitudeDelta"]?.toDouble() ?? 0.0,
        address: json["address"] ?? '',
        addressTitle: json["addressTitle"] ?? '',
        time: json["time"] == null ? [] : List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
        userId: json["userId"] ?? '',
        restaurantCategories: json["restaurant_categories"] == null ? null : List<RestaurantCategory>.from(json["restaurant_categories"].map((x) => RestaurantCategory.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );
}

class RestaurantCategory {
    final String name;
    final List<Additive> additives;

    RestaurantCategory({required this.name, required this.additives});

    factory RestaurantCategory.fromJson(Map<String, dynamic> json) => RestaurantCategory(
        name: json["name"] ?? '',
        additives: json["additives"] == null ? [] : List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
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
        required this.id, required this.additiveTitle,
        required this.options, required this.max, required this.min, required this.isAvailable,
    });

    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        id: json["id"] ?? '',
        additiveTitle: json["additiveTitle"] ?? '',
        options: json["options"] == null ? [] : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        max: json["max"] ?? 0,
        min: json["min"] ?? 0,
        isAvailable: _parseBool(json["isAvailable"], fieldName: "additive isAvailable"),
    );
}

class Option {
    final String id;
    final String additiveName;
    final int price;
    final bool isAvailable;

    Option({ required this.id, required this.additiveName, required this.price, required this.isAvailable });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] ?? '',
        additiveName: json["additiveName"] ?? '',
        price: json["price"] ?? 0,
        isAvailable: _parseBool(json["isAvailable"], fieldName: "is_available"),
    );
}

class Time {
    final String day;
    final String open;
    final String close;
    final String orderType;
    final String? menuReadyTime;
    final String? orderCutOffTime;

    Time({
        required this.day, required this.open, required this.close,
        required this.orderType, this.menuReadyTime, this.orderCutOffTime,
    });


    factory Time.fromJson(Map<String, dynamic> json) => Time(
        day: json["day"] ?? '',
        open: json["open"] ?? '',
        close: json["close"] ?? '',
        orderType: json["orderType"] ?? '',
        menuReadyTime: json["menuReadyTime"],
        orderCutOffTime: json["orderCutOffTime"],
    );
}
