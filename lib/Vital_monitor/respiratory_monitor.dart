





import 'package:doctor_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RespiratoryMonitor extends StatelessWidget {
  double Nheight;
  double width;
  Color s;
  Color l;
  RespiratoryMonitor({required this.width,required this.Nheight,required this.l,required this.s});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround,
                children: [
                  Icon(FontAwesomeIcons.lungs,
                    color: s,),
                  Text("RR",
                      style: TextStyle(color: l))
                ],
              ),
              // Text(
              //   "19",
              //   style: TextStyle(fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //       color: l),
              // ),

              Consumer(
                  builder: (context,watch,child) {
                    final _rr = watch(respirationprovider2);
                    return
                      Text(
                        _rr.respiration.toString(),
                        style: TextStyle(fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: l),
                      );
                  }
              )
            ],
          )

      ),
    );
  }
}
