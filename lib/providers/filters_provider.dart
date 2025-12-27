import 'package:flutter_riverpod/legacy.dart';

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