import 'package:flutter/material.dart';
import 'package:stayfit/models/diet.dart';
//import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:stayfit/ui/diet_plan.dart';
import 'package:stayfit/ui/profile.dart';
import 'package:stayfit/ui/progress.dart';
import 'package:stayfit/ui/recipes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        items:const  [
          BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.food_bank_rounded,),
          label: 'Meal',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu_outlined),
          label: 'Recipes',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          backgroundColor: Colors.white,
        )
        ], 
        currentIndex: _selectedIndex, 
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        onTap: (clickedIndex) {
        setState(() {
          _selectedIndex = clickedIndex;
        });
      },
      ),
      body: Container(
          decoration: BoxDecoration(color: Colors.white60),
          child: Center(
            child: _getpage(_selectedIndex),
          ),
        ),
    );
  }
}

_getpage(int selectedIndex){
  switch(selectedIndex){
    case 0:
    return Progress();
    case 1:
    return DietPlan(diet: dietChart[0],);
    case 2:
    return RecipeSearchScreen();
    case 3:
    return Profile();
  }
}
