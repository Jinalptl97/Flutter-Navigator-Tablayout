import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meals.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kInitialFilters = {
  filter.glutenfree: false,
  filter.lactosefree: false,
  filter.vegetarian: false,
  filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() {
    return _tabScreenState();
  }
}

class _tabScreenState extends State<TabScreen> {
  int _selectedpageIndex = 0;
  final List<Meal> _favoritesMeals = [];
  Map<filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoritesMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoritesMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favorite.');
      });
    } else {
      setState(() {
        _favoritesMeals.add(meal);
        _showInfoMessage('Marked  as a Favorite');
      });
    }
  }

  void _selectpage(int index) {
    setState(() {
      _selectedpageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'Filters') {
      final result = await Navigator.push<Map<filter, bool>>(
          context, MaterialPageRoute(builder: (ctx) => Filterscreen(currentfilter: _selectedFilters,)));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
       if (_selectedFilters[filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
       if (_selectedFilters[filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
       if (_selectedFilters[filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activepage = CategoriesScreen(
      onToggleFavourites: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activepageTitle = 'Categories';
    if (_selectedpageIndex == 1) {
      activepage = MealScreen(
        meals: _favoritesMeals,
        onToggleFavourites: _toggleMealFavoriteStatus,
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
