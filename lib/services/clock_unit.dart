import "package:flutter/Material.dart";
import 'dart:math';


Color boxColor = Colors.black12;        //default color

//Function converts a single digit of decimal-radix to binary string 
String toBinaryConverter(String decimalCharacter){
    int decimal = int.parse(decimalCharacter);
    String result = '';
    for(int i = 0; i < 4;  i++ ){
        int bit = decimal % 2;
        result = bit.toString() + result;
        decimal ~/= 2;
    }
    return result;
}

//Number of Row calculator function
int rowCalc(String unitChar){
  switch (unitChar) {
    case 'H': return 2;
    case 'h': return 4;
    case 'M': return 3;
    case 'm': return 4;
    case 'S': return 3;
    case 's': return 4;
    default:  return 4;
  }
}

//Color Picker
Color colorPicker(String unit){
  switch (unit){
    case "H" : return Colors.indigoAccent;
    case "h" : return Colors.lightBlue;
    case "M" : return Colors.orange;
    case "m" : return Colors.orangeAccent;
    case "S" : return Colors.pink;
    case "s" : return Colors.pinkAccent;
    default: return Colors.blueAccent;
  }
}
Widget columnBoxes (String value, String unitChar){
  List<Widget> boxes = [];
  String binarySequence = toBinaryConverter(value);
  int rowSize = rowCalc(unitChar);
  for(int i = 0; i < rowSize; i++){
    boxes.add(Container(
      margin: EdgeInsets.fromLTRB(20,10, 20, 10),
      width: 30,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: binarySequence[3-i]=='0' ? Colors.black26 : colorPicker(unitChar),
      ),
      child: Center(
        child: Text(
          pow(2, i).toString(),
          style: TextStyle(
            color: binarySequence[3-i]=='0' ? Colors.grey.withOpacity(0.4): Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    ),
    );
  }
  boxes = boxes.reversed.toList();
  return Column(children: boxes);
}

class ClockUnit extends StatelessWidget {

  final String clockUnitChar;
  final String clockUnitValue;

  const ClockUnit(this.clockUnitChar, this.clockUnitValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: ( <Widget>[
        Text(clockUnitChar),
        columnBoxes(clockUnitValue, clockUnitChar),
        Text(toBinaryConverter(clockUnitValue)),
      ]
      ),
    );
  }
}