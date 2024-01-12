import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meals.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier():super([]);

  bool toggleMealFavoriteStatus(Meal meal){
   final mealIspFavorite= state.contains(meal);
   if(mealIspFavorite){
    state=state.where((m)=> m.id!=meal.id).toList();
    return false;
   }
   else{
    state=[...state,meal];
    return true;
   }
  }

}

final favoriteMealsProvider= StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref){
return FavoriteMealsNotifier();
});
