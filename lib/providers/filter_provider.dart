import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/meals_provider.dart';

enum filter { glutenfree, lactosefree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<filter, bool>> {
  FilterNotifier()
      : super({
          filter.glutenfree: false,
          filter.lactosefree: false,
          filter.vegetarian: false,
          filter.vegan: false
        });

  void setfilter(filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setfilters(Map<filter, bool> chosenfilters) {
    state = chosenfilters;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealProvider = Provider((ref) {
 final meals= ref.watch(mealsprovider);
 final activefilters=ref.watch(filterProvider);
  return meals.where((meal) {
    if (activefilters[filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilters[filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilters[filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activefilters[filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
