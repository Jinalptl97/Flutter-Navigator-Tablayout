import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/providers/favorite_provider.dart';
import 'package:meal_app/providers/filter_provider.dart';

const kInitialFilters = {
  filter.glutenfree: false,
  filter.lactosefree: false,
  filter.vegetarian: false,
  filter.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _tabScreenState();
  }
}

class _tabScreenState extends ConsumerState<TabScreen> {
  int _selectedpageIndex = 0;

  void _selectpage(int index) {
    setState(() {
      _selectedpageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'Filters') {
      await Navigator.push<Map<filter, bool>>(
          context, MaterialPageRoute(builder: (ctx) => const Filterscreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final availableMeals = ref.watch(filteredMealProvider);

    Widget activepage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activepageTitle = 'Categories';

    if (_selectedpageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activepage = MealScreen(
        meals: favoriteMeals,
      );
      activepageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activepageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        currentIndex: _selectedpageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
