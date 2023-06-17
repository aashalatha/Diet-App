import 'package:flutter/material.dart';
import 'package:stayfit/ui/table_calendar.dart';

import '../widgets/custom_row.dart';
import '../widgets/custom_container.dart';
import '../widgets/meal_title.dart';

class MealConsumed extends StatefulWidget {
  final String calorie;
  final String name;
  const MealConsumed({ required this.name,required this.calorie});

  @override
  State<MealConsumed> createState() => _MealConsumedState();
}

class _MealConsumedState extends State<MealConsumed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: ListView( 
        children: [
          CollapsibleCalendar(text: "Track Your Meal",),
          MealTitle(title: "Breakfast",mincal: "0 cal",maxcal: "400 cal",),
          MyContainer(
            child: Column(
              children: [
                CustomRow(cal: "${widget.calorie} cal",text: widget.name,)
              ],
            ),
          ),
         
          MealTitle(title: "Morning Snack",mincal: "0 cal",maxcal: "200 cal",),
          MyContainer(
            child: Column(
              children: [
                CustomRow(cal: "",text: "",)
                //CustomRow(cal: "107.4 cal", text: "Apple"),
              ],
            ),
          ),
          MealTitle(title: "Lunch",mincal: "0 cal",maxcal: "400 cal",),
          MyContainer(
            child: Column(
              children: [
                CustomRow(cal: "",text: "",)
              ],
            ),
          ),
          MealTitle(title: "Evening Snack",mincal: "0 cal",maxcal: "425 cal",),
          MyContainer(
            child: Column(
              children: [
                CustomRow(cal: "",text: "",)
              ],
            ),
          ),
          MealTitle(title: "Dinner",mincal: "0 cal",maxcal: "425 cal",),
          MyContainer(
            child: Column(
              children: [
                CustomRow(cal: "",text: "",)
              ],
            ),
          ),
        ],
      ),
    );
  }
}




