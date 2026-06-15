// To parse this JSON data, do
//
//     final editAdditiveCategoryModel = editAdditiveCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditAdditiveCategoryModel editAdditiveCategoryModelFromJson(String str) => EditAdditiveCategoryModel.fromJson(json.decode(str));

String editAdditiveCategoryModelToJson(EditAdditiveCategoryModel data) => json.encode(data.toJson());

class EditAdditiveCategoryModel {
    final String additiveTitle;
    final int min;
    final int max;

    EditAdditiveCategoryModel({
        required this.additiveTitle,
        required this.min,
        required this.max,
    });

    factory EditAdditiveCategoryModel.fromJson(Map<String, dynamic> json) => EditAdditiveCategoryModel(
        additiveTitle: json["additiveTitle"],
        min: json["min"],
        max: json["max"],
    );

    Map<String, dynamic> toJson() => {
        "additiveTitle": additiveTitle,
        "min": min,
        "max": max,
    };
}
