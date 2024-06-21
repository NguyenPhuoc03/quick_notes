import 'package:flutter/material.dart';
import 'package:quick_notes/styles/style_app.dart';

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
    return Container(
      height: 175,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (int i = 0; i < AppStyle.cardsColor.length; i++)
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
                  color: AppStyle.cardsColor[i],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Icon(
                  Icons.notes,
                  size: 50,
                  weight: 200,
                  color: AppStyle.textCardColor[i],
                ),
              ),
            )
        ],
      ),
    );
  }
}
