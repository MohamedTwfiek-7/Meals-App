import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favor_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final _page = [
    {
      'page':CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page':FavoritesScreen(),
      'title': 'Favorites',
    }
  ];

  int _selectedPageInx = 0;

  void _selectPage(int value) {
    setState(() {
      _selectedPageInx = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_selectedPageInx]['title']),
      ),
      body: _page[_selectedPageInx]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageInx,//don't forget
        onTap: _selectPage,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }


}
