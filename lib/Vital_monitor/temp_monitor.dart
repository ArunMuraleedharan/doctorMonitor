


import 'package:doctor_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TempMonitor extends StatelessWidget {
  double Nheight;
  double width;
  Color s;
  Color l;
  TempMonitor({required this.width,required this.Nheight,required this.l,required this.s});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Nheight*0.1,
      width:width*0.33,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(FontAwesomeIcons.thermometerEmpty,
                    color:s,),
                  // Text("TEMP",style: TextStyle(color: l))
                  Text(
                    "\u00B0"+'C',
                    style:
                    TextStyle(color: Colors.white),
                  ),
                ],
              ),
              // Text("0"+"C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),),
          Consumer(
            builder: (context,watch,child) {
              final _temp = watch(temperatureprovider2);
              return
                Text(_temp.tp.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),);
            }
          )
            ],
          )
      ),
    );
  }
}
