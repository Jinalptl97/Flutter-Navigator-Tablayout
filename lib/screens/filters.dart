import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_app/screens/tabs.dart';
import 'package:meal_app/widgets/main_drawer.dart';

enum filter { glutenfree, lactosefree, vegetarian, vegan }

class Filterscreen extends StatefulWidget {
  const Filterscreen({super.key, required this.currentfilter});

  final Map<filter, bool> currentfilter;
  @override
  State<Filterscreen> createState() {
    return _filterState();
  }
}

class _filterState extends State<Filterscreen> {
  var _glutenFreeFilterset = false;
  var _lactoseFreeFilterset = false;
  var _vegetarianFilterset = false;
  var _veganFilterset = false;
  @override
  void initState() {
    super.initState();
    _glutenFreeFilterset = widget.currentfilter[filter.glutenfree]!;
    _lactoseFreeFilterset = widget.currentfilter[filter.lactosefree]!;
    _vegetarianFilterset = widget.currentfilter[filter.vegetarian]!;
    _veganFilterset = widget.currentfilter[filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) => {
          Navigator.pop(context),
          if (identifier == 'Meals')
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (ctx) => const TabScreen()),
              )
            }
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            filter.glutenfree: _glutenFreeFilterset,
            filter.lactosefree: _lactoseFreeFilterset,
            filter.vegetarian: _vegetarianFilterset,
            filter.vegan: _veganFilterset,
          });
          return false;
        },
        child: Column(children: [
          SwitchListTile(
            value: _glutenFreeFilterset,
            onChanged: (ischecked) {
              setState(() {
                _glutenFreeFilterset = ischecked;
              });
            },
            title: Text('Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text('Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _lactoseFreeFilterset,
            onChanged: (ischecked) {
              setState(() {
                _lactoseFreeFilterset = ischecked;
              });
            },
            title: Text('Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text('Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _vegetarianFilterset,
            onChanged: (ischecked) {
              setState(() {
                _vegetarianFilterset = ischecked;
              });
            },
            title: Text('Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text('Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _veganFilterset,
            onChanged: (ischecked) {
              setState(() {
                _veganFilterset = ischecked;
              });
            },
            title: Text('Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text('Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ]),
      ),
    );
  }
}
