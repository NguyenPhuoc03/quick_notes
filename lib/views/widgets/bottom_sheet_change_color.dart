import 'package:flutter/material.dart';
import 'package:quick_notes/styles/notes_colors_styles.dart';

class BottomSheetChangeColor extends StatefulWidget {
  //final ValueChanged<Color?> onColorSelected;
  final ValueChanged<int?> onColorSelected;
  const BottomSheetChangeColor({super.key, required this.onColorSelected});

  @override
  State<BottomSheetChangeColor> createState() => _BottomSheetChangeColorState();
}

class _BottomSheetChangeColorState extends State<BottomSheetChangeColor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (int i = 0; i < StyleNotes.cardsColor.length; i++)
            //for (var color in AppStyle.cardsColor)
            GestureDetector(
              onTap: () {
                //widget.onColorSelected(color);
                widget.onColorSelected(i);
                Navigator.pop(context);
              },
              child: Container(
                width: 120,
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: StyleNotes.cardsColor[i],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Icon(
                  Icons.notes,
                  size: 50,
                  weight: 200,
                  color: StyleNotes.textCardColor[i],
                ),
              ),
            )
        ],
      ),
    );
  }
}
