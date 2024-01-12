import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meals.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key , required this.availableMeals});



  final List<Meal> availableMeals;

  void _selectedCategory(BuildContext context, Category category) {
    final filtereslist = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealScreen(title: category.title, meals: filtereslist),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectecCategory: () {
              _selectedCategory(context, category);
            },
          )
      ],
    );
  }
}
