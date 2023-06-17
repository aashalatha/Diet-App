import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SleepTracker extends StatefulWidget {
  const SleepTracker({super.key});

  @override
  State<SleepTracker> createState() => _SleepTrackerState();
}

class _SleepTrackerState extends State<SleepTracker> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TimeOfDay stime = TimeOfDay.now();
  TimeOfDay wtime = TimeOfDay.now();

  TextEditingController _sleepDurationController = TextEditingController();
  TextEditingController _sleepQualityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final shours = stime.hour.toString().padLeft(2,'0');
    final sminutes = stime.minute.toString().padLeft(2,'0');

    
    final whours = wtime.hour.toString().padLeft(2,'0');
    final wminutes = wtime.minute.toString().padLeft(2,'0');

   String wtimeString = wtime.format(context);
   String stimeString = stime.format(context);
   
  //  log(stimeString);
  //  log(wtimeString);
   List<String> stimeComponents = stimeString.split(":");
   int shour = int.parse(stimeComponents[0]);
   String sminuteString = stimeComponents[1].split(" ")[0];
   int sminute = int.parse(sminuteString);
   bool isPM1 = stimeString.endsWith("PM");
   if (isPM1 && shour != 12) {
    shour += 12;
  }
  //  log(shour.toString());
  //  log(sminute.toString());

   List<String> wtimeComponents = wtimeString.split(":");
   int whour = int.parse(wtimeComponents[0]);
   String wminuteString = wtimeComponents[1].split(" ")[0];
   int wminute = int.parse(wminuteString);
   bool isPM2 = wtimeString.endsWith("PM");
   if (isPM2 && whour != 12) {
    whour += 12;
  }
  
  //  log(whour.toString());
  //  log(wminute.toString());

   // Calculate time difference in minutes
  int differenceMinutes = (whour * 60 + wminute) - (shour * 60 + sminute);
  
  // Handle cases where the time difference crosses midnight
  if (differenceMinutes < 0) {
    differenceMinutes += 24 * 60;
  }
  
  // Convert minutes to hours and minutes
  int differenceHours = differenceMinutes ~/ 60;
  int remainingMinutes = differenceMinutes % 60;
  
  String concatenatedString = '$differenceHours hr $remainingMinutes min';
  //log("$differenceHours hours $remainingMinutes minutes");

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Sleep Tracker',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                stimeString,
                style: GoogleFonts.poppins(fontSize: 32),
              ),
              Text(
                wtimeString,
                style: GoogleFonts.poppins(fontSize: 32),
              ),
            ],
          ),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.indigo[700])),
                onPressed: ()async{
                  sleepTime();
                }, 
                child: Text("Sleeping Time",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600),)),
              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.indigo[700])),
                onPressed: ()async{
                  wakeTime();
                }, 
                child: Text("Wake up Time")),
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total Sleeping Time",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$differenceHours hours $remainingMinutes minutes",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 26))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context, concatenatedString);
              }, child: Text("Done"))
            ],
          )
        ],
      ),);
  }
  
  Future<void> sleepTime()async{
    TimeOfDay? picked = await showTimePicker(
      context: context, 
      initialTime: stime
      );
      if (picked != null){
        setState(() {
          stime = picked;
        });
      }
  }
  Future<void> wakeTime()async{
    TimeOfDay? picked = await showTimePicker(
      context: context, 
      initialTime:wtime,
      
      );
      if (picked != null){
        setState(() {
          wtime = picked;
        });
      }
  }
  /* void _submitSleepData() async {
    try {
      double sleepDuration = double.parse(_sleepDurationController.text);
      int sleepQuality = int.parse(_sleepQualityController.text);

      await firestore.collection('sleepData').add({
        'sleepDuration': sleepDuration,
        'sleepQuality': sleepQuality,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sleep data submitted successfully!'),
        ),
      );

      _sleepDurationController.clear();
      _sleepQualityController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting sleep data.'),
        ),
      );
    }
  } */
}


