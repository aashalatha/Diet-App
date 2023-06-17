import 'package:flutter/material.dart';
import 'package:stayfit/widgets/custom_text.dart';


enum SampleItem { Edit, Delete}

class CustomRow extends StatefulWidget {
  String text;
  String cal;

  CustomRow({
    super.key, required this.cal, required this.text,
  });

  @override
  State<CustomRow> createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(text: widget.text.toString()),
          Row(
            children: [
              MyText(text: widget.cal.toString()),
              PopupMenuButton<SampleItem>(
                initialValue: selectedMenu,
                onSelected: (SampleItem item) {
                  setState(() {
                    selectedMenu = item;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.Edit,
                  child: Text('Edit'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.Delete,
                  child: Text('Delete'),
                ),
                ],
              )
            ]
          )
        ],
      ),
    );
  }
}
