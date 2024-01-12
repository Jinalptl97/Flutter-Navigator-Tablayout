import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meals.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatopnController;

  @override
  void initState() {
    super.initState();
    _animatopnController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animatopnController.forward();
  }

  @override
  void dispose() {
    _animatopnController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final filtereslist = widget.availableMeals
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
    return AnimatedBuilder(
        animation: _animatopnController,
        child: GridView(
          padding: EdgeInsets.all(24),
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
        ),
        builder: (context, child) => SlideTransition(
              position:
                  Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                parent: _animatopnController,
                curve: Curves.easeInOut,
              )),
              child: child,
            ));
  }
}
