import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/CategoryMealsScreen';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  @override
  Widget build(BuildContext context) {
    final argu =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final cateID = argu['id'];
    final cateTitle = argu['title'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(cateID);
    }).toList(); //filter and return list

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cateTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, inx) {
          return MealItem(
            id: categoryMeals[inx].id,
            imageUrl: categoryMeals[inx].imageUrl,
            title: categoryMeals[inx].title,
            duration: categoryMeals[inx].duration,
            complexity: categoryMeals[inx].complexity,
            affordability: categoryMeals[inx].affordability,
          );
        },
      ),
    );
  }
}
