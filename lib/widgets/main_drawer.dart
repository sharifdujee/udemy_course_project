import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final void Function(String identifier)  onSelectScreen;
  const MainDrawer({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Cook Up',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant, size: 26, color: Colors.red,),
            title: Text('Meals', style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 24,
            color: Colors.black),),
            onTap: (){
              onSelectScreen('meals');


            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, size: 26, color: Colors.red,),
            title: Text('Filters', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 24,
                color: Colors.black),),
            onTap: (){
              onSelectScreen('filters');

            },
          ),
        ],
      ),
    );
  }
}
