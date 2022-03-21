



import 'package:doctor_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Spo2Monitor extends StatelessWidget {
  double Nheight;
  double width;
  Color s;
  Color l;
  Spo2Monitor({required this.width,required this.Nheight,required this.l,required this.s});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Nheight*0.1,
      width:width*0.33,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1)
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment
                .start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(FontAwesomeIcons.tint,
                    color: s,),
                  Text("SPO2%",style: TextStyle(color: l),)
                ],
              ),

              // Text("95"+"%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),),
              Consumer(
                  builder: (context,watch,child) {
                    final _saturation = watch(saturation2);
                    return
                      Text(_saturation.spo2.toInt().toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),);
                  }
              )
            ],
          )
      ),
    );
  }
}
