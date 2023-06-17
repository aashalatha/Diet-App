import 'package:flutter/material.dart';
import 'package:stayfit/models/diet.dart';
import 'package:stayfit/ui/table_calendar.dart';
import 'package:stayfit/widgets/food_row.dart';
import 'package:stayfit/widgets/meal_heading.dart';

import '../widgets/custom_container.dart';

class DietPlan extends StatelessWidget {
  DietPlan({super.key, required this.diet});
  
  final DietChart diet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.blue[50],
      body: 
      ListView(
        children: [
          CollapsibleCalendar(text:"Diet Plan"),
          MealHeading(title: "Breakfast"),
          MyContainer(
            child: Column(
              children: [
                FoodRow(text: diet.breakfast)
              ],
            ),
          ),
          MealHeading(title: "Morning Snack"),
          MyContainer(
            child: Column(
              children: [
                FoodRow(text: diet.midMorningSnack)
              ],
            ),
          ),
          MealHeading(title: "Lunch"),
          MyContainer(
            child: Column(
              children: [
                FoodRow(text: diet.lunch)
              ],
            ),
          ),
          MealHeading(title: "Evening Snack"),
          MyContainer(
            child: Column(
              children: [
                FoodRow(text: diet.eveningSnack)
              ],
            ),
          ),
          MealHeading(title: "Dinner"),
          MyContainer(
            child: Column(
              children: [
                FoodRow(text: diet.dinner)
              ],
            ),
          ),
        ],
      ),
    );
  }
}




