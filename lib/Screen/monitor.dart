

import 'package:doctor_monitor/Vital_monitor/PdfReport.dart';
import 'package:doctor_monitor/Vital_monitor/bp_monitor.dart';
import 'package:doctor_monitor/Vital_monitor/ecg_monitor.dart';
import 'package:doctor_monitor/Vital_monitor/glucose_monitor.dart';
import 'package:doctor_monitor/Vital_monitor/heartbeat_monitor.dart';
import 'package:doctor_monitor/Vital_monitor/patient_detail_monitor.dart';
import 'package:doctor_monitor/Vital_monitor/respiratory_monitor.dart';
import 'package:doctor_monitor/Vital_monitor/spo2_monitor.dart';
import 'package:doctor_monitor/Vital_monitor/temp_monitor.dart';
import 'package:doctor_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:oscilloscope/oscilloscope.dart';

class Monitor extends StatefulWidget {



  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  Color l=Colors.white;

  Color s=Colors.blue;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    var padding=MediaQuery.of(context).padding;
    double height=MediaQuery.of(context).size.height;
    double Nheight=height-padding.top-padding.bottom;

    return WillPopScope(
      onWillPop: ()async
      {
        context.read(patientProvider).cancel_monitor();
        context.read(patientProvider).timer_cancel=true;
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // SizedBox(width: MediaQuery.of(context).size.width*0.2,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("IQRAA  "),
                  Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
                ],
              ),
            ],
          ),

          backgroundColor:Colors.blue,
          // Colors.green[900],
        ),
        drawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("IQRAA  "),
                      Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
                    ],
                  ),
                ],
              ),

              backgroundColor:Colors.blue,
              // Colors.green[900],
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Reportpdf()
                  ],
                ),
              ),
            ),
          ),
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
             PatientDetailMonitor(Nheight: Nheight,width: width,l: l,s: s,),
              Column(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      HeartBeatMonitor(l: l,Nheight: Nheight,s: s,width: width,),
                      Spo2Monitor(width: width,s: s,l: l,Nheight: Nheight,),
                      TempMonitor(width: width,s: s,l: l,Nheight: Nheight)
                    ],
                  ),
                  EcgMonitor(s: s,Nheight: Nheight,l: l,width: width,),
                  // SizedBox(
                  //   height: Nheight*0.225,
                  //   width: double.infinity,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         border: Border.all(width: 1)
                  //     ),
                  //     child: StreamBuilder(
                  //         stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/ECG/ecg").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(10).snapshots(),
                  //         builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  //
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return Text("Loading");
                  //           }
                  //           if (snapshot.hasError) {
                  //             return Text("Error:${snapshot.error}");
                  //           }
                  //           if (snapshot.data.docs.isEmpty) {
                  //             return Text("Not Upladed");
                  //           }
                  //           else {
                  //             // snapshot.data.docs.forEach((element) {
                  //             //   // ignore: missing_return
                  //             //   return Text(element.data()['temperature'].toString());
                  //             // });
                  //             try{
                  //               for(var i=0;i<10;i++)
                  //               {
                  //                 print(snapshot.data.docs[i]['ecg']);
                  //                 dataset.add(snapshot.data.docs[i]['ecg']);
                  //               }
                  //
                  //               if(dataset.length==100)
                  //               {
                  //                 dataset.removeRange(0, 20);
                  //               }
                  //
                  //             }catch(e)
                  //             {
                  //               print(e.toString());
                  //             }
                  //
                  //             return
                  //
                  //               Column(
                  //                 children: [
                  //                   // Text(snapshot.data.docs[9]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
                  //                   Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child:  Container(
                  //                         height: 100,
                  //                         color: Colors.black,
                  //                         child: Padding(
                  //                             padding: const EdgeInsets.all(8.0),
                  //                             child:dataset.isNotEmpty? Sparkline(
                  //                               fallbackWidth: 50,
                  //                               fallbackHeight: 10,
                  //                               data: dataset,
                  //                               lineColor: Colors.green,
                  //                             ):Text("Loading")
                  //                         ),
                  //                       )
                  //                   )
                  //                 ],
                  //               );
                  //
                  //           }
                  //         }
                  //
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BpMonitor(width: width,s: s,l: l,Nheight: Nheight),
                      GlucoseMonitor(width: width,s: s,l: l,Nheight: Nheight),
                      // SizedBox(
                      //   height: Nheight*0.13,
                      //   width:width*0.33,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(width: 1)
                      //     ),
                      //   ),
                      // ),
                      RespiratoryMonitor(width: width,s: s,l: l,Nheight: Nheight)
                    ],
                  ),
                ],
              ),


            ],
          ),
        ),

      ),
    );
  }
}
