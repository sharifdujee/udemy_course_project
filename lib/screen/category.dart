import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/data/meal.dart';
import 'package:meal_app/models/categories.dart';
import 'package:meal_app/screen/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoryScreen extends StatefulWidget {

  final List<Meal> availableMeals;
  const CategoryScreen({super.key, required this.availableMeals});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;


  void _selectCategory(BuildContext context, Category category){
   final filterMeals =  widget.availableMeals.where((meal)=> meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  MealsScreen(title: category.title, meals: filterMeals,)));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 300,),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          /// category Map
          for(final category in availableCategories)
            CategoryGridItem(category: category, onSelectCategory: (){
              _selectCategory(context, category);
            },)
        ],

      )  ,
      builder:(context, child)=>  SlideTransition(position: Tween(
        begin:const Offset(0, 0.3) ,
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut)),
      child: child,),

    );
  }
}
