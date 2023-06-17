import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stayfit/ui/sleep_tracker.dart';
import 'package:stayfit/ui/steps_tracker.dart';

import '../ui/meal_consumed.dart';
import './table_calendar.dart';

class Progress extends StatefulWidget {

  // const Progress({super.key});
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress>{

  
  DateTime selectedDate = DateTime.now();
  String _stepsCount = '0';
  int _waterIntake = 0;
  String sleep = '';
  double stepPercent = 0.0;
  double sleepPercent = 0.0;
  double caloriePercent =0.0;
  double waterPercent =0.0;
  double calorie=0;

  

  @override
  void initState() {
    super.initState();
   
  }
  
    
  //String formattedDate = "${date.year}-${date.month}-${date.day}";
  
  void _submitStepData() {
    if(int.parse(_stepsCount)<=10000)
    {stepPercent = (int.parse(_stepsCount) /10000) ;
    }
    else{
    stepPercent = 1;
    }
    _updateStep();
  }

  void _submitSleepData(String result){
    List<String> timeComponents = result.split(" ");
    int hour = int.parse(timeComponents[0]);
    sleepPercent = hour/6;
    _updateSleep();
  }

  void caloriesBurnt(){
    int steps= int.parse(_stepsCount);
    calorie = 0.05 * steps;
    if(steps <= 1000)
    {
      caloriePercent = (0.05 * steps)/(0.05*10000);
    }
    else{
      caloriePercent = 1;
    }_updateStep();
  }

  void _updateWaterIntake() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;
    FirebaseFirestore.instance
      .collection('progress')
      .doc(uid) 
      // .collection('dates')
      // .doc(selectedDate.toString())
      .update({'water': _waterIntake,'waterPercent':waterPercent});
    // DocumentReference userRef = FirebaseFirestore.instance.collection('progress').doc(uid);
    // userRef.update({'water': _waterIntake,'waterPercent':waterPercent});
  }
  void _updateSleep() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;
    FirebaseFirestore.instance
      .collection('progress')
      .doc(uid) 
      // .collection('dates')
      // .doc(selectedDate.toString())
      .update({'sleep': sleep,'sleepPercent':sleepPercent});
    // DocumentReference userRef = FirebaseFirestore.instance.collection('progress').doc(uid);
    // userRef.update({'sleep': sleep,'sleepPercent':sleepPercent});

  }
    void _updateStep() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;
    FirebaseFirestore.instance
      .collection('progress')
      .doc(uid) 
      .update({'steps': int.parse(_stepsCount),'stepPercent':stepPercent,'calorie':calorie,'caloriePercent':caloriePercent});
  }

  
final user1 = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('progress').doc(user1.uid).get(),
      builder: (context, snapshot) 
      {
        if(snapshot.connectionState ==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } 
        if(snapshot.connectionState== ConnectionState.done)
        {
          Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
          
          return Scaffold(
          backgroundColor: Colors.blue[50],
        
          body: ListView(
            children: [
              CollapsibleCalendar(text:"Stayfit"),
              Container(
                height: 250,
                width: double.infinity,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //border: Border.all(color: Colors.black45),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(5, 5),blurRadius: 2,)],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularPercentIndicator(
                          radius: 70.0,
                          lineWidth: 6.0,
                          animation: true,
                          percent: 0,
                          center: Text(
                            "Consumed\n 0 cal",
                            style:GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 20.0,)
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.indigo[300]),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:5,bottom: 5,left: 10 ),
                                child: Text("Protein",style: GoogleFonts.poppins(color: Colors.black)),
                              ),
                              LinearPercentIndicator(
                                width: 120.0,
                                lineHeight: 10.0,
                                percent: 0,
                                progressColor: Colors.indigo[300],
                                barRadius: const Radius.circular(10),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5,bottom: 5,left: 10 ),
                                child: Text("Carbs",style: GoogleFonts.poppins(color: Colors.black)),
                              ),
                              LinearPercentIndicator(
                                width: 120.0,
                                lineHeight: 10.0,
                                percent: 0,
                                progressColor: Colors.indigo[300],
                                barRadius: const Radius.circular(10),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5,bottom: 5,left: 10 ),
                                child: Text("Fats",style: GoogleFonts.poppins(color: Colors.black)),
                              ),
                              LinearPercentIndicator(
                                width: 120.0,
                                lineHeight: 10.0,
                                percent: 0,
                                progressColor: Colors.indigo[300],
                                barRadius: const Radius.circular(10),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5,bottom: 5,left: 10 ),
                                child: Text("Fibre",style: GoogleFonts.poppins(color: Colors.black)),
                              ),
                              LinearPercentIndicator(
                                width: 120.0,
                                lineHeight: 10.0,
                                percent: 0,
                                progressColor: Colors.indigo[300],
                                barRadius: const Radius.circular(10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5,),
                          child: Text("Track your meal",style: GoogleFonts.poppins(color:Colors.black87,fontSize: 15),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,right: 25),
                          child: IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MealConsumed(name:" ",calorie:" ")));
                            }, 
                            icon: Icon(Icons.double_arrow_rounded),
                            color: Colors.blue,
                            iconSize: 35,
                            ),
                        )
                      ],
                    )
                  ],
                ),
              ),
             Container(
              margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Other Trackers',
                          style: GoogleFonts.poppins(color: Colors.indigo[700],fontSize: 20,fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    //margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    //border: Border.all(color: Colors.black45),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(5, 5),blurRadius: 2,)],
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 6.0,
                          animation: true,
                          percent:  data?['caloriePercent']?.toDouble()?? 0,
                          center: Icon(FontAwesomeIcons.personRunning,color: Colors.black54,size: 30,),
                          footer: Text(
                            "Calories burnt",
                            style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w300, fontSize: 17.0)
                          ),
                          
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.amberAccent[700]              
                      ),
                      Text('${data?['calorie']?? 0} cal',style: GoogleFonts.poppins(color: Colors.black87),)
                    ],
                  ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    //margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    //border: Border.all(color: Colors.black45),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(5, 5),blurRadius: 2,)],
                  ),
                  child: InkWell(
                    onTap: ()async {
                      _stepsCount= await Navigator.push(context, MaterialPageRoute(builder: (context)=>StepsTracker()));
                      caloriesBurnt();
                      _submitStepData();
                      
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 6.0,
                            animation: true,
                            percent: data?['stepPercent']?.toDouble()?? 0,
                            center: Transform.rotate(angle:30,child: Icon(FontAwesomeIcons.shoePrints,color: Colors.black54,size: 30,)),
                            footer: Text(
                              "Steps tracker",
                              style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w300, fontSize: 17.0)
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.amberAccent[700]                
                            ),
                        Text(data?['steps'] != null ? '${data?['steps']} steps' : '0 steps',style: GoogleFonts.poppins(color: Colors.black87),)
                      ],
                    ),
                  ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(5, 5),blurRadius: 2,)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: IconButton(icon:Icon(FontAwesomeIcons.circleMinus,color: Colors.black,),iconSize:20, 
                      onPressed:() {
                          if (_waterIntake > 0) {
                            setState(() {
                              _waterIntake--;
                            });
                            waterPercent = (_waterIntake /8);
                          }
                          _updateWaterIntake();
                        }
                      ,)),
                      CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 6.0,
                          animation: true,
                          percent: data?['waterPercent']?.toDouble()?? 0,
                          center: Icon(FontAwesomeIcons.glassWaterDroplet,color: Colors.black54,size: 30,),
                          //footer: 
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.amberAccent[700]             
                          ),
                          
                Expanded(child: IconButton(icon:Icon(FontAwesomeIcons.circlePlus,color: Colors.black,),iconSize: 20, 
                onPressed: () {
                  setState(() {
                    _waterIntake++;
                  });
                  waterPercent = (_waterIntake /8);
                  _updateWaterIntake();
                },
                )),]),
                      Text(
                            "Water tracker",
                            style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w300, fontSize: 17.0)
                          ),
                          Text("${data?['water']?? '0'}  glasses",style: GoogleFonts.poppins(color: Colors.black87),)
                    ],
                  ),
                  ),
                  InkWell(
                    onTap: () async {
                      sleep= await Navigator.push(context, MaterialPageRoute(builder: (context)=>SleepTracker()));
                      _submitSleepData(sleep);
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(5, 5),blurRadius: 2,)],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 6.0,
                            animation: true,
                            percent: data?['sleepPercent']?.toDouble()?? 0,
                            center: Icon(FontAwesomeIcons.moon,color: Colors.black54,size: 30,),
                            footer: Text(
                              "Sleep tracker",
                              style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w300, fontSize: 17.0)
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.amberAccent[700]
                            ),
                        Text('${data?['sleep']??'Sleep 6 hrs'}',style: GoogleFonts.poppins(color: Colors.black87),)
                      ],
                    ),
                    ),
                    
                  ),
                ],
              )
            ],
          )
        );}
        
        return Container(); 
        }
    );
  }
}