import 'package:flutter/material.dart';
import 'package:stayfit/widgets/custom_text.dart';



class FoodRow extends StatefulWidget {
  final String text;

  FoodRow({
    super.key,  required this.text,
  });

  @override
  State<FoodRow> createState() => _FoodRowState();
}

class _FoodRowState extends State<FoodRow> {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(text: widget.text),
          // Row(
          //   children: [
          //     MyText(text: widget.cal),
          //     PopupMenuButton<SampleItem>(
          //       initialValue: selectedMenu,
          //       onSelected: (SampleItem item) {
          //         setState(() {
          //           selectedMenu = item;
          //         });
          //       },
          //       itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          //       const PopupMenuItem<SampleItem>(
          //         value: SampleItem.Edit,
          //         child: Text('Edit'),
          //       ),
          //       const PopupMenuItem<SampleItem>(
          //         value: SampleItem.Delete,
          //         child: Text('Delete'),
          //       ),
          //       ],
          //     )
          //   ]
          // )
        ],
      ),
    );
  }
}
