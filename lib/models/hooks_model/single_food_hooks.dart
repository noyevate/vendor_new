import 'package:vendor/models/food_model.dart';
import 'package:flutter/material.dart';

class FetchSingleFoods {
  final FoodModel? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchSingleFoods({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });

}