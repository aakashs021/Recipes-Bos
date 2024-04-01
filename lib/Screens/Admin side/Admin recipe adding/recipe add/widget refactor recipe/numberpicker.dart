import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

// ignore: must_be_immutable
class Numberpicker extends StatefulWidget {
   int hour;
   int min;
    Function(int) onhourchange;
   Function(int) onminchange;
   Numberpicker({super.key,required this.hour,required this.min,required this.onhourchange, required this.onminchange });

  @override
  State<Numberpicker> createState() => _NumberpickerState();
}

class _NumberpickerState extends State<Numberpicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue[100],),
      
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              NumberPicker(
                step: 1,
                infiniteLoop: true, haptics: true, minValue: 0, maxValue: 12, value: widget.hour, onChanged: (value) {
                setState(() {
                  widget.hour=value;
                });
                widget.onhourchange(value);
              },),
          text(name: 'Hour'),
            ],
          ),
          Column(
            children: [
              NumberPicker(infiniteLoop: true, haptics: true, minValue: 0, maxValue: 60, value: widget.min, onChanged: (value) {
                setState(() {
                  widget.min=value;
                });
                widget.onminchange(value);
                  
              },),
          text(name: 'Minutes'),
            ],
          ),
        ],
      ),
    );
  }
}