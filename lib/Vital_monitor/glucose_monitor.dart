



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../main.dart';

class GlucoseMonitor extends StatelessWidget {

  double Nheight;
  double width;
  Color s;
  Color l;
  GlucoseMonitor({required this.width,required this.Nheight,required this.l,required this.s});


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: Nheight*0.13,
      width:width*0.33,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1)
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment
                .start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset("assets/glucose-meter.svg",color:s,width: 20,height: 20,),

                  Text("Glucose",style: TextStyle(color: l),)
                ],
              ),

              // Text("120/80",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),),

              Consumer(
                  builder: (context,watch,child) {
                    final _glucose = watch(glucoseprovider2).gl;
                    return
                      Text(_glucose.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),);
                  }
              ),
              Consumer(
                builder: (context,watch,child){
                  final bmi=watch(bmiprovider2).bmi;
                  final time=watch(timeprovider2).time;
                  return Container(
                    child: Column(
                      children: [
                        Text(time,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("BMI",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                            Text(bmi.toStringAsFixed(1) ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          )
      ),
    );
  }
}
