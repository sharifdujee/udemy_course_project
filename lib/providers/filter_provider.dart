import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/meals_provider.dart';


enum Filter { glutenFree, lactoseFree, vegetarian, vegan }
class FilterNotifier extends StateNotifier<Map<Filter, bool>>{
  FilterNotifier(): super({
    Filter.glutenFree : false,
    Filter.lactoseFree: false,
    Filter.vegetarian : false,
    Filter.vegan : false,
  });

  void setFilter(Filter filter, bool isActive){
    //state[filter] = isActive;
    state = {
      ...state,
      filter : isActive,
    };
  }

  void setAllFilter(Map<Filter, bool> chooseFilter){
    state = chooseFilter;
  }

}
final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref)=> FilterNotifier());

final filterMealsProvider = Provider((ref){
  final meals = ref.watch(mealProvider);
  final activeFilter = ref.watch(filterProvider);
  return meals.where((meal) {
    // Only include meals that meet all active filter criteria
    if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false; // Ensures only vegetarian meals when filter is true
    }
    if (activeFilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true; // Include meal only if it meets all active filters
  }).toList();
});