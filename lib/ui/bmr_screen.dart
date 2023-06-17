import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stayfit/ui/homepage.dart';

class BMRScreen extends StatefulWidget {
  final double bmr;
  
  const BMRScreen({super.key,required this.bmr});
  @override
  _BMRScreenState createState() => _BMRScreenState();
}

class _BMRScreenState extends State<BMRScreen> {
  bool isLoading = true; // Set the initial loading state to true
  DateTime selectedDate= DateTime.now();

   
  // Function to simulate loading delay
  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a 2-second loading delay
    setState(() {
      isLoading = false; // Set loading state to false after loading is complete
    });
  }

  @override
  void initState() {
    super.initState();
    loadData(); // Call the function to start loading data
  }

  
void submitDataToFirebase() {
  
  final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;

  Map<String, dynamic> data = {
    'steps': 0,
    'stepPercent':0,
    'sleep': 0,
    'calorie': 0,
    'caloriePercent': 0,
    'water':0,
    'waterPercent':0,
    'sleepPercent':0,
  };
  
  FirebaseFirestore.instance
      .collection('progress')
      .doc(uid)
      .set(data);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: 
      isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You can consume",style:GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 26,color: Colors.black87),),
              ],
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.bmr.toString()} Cal",style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 26,color: Colors.black87),),
                ],
              ),
              SizedBox(height: 30,),
              Row 
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    submitDataToFirebase();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
                  }, 
                  style: ElevatedButton.styleFrom(minimumSize: Size(200,50),backgroundColor: Colors.indigo[900]),
                  child: Text("Let's Begin",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 20),))
              ],)
            ],
          ),
    );
  }
}
