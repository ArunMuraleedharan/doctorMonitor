



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../main.dart';

class BpMonitor extends StatelessWidget {

  double Nheight;
  double width;
  Color s;
  Color l;
  BpMonitor({required this.width,required this.Nheight,required this.l,required this.s});


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
                  SvgPicture.asset("assets/BPICON.svg",color:s,width: 20,height: 20,),

                  Text("BP",style: TextStyle(color: l),)
                ],
              ),

              // Text("120/80",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),),

              Consumer(
                  builder: (context,watch,child) {
                    final _sys = watch(systolicprovider2);
                    final _dia = watch(diastolicprovider2);
                    return
                      Text(_sys.systolic.toInt().toString()+"/"+_dia.diastolic.toInt().toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),);
                  }
              )
            ],
          )
      ),
    );
  }
}
