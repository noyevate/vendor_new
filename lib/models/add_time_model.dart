// To parse this JSON data, do
//
//     final addTimeModel = addTimeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddTimeModel addTimeModelFromJson(String str) => AddTimeModel.fromJson(json.decode(str));

String addTimeModelToJson(AddTimeModel data) => json.encode(data.toJson());

class AddTimeModel {
  final String orderType;
  final String day;
  final String open;
  final String close;
  final String? orderCutOffTime; // Nullable for Instant delivery
  final String? menuReadyTime; // Nullable for Instant delivery

  AddTimeModel({
    required this.orderType,
    required this.day,
    required this.open,
    required this.close,
    this.orderCutOffTime,
    this.menuReadyTime,
  }) {
    // Validation logic for orderType
    if (orderType != 'Pre-order' && orderType != 'Instant delivery') {
      throw ArgumentError('Invalid orderType: must be "Pre-order" or "Instant delivery".');
    }

    // Additional checks based on orderType
    if (orderType == 'Pre-order' && (orderCutOffTime == null || menuReadyTime == null)) {
      throw ArgumentError('Pre-order requires orderCutOffTime and menuReadyTime.');
    }

    if (orderType == 'Instant delivery' && (orderCutOffTime != null || menuReadyTime != null)) {
      throw ArgumentError('Instant delivery should not have orderCutOffTime or menuReadyTime.');
    }
  }

  factory AddTimeModel.fromJson(Map<String, dynamic> json) {
    return AddTimeModel(
      orderType: json["orderType"],
      day: json["day"],
      open: json["open"],
      close: json["close"],
      orderCutOffTime: json["orderCutOffTime"],
      menuReadyTime: json["menuReadyTime"],
    );
  }

  Map<String, dynamic> toJson() => {
        "orderType": orderType,
        "day": day,
        "open": open,
        "close": close,
        "orderCutOffTime": orderCutOffTime,
        "menuReadyTime": menuReadyTime,
      };
}

