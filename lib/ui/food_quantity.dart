import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stayfit/models/food_details.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:stayfit/ui/meal_consumed.dart';
import 'package:stayfit/widgets/custom_row.dart';

class FoodIntake extends StatefulWidget {
  final FoodItem food;
  const FoodIntake({super.key,required this.food});

  @override
  State<FoodIntake> createState() => _FoodIntakeState();
}

class _FoodIntakeState extends State<FoodIntake> {
  List<String> availableMeasurements = [];
  String? selectedValue;
  final _measureController = TextEditingController();
  int calories = 0;
  @override
  void initState()
  {
    super.initState();
    _fetchFoodData();
  }

void submitData(){
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final String? uid = user?.uid;

  Map<String, dynamic> data = {
    'foodname':widget.food.name,
    'calories':widget.food.calories,
    'carbohydrates':widget.food.nutrition.carbohydrates,
    'protein':widget.food.nutrition.protein,
    'fat':widget.food.nutrition.fat,
    'fiber':widget.food.nutrition.fiber,
    'quantity':_measureController.text
  };

  FirebaseFirestore.instance
      .collection('consumption')
      .doc(uid) 
      .set(data);
}
void _fetchFoodData(){
  Measurements measurements = widget.food.measurements;
  if(measurements.bowl != null){
    availableMeasurements.add(measurements.bowl.toString());
  }
  if(measurements.cup != null){
    availableMeasurements.add(measurements.cup.toString());
  }
  if(measurements.plate != null){
    availableMeasurements.add(measurements.plate.toString());
  }
  if(measurements.serving != null){
    availableMeasurements.add(measurements.serving.toString());
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title:Text(widget.food.name.toString(),style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20))
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Calories: 🔥${widget.food.calories}",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w500),),
                ],
              ),
              SizedBox(height: 15,),
        
              Row(
                children: [
                  Text("Protein:",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                  Text("${widget.food.nutrition.protein.toString()} g",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Text("Carbohydartes:",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
              Text(" ${widget.food.nutrition.carbohydrates.toString()} g",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                ],
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Fat:",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                  Text("${widget.food.nutrition.fat.toString()} g",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                ],
              ),
              Row(
                children: [
                  Text("Fiber:",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                  Text("${widget.food.nutrition.fiber.toString()} g",style: GoogleFonts.poppins(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                ],
              ),
              SizedBox(height: 12,),
              Text('Measurements:',style: GoogleFonts.poppins(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w500),),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width:100,
                    //padding: const EdgeInsets.all(10.0),
                    child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3)
                    ],
                    controller: _measureController,
                    cursorColor: Colors.grey,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                      ),
                    ),
                                  ),
                  ),
                  DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
                  children: const[
                    Icon(
                      Icons.list,
                      size: 16,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
            ),
            items: availableMeasurements
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
            value: selectedValue,
            onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
            },
            buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: 160,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.white,
                  ),
            ),
            iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  padding: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey,
                  ),
                  elevation: 8,
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
            ),
            menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                submitData();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MealConsumed(name:widget.food.name,calorie : widget.food.calories.toString())));
              }, child: Text("Track Food"))
            ],
          ),
          )
        ],
      ),
    );
  }
}