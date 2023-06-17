import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const MyText({
    Key? key,
    required this.text,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(text ,style:GoogleFonts.poppins(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600));
  }
}

class CalCount extends StatelessWidget {
  final String cal;
  
  const CalCount({
    required this.cal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(cal,style: GoogleFonts.poppins(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),);
  }
}