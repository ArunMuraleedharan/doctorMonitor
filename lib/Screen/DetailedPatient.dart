// import 'dart:async';
// import 'dart:ui';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_sparkline/flutter_sparkline.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:oscilloscope/oscilloscope.dart';
//
// class Detailed extends StatefulWidget {
//   String name;
//   String id;
//   String device;
//   Detailed({this.id,this.name,this.device});
//
//   @override
//   _DetailedState createState() => _DetailedState();
// }
//
// class _DetailedState extends State<Detailed> {
//   CollectionReference d=FirebaseFirestore.instance.collection("Patients");
//
//   List<double> dataset=List();
//   List<dynamic> ECglist=List();
//   Color l=Colors.cyanAccent;
//   Color s=Color(0xFFD50000);
//
//   StreamController<double> controller = StreamController<double>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // controller.stream.listen((event) {
//     //   dataset.add(event);
//     // });
//   }
//
//   geStream()
//   {
//     for(int i=0;i<ECglist.length;i++)
//       {
//         controller.add(ECglist[i]);
//       }
//
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.close();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     double width=MediaQuery.of(context).size.width;
//     var padding=MediaQuery.of(context).padding;
//     double height=MediaQuery.of(context).size.height;
//     double Nheight=height-padding.top-padding.bottom;
//     print(Nheight);
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title:  Row(
//           children: [
//             SizedBox(width: MediaQuery.of(context).size.width*0.2,),
//             Column(
//               children: [
//                 Text("IQRAA"),
//                 Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
//               ],
//             ),
//           ],
//         ),
//          backgroundColor:Colors.green[900],
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             SizedBox(
//               height: Nheight*0.22,
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   color: Colors.black,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               // Text("Name: ",style: TextStyle(color: Colors.white,fontSize: 20),),
//                               Text(widget.name.length>12?widget.name.substring(0,12):widget.name,style: TextStyle(color: l,fontSize: 20),),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   FutureBuilder(
//                                     future: d.doc(widget.id).get(),
//                                     builder:(context, snapshot) {
//                                       if(snapshot.data==null)
//                                       {
//                                         return Text("Loading");
//                                       }
//                                       else
//                                       {
//                                         return Row(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text("Age    : ",style: TextStyle(color: l),),
//                                             Text( " "+snapshot.data["Age"].toStringAsFixed(0),style: TextStyle(color: l,),)
//                                           ],
//                                         );
//                                       }
//
//                                     },
//                                   ),
//                                   SizedBox(
//                                     height: Nheight*0.01,
//                                   ),
//                                   FutureBuilder(
//                                     future: d.doc(widget.id).get(),
//                                     builder:(context, snapshot) {
//                                       if(snapshot.data==null)
//                                       {
//                                         return Text("Loading");
//                                       }
//                                       else
//                                       {
//                                         return Row(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             Text("FileNo:    ",style: TextStyle(color: l),),
//                                             Text(snapshot.data["FileNo"].toString(),style: TextStyle(color:l),),
//                                           ],
//                                         );
//                                       }
//
//                                     },
//
//                                   ),
//                                 ],
//                               ),
//
//                             ],
//
//                           ),
//
//                           //
//                           SizedBox(
//                             width: width,
//                             height: Nheight*0.08,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   border: Border.all(width: 1),color: Colors.black,
//                               ),
//                               child: FutureBuilder(
//                                   future: d.doc(widget.id).get(),
//                                   builder:(context, snapshot) {
//                                     if (snapshot.data == null) {
//                                       return Text("Loading");
//                                     }
//                                     else {
//                                       return SingleChildScrollView(
//                                         child: SafeArea(
//                                           child: Text("Remarks: "+snapshot.data["Remarks"].toString(),overflow:  TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: l),),
//                                         ),
//                                       );
//                                     }
//                                   }
//                               ),
//                             ),
//                           )
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               mainAxisAlignment:MainAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//
//                   children: [
//                     SizedBox(
//                       height: Nheight*0.1,
//                       width:width*0.33,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(width: 1)
//                         ),
//                         child:  StreamBuilder(
//                             stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters2").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                             // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/HeartBeat/heartbeat").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                             // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                             {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Text("Loading");
//                               }
//                               if (snapshot.hasError) {
//                                 return Text("Error:${snapshot.error}");
//                               }
//                               if (snapshot.data.docs.isEmpty) {
//                                 return Text("Not Upladed");
//                               }
//                               else {
//                                 // snapshot.data.docs.forEach((element) {
//                                 //   // ignore: missing_return
//                                 //   return Text(element.data()['temperature'].toString());
//                                 // });
//                                 return Column(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Icon(FontAwesomeIcons.heartbeat,
//                                           color: s,),
//                                         Text("BPM",style: TextStyle(color: l),)
//                                       ],
//                                     ),
//                                     // SizedBox(height: 30,),
//                                     Text(snapshot.data.docs[0]['heartrate'].toStringAsFixed(0),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),),
//                                   ],
//                                 );
//                               }
//                             }
//
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Nheight*0.1,
//                       width:width*0.33,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1)
//                         ),
//                         child: StreamBuilder(
//                             stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters2").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                             // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/SPO2/sp02").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                           // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                         {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Text("Loading");
//                             }
//                             if (snapshot.hasError) {
//                               return Text("Error:${snapshot.error}");
//                             }
//                             if (snapshot.data.docs.isEmpty) {
//                               return Text("Not Upladed");
//                             }
//                             else {
//                               // snapshot.data.docs.forEach((element) {
//                               //   // ignore: missing_return
//                               //   return Text(element.data()['temperature'].toString());
//                               // });
//                               return Column(
//                                 mainAxisAlignment: MainAxisAlignment
//                                     .start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Icon(FontAwesomeIcons.tint,
//                                         color: s,),
//                                       Text("SPO2",style: TextStyle(color: l),)
//                                     ],
//                                   ),
//
//                                   Text(snapshot.data.docs[0]['SPO2'].toStringAsFixed(0)+"%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),),
//                                 ],
//                               );
//                             }
//                           }
//
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Nheight*0.1,
//                       width:width*0.33,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1)
//                         ),
//                         child:  StreamBuilder(
//                             stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters2").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                             // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/Temperature/temperature").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                             // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                         {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Text("Loading");
//                               }
//                               if (snapshot.hasError) {
//                                 return Text("Error:${snapshot.error}");
//                               }
//                               if (snapshot.data.docs.isEmpty) {
//                                 return Text("Not Upladed");
//                               }
//                               else {
//                                 // snapshot.data.docs.forEach((element) {
//                                 //   // ignore: missing_return
//                                 //   return Text(element.data()['temperature'].toString());
//                                 // });
//                                 return Column(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Icon(FontAwesomeIcons.thermometerEmpty,
//                                           color:s,),
//                                         Text("TEMP",style: TextStyle(color: l))
//                                       ],
//                                     ),
//                                     Text(snapshot.data.docs[0]['temperature'].toStringAsFixed(0)+"C",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l),),
//                                   ],
//                                 );
//                               }
//                             }
//
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: Nheight*0.225,
//                   width: double.infinity,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1)
//                     ),
//                     child: StreamBuilder(
//                         stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters2").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(10).snapshots(),
//                         builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                         // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/ECG/ecg").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(10).snapshots(),
//                         // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                         {
//
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Text("Loading");
//                           }
//                           if (snapshot.hasError) {
//                             return Text("Error:${snapshot.error}");
//                           }
//                           if (snapshot.data.docs.isEmpty) {
//                             return Text("Not Upladed");
//                           }
//                           else {
//                             // snapshot.data.docs.forEach((element) {
//                             //   // ignore: missing_return
//                             //   return Text(element.data()['temperature'].toString());
//                             // });
//                             // try{
//                             //   for(var i=0;i<10;i++)
//                             //     {
//                             //       print(snapshot.data.docs[i]['ecg']);
//                             //       dataset.add(snapshot.data.docs[i]['ecg']);
//                             //     }
//                             //
//                             //   if(dataset.length==100)
//                             //   {
//                             //     dataset.removeRange(0, 20);
//                             //   }
//                             //
//                             // }catch(e)
//                             // {
//                             //   print(e.toString());
//                             // }
//                             // ECglist.add(snapshot.data.docs[0]['ecg'][0]);
//                             ECglist=snapshot.data.docs[0]['ecg'];
//
//
//
//                             return
//
//                                 Column(
//                                   children: [
//                                     // Text(snapshot.data.docs[9]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child:  Container(
//                                            height: 100,
//                                            color: Colors.black,
//                                            child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child:ECglist.isNotEmpty? Sparkline(
//                                             fallbackWidth: 50,
//                                             fallbackHeight: 10,
//                                             data: ECglist,
//                                              lineColor: Colors.green,
//                                             //   dataSet: ECglist,
//                                             //   yAxisMin: 80,
//                                             //   yAxisMax: 254,
//                                             //   traceColor: Colors.white60,
//                                             ):Text("Loading")
//                                     ),
//                           )
//                                     )
//                                   ],
//                                 );
//                             //   Column(
//                             //   mainAxisAlignment: MainAxisAlignment
//                             //       .start,
//                             //   children: [
//                             //     Row(
//                             //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             //       children: [
//                             //         Icon(FontAwesomeIcons.thermometerEmpty,
//                             //           color: Colors.black,),
//                             //         Text("TEMP")
//                             //       ],
//                             //     ),
//                             //     SizedBox(
//                             //       height: 30,
//                             //     ),
//                             //     Text(snapshot.data.docs[0]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
//                             //   ],
//                             // );
//                           }
//                         }
//
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: Nheight*0.225,
//                   width: double.infinity,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1)
//                     ),
//                     child: StreamBuilder(
//                         stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/ECG/ecg").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(10).snapshots(),
//                         builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
//
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Text("Loading");
//                           }
//                           if (snapshot.hasError) {
//                             return Text("Error:${snapshot.error}");
//                           }
//                           if (snapshot.data.docs.isEmpty) {
//                             return Text("Not Upladed");
//                           }
//                           else {
//                             // snapshot.data.docs.forEach((element) {
//                             //   // ignore: missing_return
//                             //   return Text(element.data()['temperature'].toString());
//                             // });
//                             try{
//                               for(var i=0;i<10;i++)
//                               {
//                                 print(snapshot.data.docs[i]['ecg']);
//                                 dataset.add(snapshot.data.docs[i]['ecg']);
//                               }
//
//                               if(dataset.length==100)
//                               {
//                                 dataset.removeRange(0, 20);
//                               }
//
//                             }catch(e)
//                             {
//                               print(e.toString());
//                             }
//
//                             return
//
//                               Column(
//                                 children: [
//                                   // Text(snapshot.data.docs[9]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
//                                   Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child:  Container(
//                                         height: 100,
//                                         color: Colors.black,
//                                         child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child:dataset.isNotEmpty? Sparkline(
//                                               fallbackWidth: 50,
//                                               fallbackHeight: 10,
//                                               data: dataset,
//                                               lineColor: Colors.green,
//                                             ):Text("Loading")
//                                         ),
//                                       )
//                                   )
//                                 ],
//                               );
//                             //   Column(
//                             //   mainAxisAlignment: MainAxisAlignment
//                             //       .start,
//                             //   children: [
//                             //     Row(
//                             //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             //       children: [
//                             //         Icon(FontAwesomeIcons.thermometerEmpty,
//                             //           color: Colors.black,),
//                             //         Text("TEMP")
//                             //       ],
//                             //     ),
//                             //     SizedBox(
//                             //       height: 30,
//                             //     ),
//                             //     Text(snapshot.data.docs[0]['ecg'].toStringAsFixed(0),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
//                             //   ],
//                             // );
//                           }
//                         }
//
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: Nheight*0.13,
//                       width:width*0.33,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1)
//                         ),
//                         child: StreamBuilder(
//                             stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters2").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                             // stream: FirebaseFirestore.instance.collection("/Devices/${widget.device}/Healthparameters/SPO2/sp02").where("PatientsId",isEqualTo: widget.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
//                             // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
//                             {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Text("Loading");
//                               }
//                               if (snapshot.hasError) {
//                                 return Text("Error:${snapshot.error}");
//                               }
//                               if (snapshot.data.docs.isEmpty) {
//                                 return Text("Not Upladed");
//                               }
//                               else {
//                                 // snapshot.data.docs.forEach((element) {
//                                 //   // ignore: missing_return
//                                 //   return Text(element.data()['temperature'].toString());
//                                 // });
//                                 return Column(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         SvgPicture.asset("assets/BPICON.svg",color:s,width: 20,height: 20,),
//
//                                         Text("BP",style: TextStyle(color: l),)
//                                       ],
//                                     ),
//
//                                     Text(snapshot.data.docs[0]['Sys'].toString()+"/"+snapshot.data.docs[0]['Dys'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: l),),
//                                   ],
//                                 );
//                               }
//                             }
//
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Nheight*0.13,
//                       width:width*0.33,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1)
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Nheight*0.13,
//                       width:width*0.33,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 1)
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment
//                               .start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Icon(FontAwesomeIcons.lungs,color: s,),
//                                 Text("RR",style: TextStyle(color: l))
//                               ],
//                             ),
//                             Text("17",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: l ),),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
