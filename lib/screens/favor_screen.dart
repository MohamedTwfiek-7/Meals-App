import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoMeals;

  const FavoritesScreen(this.favoMeals);
  @override
  Widget build(BuildContext context) {
    if(favoMeals.isEmpty){
      return const Center(
        child: Text('No Favorites Meals!'),
      );
    }else{
      return ListView.builder(
        itemCount: favoMeals.length,
        itemBuilder: (ctx, inx) {
          return MealItem(
            id: favoMeals[inx].id,
            imageUrl: favoMeals[inx].imageUrl,
            title: favoMeals[inx].title,
            duration: favoMeals[inx].duration,
            complexity: favoMeals[inx].complexity,
            affordability: favoMeals[inx].affordability,
          );
        },
      );
    }
  }
}
