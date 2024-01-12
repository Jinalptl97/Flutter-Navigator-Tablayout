import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_app/screens/tabs.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/providers/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class Filterscreen extends ConsumerWidget {
  const Filterscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final activeFilters=  ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      body: 
     Column(children: [
          SwitchListTile(
            value: activeFilters[filter.glutenfree]!,
            onChanged: (ischecked) {
              ref.read(filterProvider.notifier).setfilter(filter.glutenfree, ischecked);
              
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
            value: activeFilters[filter.lactosefree]!,
            onChanged: (ischecked) {
              ref.read(filterProvider.notifier).setfilter(filter.lactosefree, ischecked);
              
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
            value: activeFilters[filter.vegetarian]!,
            onChanged: (ischecked) {
              ref.read(filterProvider.notifier).setfilter(filter.vegetarian, ischecked);
              
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
           value: activeFilters[filter.vegan]!,
            onChanged: (ischecked) {
              ref.read(filterProvider.notifier).setfilter(filter.vegan, ischecked);
              
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
      );
  }
}
