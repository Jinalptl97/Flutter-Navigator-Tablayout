import 'package:flutter/material.dart';
import 'package:meal_app/models/meals.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, this.title, required this.meals,required this.onToggleFavourites});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourites;

  void selectedMeal(Meal meal, BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavourites: onToggleFavourites,

          )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'uh oh.. Nothing here',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
                meal: meals[index],
                onselectedMeal: (meal) {
                  selectedMeal(meal, context);
                },
              ));
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
