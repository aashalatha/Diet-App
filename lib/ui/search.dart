
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stayfit/models/food_details.dart';
import 'package:stayfit/ui/food_quantity.dart';
Future<String> _loadJsonData() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<List<FoodItem>> _fetchFoodData() async {
  String jsonData = await _loadJsonData();
  var data = json.decode(jsonData);
  var foodData = FoodData.fromJson(data);
  return foodData.food;
}

class FoodSearchScreen extends StatefulWidget {
  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Search Food",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20))
        ),
        backgroundColor: Colors.blue[50],
        body: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<FoodItem>>(
                future: _fetchFoodData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var foodList = snapshot.data!;
                    var filteredFoodList = _filterFoodList(foodList);
                    return ListView.builder(
                      itemCount: filteredFoodList.length,
                      itemBuilder: (context, index) {
                        var foodItem = filteredFoodList[index];
                        return InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodIntake(food: foodItem,))),
                          child: ListTile(
                            title: Text(foodItem.name),
                            subtitle: Text('Calories: ${foodItem.calories}'),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading data'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }

  List<FoodItem> _filterFoodList(List<FoodItem> foodList) {
    if (_searchQuery.isEmpty) {
      return foodList;
    } else {
      return foodList.where((foodItem) {
        return foodItem.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }
}
