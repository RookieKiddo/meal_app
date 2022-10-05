import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters_screen';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _isLactoseFree = widget.currentFilters['lactose']!;
    _isVegetarian = widget.currentFilters['vegetarian']!;
    _isVegan = widget.currentFilters['vegan']!;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _glutenFree,
                    'lactose': _isLactoseFree,
                    'vegan': _isVegan,
                    'vegetarian': _isVegetarian,
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust Your Meal Selection',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    'Gluten Free',
                    'Only Include Gluten Free Meals',
                    _glutenFree, (updateValue) {
                  setState(() {
                    _glutenFree = updateValue;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose Free',
                    'Only Include Lactose Free Meals',
                    _isLactoseFree, (updateValue) {
                  setState(() {
                    _isLactoseFree = updateValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian',
                    'Only Include Vegetarian Meals',
                    _isVegetarian, (updateValue) {
                  setState(() {
                    _isVegetarian = updateValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only Include Vegan Meals', _isVegan,
                    (updateValue) {
                  setState(() {
                    _isVegan = updateValue;
                  });
                }),
              ],
            )),
          ],
        ));
  }
}
