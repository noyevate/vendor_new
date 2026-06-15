// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RatingModel> ratingModelFromJson(String str) => List<RatingModel>.from(json.decode(str).map((x) => RatingModel.fromJson(x)));

String ratingModelToJson(List<RatingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RatingModel {
    final String id;
    final String restaurant;
    final String user;
    final double rating;
    final String comment;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final String name;

    RatingModel({
        required this.id,
        required this.restaurant,
        required this.user,
        required this.rating,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.name,
    });

    factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json["_id"],
        restaurant: json["restaurant"],
        user: json["user"],
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
         name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "restaurant": restaurant,
        "user": user,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "name": name
    };
}
