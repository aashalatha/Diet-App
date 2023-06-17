import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollapsibleCalendar extends StatefulWidget {
  final String text;

  CollapsibleCalendar({Key? key, required this.text}) : super(key: key);
  @override
  _CollapsibleCalendarState createState() => _CollapsibleCalendarState();
}

class _CollapsibleCalendarState extends State<CollapsibleCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: InkWell(
              onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
              child: Row(
                children: [
                  textWidget(text: widget.text),
                  SizedBox(width:15),
                  Icon(_isExpanded ? Icons.expand_less : Icons.expand_more,color: Colors.black,size: 35,),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isExpanded ? 150 : 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.now(),
                    focusedDay: _focusedDay,
                    calendarFormat: CalendarFormat.week,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final User? user = auth.currentUser;
                      final String? uid = user?.uid;
                    },
                    headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                   ),
                  ),
                  
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('progress')
                        .where('date', isEqualTo: _selectedDay)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final events = snapshot.data!.docs;
                        return Column(
                          children: events
                              .map(
                                (event) => ListTile(
                                  title: Text("data"),
                                  subtitle: Text("data"),
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}

class textWidget extends StatelessWidget {
  final String text;
  const textWidget({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}