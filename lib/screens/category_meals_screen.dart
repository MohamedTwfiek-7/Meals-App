import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';


class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/CategoryMealsScreen';
  final  List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String cateTitle;
  List<Meal> displayedMeal;

  void _removeMeal(String id){
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  void didChangeDependencies() {
    final argu =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    final cateID = argu['id'];
    cateTitle = argu['title'];
    displayedMeal = widget.availableMeals.where((meal) {
      return meal.categories.contains(cateID);
    }).toList(); //filter and return list
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cateTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: displayedMeal.length,
        itemBuilder: (ctx, inx) {
          return MealItem(
            id: displayedMeal[inx].id,
            imageUrl: displayedMeal[inx].imageUrl,
            title: displayedMeal[inx].title,
            duration: displayedMeal[inx].duration,
            complexity: displayedMeal[inx].complexity,
            affordability: displayedMeal[inx].affordability,
          );
        },
      ),
    );
  }
}
