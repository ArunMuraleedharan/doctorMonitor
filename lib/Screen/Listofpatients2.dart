import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
// import 'package:oscilloscope/oscilloscope.dart';

class Detailed2 extends StatefulWidget {
  String name;
  String id;
  String device;
  Detailed2({required this.id,required this.name,required this.device});

  @override
  _Detailed2State createState() => _Detailed2State();
}

class _Detailed2State extends State<Detailed2> {
  CollectionReference d=FirebaseFirestore.instance.collection("Patients");

  List<double> dataset=[];
  List<dynamic> ECglist=[];
  List<dynamic> ECglist2=[];
  Color l=Colors.cyanAccent;
  Color s=Color(0xFFD50000);
  late Timer t,t1,t2;
  bool ecg1=false;
  bool ecg2=false;

  double spo2=0;
  double hb=0;
  double ymax=300;
  double ymin=0;
  bool gain=false;

  StreamController<double> hbController = StreamController<double>();
  StreamController<double> spo2Controller = StreamController<double>();
  StreamController<double> tempController = StreamController<double>();
  StreamController<Map<String,int>> bpController = StreamController<Map<String,int>>();
  StreamController<double> ecgController = StreamController<double>();
  StreamController<double> rrcontroller = StreamController<double>();

  int i=0;
  int j=0;

  @override
  void initState() {
    // TODO: implement initState
    t2=Timer.periodic(Duration(seconds: 5), (Timer T){

    });
    super.initState();
    // controller.stream.listen((event) {
    //   dataset.add(event);
    // });

    FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters2").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {

      hbController.add(event.docs[0]["heartrate"]);
      hb=event.docs[0]["heartrate"];
      rrcontroller.add(event.docs[0]["heartrate"]);
      // print(hb);
      spo2Controller.add(event.docs[0]["SPO2"]);
      spo2=event.docs[0]["SPO2"];
      // print(spo2);
      tempController.add(event.docs[0]["temperature"]);
      bpController.add({
        "sys":event.docs[0]["Sys"],
        "dys":event.docs[0]["Dys"]
      });



          if(i==0)
            {
              ECglist=event.docs[0]["ecg"];
              ymax=(ECglist.cast<double>().reduce(max));
              ymin=ECglist.cast<double>().reduce(min);
              print(ymax);
              print(ymin);
              getEcg();
            }
          else
            {
              ECglist2=event.docs[0]["ecg"];
              ymax=(ECglist2.cast<double>().reduce(max));
              ymin=(ECglist2.cast<double>().reduce(min));
              print(ymax);
              print(ymin);
              getEcg2();
            }
      // ECglist2.add(event.docs[0]['ecg']);



    });
  }

getEcg() async
{


      t = Timer.periodic(Duration(milliseconds: 10), (Timer T) {

        if(j==0)
          {
            if(ECglist.isNotEmpty && i<ECglist.length )
            {
              // print(ECglist[i]);

              ecgController.add(ECglist[i]);
              i++;
            }
            else
            {
              i=0;
              t.cancel();
            }
          }
          });
}
  getEcg2() async
  {


    t1 = Timer.periodic(Duration(milliseconds: 10), (Timer T) {

      if(i==0)
        {
          if(ECglist2.isNotEmpty && j<ECglist2.length )
          {
            // print(ECglist[i]);

            ecgController.add(ECglist2[j]);
            j++;
          }
          else
          {
            j=0;
            t1.cancel();
          }
        }
        });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t1==null?t1:t1.cancel();
    t==null?t:t.cancel();
    t2==null?t2:t2.cancel();
    hbController.close();
    spo2Controller.close();
    tempController.close();
    bpController.close();
    ecgController.close();
    rrcontroller.close();
  }


  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    var padding=MediaQuery.of(context).padding;
    double height=MediaQuery.of(context).size.height;
    double Nheight=height-padding.top-padding.bottom;
    print(Nheight);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width*0.2,),
            Column(
              children: [
                Text("IQRAA"),
                Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
              ],
            ),
          ],
        ),
        backgroundColor:Colors.green[900],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
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
                          Text(widget.name.length>12?widget.name.substring(0,12):widget.name,style: TextStyle(color: l,fontSize: 20),),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                future: d.doc(widget.id).get(),
                                builder:(context, snapshot) {
                                  if(snapshot.data==null)
                                  {
                                    return Text("Loading");
                                  }
                                  else
                                  {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Age    : ",style: TextStyle(color: l),),
                                        // Text( " "+ snapshot.data["Age"].toStringAsFixed(0),style: TextStyle(color: l,),)
                                      ],
                                    );
                                  }

                                },
                              ),
                              SizedBox(
                                height: Nheight*0.01,
                              ),
                              FutureBuilder(
                                future: d.doc(widget.id).get(),
                                builder:(context, snapshot) {
                                  if(snapshot.data==null)
                                  {
                                    return Text("Loading");
                                  }
                                  else
                                  {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("FileNo:    ",style: TextStyle(color: l),),
                                        // Text(snapshot.data["FileNo"].toString(),style: TextStyle(color:l),),
                                      ],
                                    );
                                  }

                                },

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
                          child: FutureBuilder(
                              future: d.doc(widget.id).get(),
                              builder:(context, snapshot) {
                                if (snapshot.data == null) {
                                  return Text("Loading");
                                }
                                else {
                                  return SingleChildScrollView(
                                    child: SafeArea(
                                      child:
                                      Text("Remarks: ",overflow:  TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: l),),
                                    ),
                                  );
                                }
                              }
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    SizedBox(
                      height: Nheight*0.1,
                      width:width*0.33,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1)
                        ),
                        child:  StreamBuilder(
                            stream:hbController.stream,
                            builder: (BuildContext context,AsyncSnapshot<double> snapshot)

                            {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              if (snapshot.hasError) {
                                return Text("Error:${snapshot.error}");
                              }
                              if (snapshot.data==null) {
                                return Text("Not Upladed");
                              }
                              else {
                                // snapshot.data.docs.forEach((element) {
                                //   // ignore: missing_return
                                //   return Text(element.data()['temperature'].toString());
                                // });
                                return Column(
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
                                    Text(snapshot.data!.toStringAsFixed(0),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),),
                                  ],
                                );
                              }
                            }

                        ),
                      ),
                    ),
                    SizedBox(
                      height: Nheight*0.1,
                      width:width*0.33,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1)
                        ),
                        child: StreamBuilder(
                            stream: spo2Controller.stream,
                            builder: (BuildContext context,AsyncSnapshot<double> snapshot)
                            // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/SPO2/sp02").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                            // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                            {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              if (snapshot.hasError) {
                                return Text("Error:${snapshot.error}");
                              }
                              if (snapshot.data==null) {
                                return Text("Not Upladed");
                              }
                              else {
                                // snapshot.data.docs.forEach((element) {
                                //   // ignore: missing_return
                                //   return Text(element.data()['temperature'].toString());
                                // });
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(FontAwesomeIcons.tint,
                                          color: s,),
                                        Text("SPO2",style: TextStyle(color: l),)
                                      ],
                                    ),

                                    // Text(snapshot.data?.toStringAsFixed(0)!!+"%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),),
                                  ],
                                );
                              }
                            }

                        ),
                      ),
                    ),
                    SizedBox(
                      height: Nheight*0.1,
                      width:width*0.33,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1)
                        ),
                        child:  StreamBuilder(
                            stream: tempController.stream,
                            builder: (BuildContext context,AsyncSnapshot<double> snapshot)
                            // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/Temperature/temperature").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                            // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                            {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              if (snapshot.hasError) {
                                return Text("Error:${snapshot.error}");
                              }
                              if (snapshot.data==null) {
                                return Text("Not Upladed");
                              }
                              else {
                                // snapshot.data.docs.forEach((element) {
                                //   // ignore: missing_return
                                //   return Text(element.data()['temperature'].toString());
                                // });
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(FontAwesomeIcons.thermometerEmpty,
                                          color:s,),
                                        Text("TEMP",style: TextStyle(color: l))
                                      ],
                                    ),
                                    // Text(snapshot.data.toStringAsFixed(0)+"C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),),
                                  ],
                                );
                              }
                            }

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).orientation==Orientation.portrait?height*0.4:height*.5,
                  width: double.infinity,
                  // MediaQuery.of(context).orientation==Orientation.portrait? width*0.72:width*0.842,//260,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1)
                    ),
                    child: StreamBuilder(
                        stream: ecgController.stream,
                        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot)
                        // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/ECG/ecg").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(10).snapshots(),
                        // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                        {

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          if (snapshot.hasError) {
                            return Text("Error:${snapshot.error}");
                          }
                          if (snapshot.data==null) {
                            return Text("Not Upladed");
                          }
                          else if((snapshot.connectionState == ConnectionState.active))
                            {

                                dataset.add(double.parse(snapshot.data.toString()));
                                // print(dataset.length);
                            return

                              Column(
                                children: [
                                  // Text(snapshot.data.docs[9]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  GestureDetector(
                                        onTap:(){
                                          gain=!gain;
                                        },
                                        child: Container(
                                          height: gain?200:120,
                                          color: Colors.black,
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:dataset.isNotEmpty?
                                               // Oscilloscope(
                                               //  backgroundColor: Colors.black,
                                               //  dataSet: dataset,
                                               //  traceColor: Colors.amber,
                                               //   yAxisMin:ymin,
                                               //    yAxisMax: ymax,
                                              // Sparkline(
                                              //   fallbackWidth: 50,
                                              //   fallbackHeight: 10,
                                              //   data: dataset,
                                              //   lineColor: Colors.green,
                                              // )
                        Text("Loading",style: TextStyle(color: Colors.white) ):
                                              Text("Loading",style: TextStyle(color: Colors.white))
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              );
                            //   Column(
                            //   mainAxisAlignment: MainAxisAlignment
                            //       .start,
                            //   children: [
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //       children: [
                            //         Icon(FontAwesomeIcons.thermometerEmpty,
                            //           color: Colors.black,),
                            //         Text("TEMP")
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       height: 30,
                            //     ),
                            //     Text(snapshot.data.docs[0]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                            //   ],
                            // );
                          }
                          else
                            {
                              return Text('Check the stream',style: TextStyle(fontSize: 50,color: Colors.pink));
                            }
                        }

                    ),
                  ),
                ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Nheight*0.13,
                      width:width*0.33,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1)
                        ),
                        child: StreamBuilder(
                            stream: bpController.stream,
                            builder: (BuildContext context,AsyncSnapshot<Map<String,int>> snapshot)
                            // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/SPO2/sp02").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                            // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                            {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              if (snapshot.hasError) {
                                return Text("Error:${snapshot.error}");
                              }
                              if (snapshot.data==null) {
                                return Text("Not Upladed");
                              }
                              else {
                                // snapshot.data.docs.forEach((element) {
                                //   // ignore: missing_return
                                //   return Text(element.data()['temperature'].toString());
                                // });
                                return Column(
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

                                    // Text(snapshot.data['dys']==-10?"0/0":snapshot.data['sys'].toString()+"/"+snapshot.data['dys'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),),
                                  ],
                                );
                              }
                            }

                        ),
                      ),
                    ),
                    SizedBox(
                      height: Nheight*0.13,
                      width:width*0.33,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Nheight*0.13,
                      width:width*0.33,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1)
                        ),
                        child: StreamBuilder(
                               stream: rrcontroller.stream,
                               builder: (BuildContext context,AsyncSnapshot<double> snapshot) {
                                 if (snapshot.connectionState ==
                                     ConnectionState.waiting) {
                                   return Text("Loading");
                                 }
                                 if (snapshot.hasError) {
                                   return Text("Error:${snapshot.error}");
                                 }
                                 if (snapshot.data == null) {
                                   return Text("Not Upladed");
                                 }
                                 else {
                                   return

                                     Column(
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
                                         Text(
                                           "${hb == 0 || spo2 == 0 ? "0" : (hb /
                                               4.7 + (100 - spo2)).toInt()}",
                                           style: TextStyle(fontSize: 30,
                                               fontWeight: FontWeight.bold,
                                               color: l),
                                         ),
                                       ],
                                     );

                               }
                               }
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
