import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/src/services/text_formatter.dart';
import 'package:stayfit/login_page.dart';
import 'package:stayfit/signup_page.dart';
import 'dart:developer';

import 'package:stayfit/ui/homepage.dart';

import 'bmr_screen.dart';


class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  
  final user = FirebaseAuth.instance.currentUser!;
  int _index = 0;
  double bmr = 0.0;
  bool isCompleted = false;
  bool _isLoading = false;
  String selectedValue='';
  String selectionValue = '';
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List _list = [];
  List <bool>selected= [];
  final List _listString = ["Hypertension","Cholestrol","Stress/Anxiety","Diabetes","Thyroid","PCOD","None"];
  String choiceValue='';

  final List _list1 = [];
  List <bool>selected1= [];
  final List _listString1= ["None","Poultary","Pork","Egg", "Lamb/Mutton","Beef",
    "Gluten","Lactose", "Nuts","Soy", "Seafood"];
  
 
  @override
  void initState(){
    super.setState(() {
      for(int i =0;i<_listString.length;i++){
        _list.insert(0, '${_listString[i]}');
        selected.insert(0, false);
      }
      for(int i =0;i<_listString1.length;i++){
      _list1.insert(0, '${_listString1[i]}');
      selected1.insert(0, false);
    }
    });
    
  }
    

  void signUpDetails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference collectionRef = firestore.collection('users');
    final CollectionReference newCollection = firestore.collection('user details');
    
    int age = int.parse(_ageController.text);
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);
    int calc_bmr=0;
    List allergy = [];
    List condition =[];

    bmr = 66.47 + (13.75 * weight) + (5 * height) - (6.75 * age);

    if (selectedValue == "Fat Loss"){
      calc_bmr = (((bmr/100).floor()*100) - 200);
    }
    else if(selectedValue == "Muscle Gain"){
      calc_bmr = (((bmr/100).floor()*100) + 200);
    }
    else{
      calc_bmr = (((bmr/100).floor()*100));
    }

    for(int i =0; i<selected.length;i++){
      if(selected[i]){
        allergy.add(_list[i]);
      }
    }

    for(int i =0; i<selected1.length;i++){
      if(selected1[i]){
        condition.add(_list1[i]);
      }
    }

  void insertData() {
  collectionRef
    .doc(uid)
    .get()
    .then((DocumentSnapshot userSnapshot) {
      if (userSnapshot.exists) {
        newCollection
          .doc(uid)
          .set({
            'goal': selectedValue,
            'age': int.parse(_ageController.text),
            'height': int.parse(_heightController.text),
            'weight': int.parse(_weightController.text),
            'activity': double.parse(selectionValue),
            'condition': condition,
            'diet': choiceValue,
            'allergy': allergy,
            'bmr':calc_bmr
          })
          .then((value) => log("Data inserted successfully"))
          .catchError((error) => log("Failed to insert data: $error"));
      } else {
        log("User document not found");
      }
    })
    .catchError((error) => log("Failed to retrieve user document: $error"));
}

  insertData();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading=true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing')),
        );
    } 
    else {
    setState(() {
      _isLoading = false;
    });
    return;
  }
      Map<String, dynamic> userData = {
      'goal': selectedValue,
      'age': _ageController.text,
      'height': _heightController.text,
      'weight': _weightController.text,
      'activity': selectionValue,
      'condition': selected,
      'diet': choiceValue,
      'allergy': selected1,
    };
    log(userData.toString());
    
      
        // Document exists, perform the update here
        try{
        //await userDocument.update(userData);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Added Successfully')),
          );
           Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => BMRScreen(bmr:bmr))); 
      
        }
      catch(e){
      final result = e.toString();
      log(result);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unsuccessful')),
          );
          Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => SignupPage())); 
      
      }    
    
  }



  Widget controlsBuilder(context,details){
    final isLastStep = _index == 7;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if(!isLastStep)
        ElevatedButton(onPressed: details.onStepContinue, 
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
        child: Text("NEXT"),),
        if(isLastStep)
        ElevatedButton(onPressed: signUpDetails, 
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
        child: _isLoading?Center(
          child: CircularProgressIndicator(
          color: Colors.white,
          ),)
          :Text("CONFIRM"),),
        if(_index != 0)
        OutlinedButton(onPressed: details.onStepCancel, 
        style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1.0, color: Colors.black)),
        child:const Text("BACK",style: TextStyle(color: Colors.black),),),
        
      ],
    );      
  }
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context,snapshot){
          Map<String,dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
          return Scaffold(
      appBar: AppBar(title: Text("Stay Fit",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),),
      backgroundColor: Colors.blue[50],
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                controlsBuilder: controlsBuilder,
                currentStep: _index,
                onStepCancel: () {
                  _index == 0 ? null : ()=>
                  setState(() {
                    _index -= 1;
                  });
                },
                onStepContinue: () {
                  final isLastStep = _index == 7;
                  if(isLastStep){
                    setState(() {
                      isCompleted = true;
                    });
                    print("Completed");
                  }else{
                    setState(() {
                    _index +=1;
                  });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: <Step>[
                  Step(
                    isActive: _index >= 0,
                    title:  Text(
                    'What brings you here?',
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile<String>(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      title: Text(
                        'Fat Loss',
                        style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      value: 'Fat Loss',
                      groupValue: selectedValue,
                      onChanged:(value) => setState(() {
                        selectedValue = value.toString();
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile<String>(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      title: Text(
                        'Weight Maintenance',
                        style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      value: 'Weight Maintenance',
                      groupValue: selectedValue,
                      onChanged: (value) => setState(() {
                        selectedValue = value.toString();
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile<String>(
                      tileColor: Colors.white,
                      title: Text(
                        'Muscle Gain',
                        style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      value: 'Muscle Gain',
                      groupValue: selectedValue,
                      onChanged: (value) => setState(() {
                        selectedValue = value.toString();
                      }),
                    ),
                  )
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: _index >= 1,
                    title: Text(
                          'Your Current Age',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    content: Padding(
                      padding: EdgeInsets.only(left: 100,right: 120),
                      child: TextField(
                        controller: _ageController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2)
                        ],
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                  Step(
                    isActive: _index >= 2,
                    title: Text(
                          'How tall are you?',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ), 
                    content: 
              Padding(
                padding: EdgeInsets.only(left: 100,right: 120),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3)
                  ],
                  controller: _heightController,
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
                ),
                Step(isActive: _index >= 3,
                title: Text(
                          'What\'s your Current weight?',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),  
                 content: Padding(
                padding: EdgeInsets.only(left: 100,right: 120),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3)
                  ],
                  controller: _weightController,
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
                ),
                Step(
                  isActive: _index >= 4,
                  title: Text(
                      'Daily Activity',
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ), 
                content: Column(children: [Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile<String>(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    title: Text('Sedentary',style: GoogleFonts.poppins(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.w500),),
                    subtitle: Text("Little or no physical activity",style: GoogleFonts.poppins()),
                    value: '1.2',
                    groupValue: selectionValue,
                    onChanged: (value)=> setState(() {
                      selectionValue = value.toString();
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile<String>(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    title: Text('Lightly Active',style: GoogleFonts.poppins(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.w500),),
                    subtitle: Text(" Physical activity for 1-2 days a week",style: GoogleFonts.poppins()),
                    value: '1.375',
                    groupValue: selectionValue,
                    onChanged: (value)=> setState(() {
                      selectionValue = value.toString();
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile<String>(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    title: Text('Moderately Active',style: GoogleFonts.poppins(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.w500),),
                    subtitle: Text("Physical activity for 3-5 days a week",style: GoogleFonts.poppins(),),
                    value: '1.55',
                    groupValue: selectionValue,
                    onChanged: (value)=> setState(() {
                      selectionValue = value.toString();
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile<String>(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    title: Text('Very Active',style: GoogleFonts.poppins(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.w500),),
                    subtitle: Text('Physical activity every day',style: GoogleFonts.poppins(),),
                    value: '1.725',
                    groupValue: selectionValue,
                    onChanged: (value)=> setState(() {
                      selectionValue = value.toString();
                    }),
                  ),
                ),])
                ),
                Step(isActive: _index >= 5,
                title: Text(
                      'Any Medical Conditions',
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                 content: Center(
                  child: _list.isNotEmpty?
                      Wrap(
                        children:_list.map((item) {
                          var index = _list.indexOf(item);
                          return IntrinsicWidth(
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Card(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),),
                                child: InkWell(
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: selected[index], 
                                        onChanged: (val){
                                          setState(() {
                                            selected[index] = val!;
                                          });
                                        }
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:12.0),
                                            child: Expanded(child: Text(item,style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w500),)),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }) .toList(),
                      ):Container(),
                ),),
                Step(isActive: _index >= 6,
                title: Text(
                        'What diet do you prefer?',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                 content: Column(
                  children: [
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(1,1),blurRadius: 2,)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: RadioListTile<String>(
                        title: Text('Vegetarian',style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w500),),
                        value: 'Vegetarian',
                        
                        groupValue: choiceValue,
                        onChanged:(value) => 
                          setState(() {
                          choiceValue = value.toString();
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(1,1),blurRadius: 2,)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: RadioListTile<String>(
                        title: Text('Eggetarian',style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w500),),
                        value: 'Eggetarian',
                        groupValue: choiceValue,
                        onChanged: (value) => 
                          setState(() {
                          choiceValue = value.toString();
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2),offset: Offset(1,1),blurRadius: 2,)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: RadioListTile<String>(
                        title: Text('Non-vegetarian',style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w500),),
                        value: 'Non-vegetarian',
                        groupValue: choiceValue,
                        onChanged: (value) => 
                          setState(() {
                          choiceValue = value.toString();
                        }),
                      ),
                    ), 
                  ),
                  ],
                 )),
                 Step(isActive: _index >= 7,
                 title: Text(
                        'Do you have any allergies?',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  content: Center(
                    child: _list1.isNotEmpty?
                        Wrap(
                          children:_list1.map((item) {
                            var index = _list1.indexOf(item);
                            return IntrinsicWidth(
                              child: SizedBox(
                                width: 120,
                                height: 50,
                                child: Card(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),),
                                  child: InkWell(
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: selected1[index], 
                                            onChanged: (val){
                                              setState(() {
                                                selected1[index] = val!;
                                              });
                                            }
                                            ),
                                            Expanded(child: Text(item,style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w500),)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }) .toList(),
                        ):Container(),
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
      }
      );
  }
}