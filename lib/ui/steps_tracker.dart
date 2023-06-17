import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class StepsTracker extends StatefulWidget {
  const StepsTracker({super.key});

  @override
  State<StepsTracker> createState() => _StepsTrackerState();
}

class _StepsTrackerState extends State<StepsTracker> {

  final _stepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Steps Tracker',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Walk 10,000 steps",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 24),),
          SizedBox(height: 70,),
          Text("Enter the number of steps:",style: GoogleFonts.poppins(color: Colors.indigo,fontWeight: FontWeight.w600,fontSize: 20),),
          Padding(
            padding: const EdgeInsets.fromLTRB(100,20,100,10),
            child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5)
                  ],
                  controller: _stepController,
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
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
            onPressed: (){
              Navigator.pop(context, _stepController.text);
            }, 
            child: Text("Done")
            )
        ],
      ),
    );
  }
}