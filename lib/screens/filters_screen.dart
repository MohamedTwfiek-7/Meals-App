import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/FiltersScreen';

  final Function saveFilters;
  final Map<String , bool > currFilters;

  FilterScreen(this.saveFilters, this.currFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {// to save the user filters (not local)
    _glutenFree = widget.currFilters['gluten'];
    _lactoseFree = widget.currFilters['lactose'];
    _vegan = widget.currFilters['vegan'];
    _vegetarian = widget.currFilters['vegetarian'];
    super.initState();
  }
  Widget buildSwitchListTile(
      String title, String description, bool currValue, Function updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      subtitle: Text(description),
      value: currValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: (){
              final Map<String , bool> selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                    'GlutenFree', 'Only include GlutenFree meals', _glutenFree,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwitchListTile('LactoseFree',
                    'Only include LactoseFree meals', _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                buildSwitchListTile('Vegan', 'Only include Vegan meals', _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                buildSwitchListTile(
                    'Vegetarian', 'Only include Vegetarian meals', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
