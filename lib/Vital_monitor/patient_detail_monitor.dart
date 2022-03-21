


import 'package:doctor_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDetailMonitor extends StatelessWidget {
  double Nheight;
  double width;
  Color s;
  Color l;

  PatientDetailMonitor({required this.width,required this.Nheight,required this.l,required this.s});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Nheight*0.22,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text("Name: ",style: TextStyle(color: Colors.white,fontSize: 20),),
                  // Text("Arun",style: TextStyle(color: l,fontSize: 20),),

                  Consumer(
                      builder: (context,watch,child) {
                        final _name = watch(nameprovider2);
                        return
                          Text(_name.name,style: TextStyle(color: l,fontSize: 20),);
                      }
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Age: ",style: TextStyle(color: l),),
                          Consumer(
                              builder: (context,watch,child) {
                                final _age = watch(ageprovider2);
                                return
                                  Text(_age.age.toInt().toString(),style: TextStyle(color: l));
                              }
                          ),

                          // Text( " "+"26",style: TextStyle(color: l,),)

                        ],
                      ),

                      SizedBox(
                        height: Nheight*0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("FileNo:",style: TextStyle(color: l),),
                          Consumer(
                              builder: (context,watch,child) {
                                final _file = watch(fileprovider2);
                                return
                                  Text(_file.fileNo,style: TextStyle(color: l));
                              }
                          ),
                          // Text("10",style: TextStyle(color:l),),
                        ],
                      ),
                    ],
                  ),

                ],

              ),

              //
              SizedBox(
                width: width,
                height: Nheight*0.08,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),color: Colors.black,
                    ),
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child:  Consumer(
                            builder: (context,watch,child) {
                              final _remarks = watch(remarksprovider2);
                              return
                                Text("Remarks: "+_remarks.remarks,overflow:  TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: l),);
                            }
                        ),

                      ),
                    )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
