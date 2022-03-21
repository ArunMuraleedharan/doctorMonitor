



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class HeartBeatMonitor extends StatelessWidget {

  double Nheight;
  double width;
  Color s;
  Color l;
  HeartBeatMonitor({required this.width,required this.Nheight,required this.l,required this.s});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: Nheight*0.1,
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
                  Icon(FontAwesomeIcons.heartbeat,
                    color: s,),
                  Text("BPM",style: TextStyle(color: l),)
                ],
              ),
              // SizedBox(height: 30,),
              // Text("80",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),),
              Consumer(
                builder: (context,watch,child) {
                  final _heartbeat = watch(heartbeats2);
                  return Text(_heartbeat.hb.toInt().toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),);
                  }
              )
            ],
          )
      ),
    );
  }
}
