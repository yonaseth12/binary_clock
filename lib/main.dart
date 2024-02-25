import "package:flutter/material.dart";
import "package:flutter/services.dart" show SystemChrome, DeviceOrientation;
import 'package:binary_clock/services/clock_unit.dart';

import 'dart:async';

//Function takes at most two digit number and convert it to two character string
String intToString(int intData) {
    return (intData<10) ? ('0'+intData.toString()) : intData.toString();
}


late int hour, minute, second;
late String hourString, minuteString, secondString;
late String H, h, M, m, S, s;
late List ClockCharList;        //List of the character and the string form of the decimal single digit

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  return runApp(BinaryClock());

}


class BinaryClock extends StatefulWidget{
  @override
  State<BinaryClock> createState() => _BinaryClockState();
}

class _BinaryClockState extends State<BinaryClock>{
  
  DateTime now = DateTime.now();

  @override
  void initState(){
    super.initState();
    Timer.periodic(Duration(seconds: 1), (v) {
      setState((){
        now = DateTime.now(); 
      }
      );
    });
  }
  @override
  Widget build(BuildContext context){

    hour = now.hour;
    minute = now.minute;
    second = now.second;

    hourString = intToString(hour);
    minuteString = intToString(minute);
    secondString = intToString(second);

    H = hourString[0];
    h = hourString[1];
    M = minuteString[0];
    m = minuteString[1];
    S = secondString[0];
    s = secondString[1];
    ClockCharList = [['H',H] , ['h',h], ['M',M], ['m',m], ['S',S], ['s',s]];

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          displayMedium: TextStyle(color: Colors.black38, fontSize: 30), 
        ),
        fontFamily: 'Altasi',

      ),
      home: Scaffold(
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "$hourString : $minuteString : $secondString",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: Colors.blueAccent,
                  fontSize: 40,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end ,
              children: ClockCharList.map((charPair) => ClockUnit(charPair[0], charPair[1])).toList(),
            ),
          ],
        ),
      )
    );
  }
}