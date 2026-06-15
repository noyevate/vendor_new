import 'package:vendor/hooks/fetch_food_by_id.dart';
import 'package:vendor/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FoodsWidget extends HookWidget {
  const FoodsWidget( {super.key, required this.id, required this.onAdditiveFetched,});

  final String id; 
  final Function(FoodModel) onAdditiveFetched;


  @override
  Widget build(BuildContext context) {

    final hookResult = useFetchSingleFood("id");
    final FoodModel? addtiveFood = hookResult.data;
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;


    if (addtiveFood != null) {
      onAdditiveFetched(addtiveFood);
    }

    return Container();
  }
}