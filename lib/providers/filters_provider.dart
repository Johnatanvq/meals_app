import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  gluttenFree,
  lactoseFree,
  vegetarianFree,
  veganFree,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super({
    Filter.gluttenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarianFree: false,
    Filter.veganFree: false,
  });

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; //not allowed! => mutating the state
    state = {
      ...state,
      filter: isActive
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier()
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  
  return meals.where((meal) {
      if (activeFilters[Filter.gluttenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      } 
      if (activeFilters[Filter.vegetarianFree]! && !meal.isVegetarian) {
        return false;
      } 
      if (activeFilters[Filter.veganFree]! && !meal.isVegan) {
        return false;
      } 
      return true;
    }).toList();
});