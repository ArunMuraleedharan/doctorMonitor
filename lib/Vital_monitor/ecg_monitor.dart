



import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:doctor_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:oscilloscope/oscilloscope.dart';

class EcgMonitor extends StatelessWidget {


  double Nheight;
  double width;
  Color s;
  Color l;
  EcgMonitor({required this.width,required this.Nheight,required this.l,required this.s});

  List<double> dta=[];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).orientation==Orientation.portrait?Nheight*0.4:Nheight*.5,
      width: double.infinity,
      // MediaQuery.of(context).orientation==Orientation.portrait? width*0.72:width*0.842,//260,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1)
          ),
          child:Column(
            children: [
              // Text(snapshot.data.docs[9]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  GestureDetector(
                    onTap:(){
                      // context.read(patientProvider).ecg_generator();
                    },
                    child: Container(
                      height: 200,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Consumer(
                          builder: (context, watch, child){
                            // final _ecg=watch(ecgpro);
                            // final _ecg=watch(ecgprovider2);

                            final _ecg=watch(patientProvider);
                            final ymin=context.read(patientProvider).ymin;
                            final ymax=context.read(patientProvider).ymax;
                            final temp=context.read(temperatureprovider2).tp;
                            // print(_ecg.dataToFilter_show.last);

                            return
                              // temp==0?Text("Lead Off ",style: TextStyle(fontSize: 30,color:Colors.white),):
                                Container(
                                  // height: gain?200:150,
                                  // height: 150,
                                  child: Sparkline(
                                    data: _ecg.dataToFilter_show,
                                    enableGridLines: true,
                                    lineColor: Colors.white,
                                    sharpCorners: false,
                                    pointsMode: PointsMode.last,
                                    min:ymin,
                                    max:ymax,
                                    pointColor: Colors.white70,
                                    pointSize: 12,
                                  ),
                                  // child: Oscilloscope(
                                  //     dataSet: _ecg.dataToFilter_show,
                                  //   traceColor: Colors.white,
                                  //   yAxisMax: ymax,
                                  //   yAxisMin: ymin,
                                  // ),
                                );
                              // Text(_ecg.dataToFilter_show.last.toString(),style: TextStyle(color: l),);
                              // Sparkline(
                              //   enableGridLines: true,
                              //   lineColor: Colors.white,
                              //   sharpCorners: false,
                              //   pointsMode: PointsMode.last,
                              //   min:ymin,
                              //   max:ymax,
                              //   pointColor: Colors.white70,
                              //   pointSize: 8,
                              //   data:_ecg.ecg,
                              // );
                          },
                        ),
                      ),
                    ),
                  )
              )
            ],
          )
      ),

    );
  }
}
