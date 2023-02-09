import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/MealDetailScreen';
  final Function toggelFavorites;
  final Function isFavoriteMeal;

  const MealDetailScreen(this.toggelFavorites,this.isFavoriteMeal);

  Widget buildTitle(context, title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(child) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context).settings.arguments as String;

    final selectedMeals = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealID;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeals.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeals.imageUrl),
            ),
            buildTitle(context, 'Ingredients'),
            buildContainer(ListView.builder(
              itemCount: selectedMeals.ingredients.length,
              itemBuilder: (ctx, inx) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10),
                    child: Text(selectedMeals.ingredients[inx]),
                  ),
                );
              },
            )),
            buildTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeals.steps.length,
                itemBuilder: (ctx, inx) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text('#${inx + 1}'),
                        ),
                        title: Text(selectedMeals.steps[inx]),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>toggelFavorites(mealID),
        child: isFavoriteMeal(mealID)? const Icon(Icons.star) : const Icon(Icons.star_border),
      ),
    );
  }
}
