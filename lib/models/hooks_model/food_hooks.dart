import 'package:vendor/models/food_model.dart';
import 'package:flutter/material.dart';

class FetchFoods {
  final List<FoodModel>? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchFoods({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });

}