import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stayfit/ui/search.dart';
import '../widgets/custom_text.dart';

class MealHeading extends StatelessWidget {
  final String title;
  // final String mincal;
  // final String maxcal;

  const MealHeading({
    super.key,
    required this.title,
    // required this.mincal,
    // required this.maxcal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleText(text: title,),
          // Row(
          //   children: [
          //     CalCount(cal:mincal),
          //     CalCount(cal:" of "),
          //     CalCount(cal: maxcal),
          //     IconButton(icon:Icon(FontAwesomeIcons.circlePlus,color: Colors.black,), onPressed: () { 
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodSearchScreen()));
          //      },),
          //   ],
          // ),
        ],
      )
    );
  }
}