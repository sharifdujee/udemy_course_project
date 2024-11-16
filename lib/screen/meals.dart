import 'package:flutter/material.dart';
import 'package:meal_app/data/meal.dart';
import 'package:meal_app/screen/meal_details_screen.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;




  const MealsScreen({super.key,  this.title, required this.meals,});

  void selectMeal(BuildContext context,  Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MealDetailsScreen( meal: meal)));

  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh Nothing Here!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(meal: meals[index], onSelectMeal: (meal){
            selectMeal(context,  meal);

          },);
        },
      );
    }
  if(title == null){
    return content;
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
