import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String , bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];

  void _setFilters( Map<String , bool> filterData ){
    setState(() {
      _filters =filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] == true  && meal.isGlutenFree == false){
          return false;
        }
        if(_filters['lactose'] == true  && meal.isLactoseFree == false){
          return false;
        }
        if(_filters['vegan'] == true  && meal.isVegan == false){
          return false;
        }
        if(_filters['vegetarian'] == true  && meal.isVegetarian == false){
          return false;
        }
        return true;
      }).toList();
    });
  }
  void _toggleFavorites(String mealID){
    final favoIndex = _favoritesMeals.indexWhere((meal) => meal.id == mealID);

    if(favoIndex>=0){
      setState(() {
        _favoritesMeals.removeAt(favoIndex);
      });
    }
    else{
      setState(() {
        _favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      });
    }
  }
  bool isMealFavorite(String id){
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(_favoritesMeals),
        CategoryMealsScreen.routeName : (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (context) => MealDetailScreen(_toggleFavorites,isMealFavorite),
        FilterScreen.routeName : (context) => FilterScreen(_setFilters,_filters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal App'),
      ),
      body: null,
    );
  }
}
