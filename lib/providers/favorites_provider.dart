import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/data/meal.dart';


class FavoriteMealsNotifier extends  StateNotifier<List<Meal>>{
  FavoriteMealsNotifier() : super([]);

  bool toggleMealsFavouriteStatus(Meal meal){
    final mealsFavourite = state.contains(meal);
    if(mealsFavourite){
      state = state.where((m)=> m.id != meal.id).toList();
      return false;
    }
    else{
      state = [...state, meal];
      return true;

    }

  }

}
final favouriteProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref){
  return FavoriteMealsNotifier();
});