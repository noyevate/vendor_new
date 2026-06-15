// To parse this JSON data, do
//
//     final mealCategoryModel = mealCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<String> mealCategoryModelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String mealCategoryModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
