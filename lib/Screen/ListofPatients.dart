import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_monitor/Screen/DetailedPatient.dart';
import 'package:doctor_monitor/Screen/rough_work.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:doctor_monitor/Screen/Listofpatients2.dart";
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListOfPatient extends StatefulWidget {
  @override
  _ListOfPatientState createState() => _ListOfPatientState();
}

class _ListOfPatientState extends State<ListOfPatient> {

 CollectionReference d=FirebaseFirestore.instance.collection("Patients");

 TextEditingController _controller= new TextEditingController();

 late double t;
 late double sp;
 late double heartbeat;
 late double t1;
 late double sp1;
 late double heartbeat1;
 late Timer tick;
 late bool f=false;
 late String Id;
 late String search;
 // @override
 //  void initState() {
 //    // TODO: implement initState
 //   tick=Timer.periodic(Duration(seconds: 1), (timer) {
 //     f=!f;
 //
 //   });
 //    super.initState();
 //  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Row(
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
        actions: [
          IconButton(icon: Icon(Icons.person),onPressed: (){FirebaseAuth.instance.signOut();},),
        ],
      ),

        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val)
                    {
                      // search=val.toLowerCase();
                      //   print(search.substring(0,1));
                      setState(() {
                        search=val.toLowerCase();
                        print(search.substring(0,1));
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(icon: Icon(Icons.cancel),onPressed: (){
                          search="";
                          _controller.clear();
                          FocusScope.of(context).unfocus();
                        // setState(() {
                        //   search="";
                        //   _controller.clear();
                        //   FocusScope.of(context).unfocus();
                        // });
                      },),
                      fillColor:Colors.red ,
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.brown,),
                      border:OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1)),
                      enabledBorder: OutlineInputBorder(borderSide:BorderSide(width: 1) ,
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    ),
                      style: TextStyle(decoration: TextDecoration.none)
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: StreamBuilder(
                stream: (search!="" && search!=null)?d.where("searchkeyword",arrayContainsAny: [search]).where("Status",isEqualTo: "Admitted").snapshots():d.where("Status",isEqualTo: "Admitted").snapshots(),//where("Status",isEqualTo: "Admitted")
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                {
                  if(snapshot.connectionState==ConnectionState.waiting)
                  {
                    return Text("Loading");
                  }
                  if(snapshot.hasError)
                  {
                    return Text("Error:${snapshot.error}");
                  }
                  if(snapshot.data!.docs.isEmpty)
                  {

                    return Center(
                      child: GestureDetector(
                        onTap: (){ },
                        child: CircleAvatar(
                          radius: 150,
                          child: Text("Sorry no Patients found"),
                        ),
                      ),
                    );

                  }

                  else{

                    return ListView(
                        children:snapshot.data!.docs.map((DocumentSnapshot docs)  {

                          print(docs.get('Device'));
                          CollectionReference pData=FirebaseFirestore.instance.collection("/Devices/${docs.get('Device').toString()}/Healthparameters2");

                        pData.where('PatientsId',isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots().listen((event)
                        {
                          event.docs.forEach((element) {
                            if(element.get("PatientsId")==docs.id)
                            {
                              heartbeat=element.get("heartrate");
                              sp=element.get("SPO2");
                              t=element.get('temperature');
                              print(heartbeat);
                              print(sp);
                              print(t);

                            }
                          });
                        });


                          // CollectionReference hb= FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/HeartBeat/heartbeat");
                          // hb.where('PatientsId',isEqualTo: docs.id).orderBy("Datetime",descending: true).snapshots().listen((event) // hb.where('PatientsId',isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots().listen((event)
                          // {
                          //   event.docs.forEach((element) {
                          //     if(element.data()["PatientsId"]==docs.id)
                          //     {
                          //       heartbeat=element.data()["heartrate"];
                          //     }
                          //   });
                          // });
                          // CollectionReference spo2=FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/SPO2/sp02");
                          // spo2.where('PatientsId',isEqualTo: docs.id). orderBy("Datetime",descending: true).snapshots().listen((event) //spo2.where('PatientsId',isEqualTo: docs.id). orderBy("Datetime",descending: true).limit(1).snapshots().listen((event)
                          // {
                          //   event.docs.forEach((element) {
                          //     if(element.data()["PatientsId"]==docs.id)
                          //     {
                          //       sp=element.data()["SPO2"];
                          //     }
                          //   });
                          // });
                          // CollectionReference temperature=FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/Temperature/temperature");
                          // temperature.orderBy("Datetime",descending: true).snapshots().listen((event) // temperature.orderBy("Datetime",descending: true).limit(1).snapshots().listen((event)
                          // {
                          //   event.docs.forEach((element) {
                          //     if(element.data()['PatientsId']==docs.id)
                          //       {
                          //         print(element.data());
                          //         t=element.data()['temperature'];
                          //       }
                          //
                          //   });
                          // });


                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                String did=docs.id;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  // return Detailed(id: did,name:docs.data()['Name'],device: docs.data()["Device"] ,);
                                  return Detailed2(id: did,name:docs.get('Name'),device: docs.get("Device"),);
                                }));
                              },
                              child: Card(
                                 color:  Colors.white,
                                borderOnForeground: true,
                                shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                       color: Colors.black,
                                        width: 1.0,)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Name:",style: TextStyle(color: Colors.brown,fontSize: 15,fontWeight: FontWeight.bold),),
                                          Text(docs.get('Name'),style: TextStyle(color: Colors.brown,fontSize: 15,fontWeight: FontWeight.bold)),
                                          Text("Age:",style: TextStyle(color: Colors.brown,fontSize: 15,fontWeight: FontWeight.bold)),
                                          Text(docs.get('Age').toStringAsFixed(0),style: TextStyle(color: Colors.brown,fontSize: 15,fontWeight: FontWeight.bold)),
                                        ],
                                      ),

                                      // Text("${t}"),
                                      SizedBox(height: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [

                                          StreamBuilder(

                                              stream: FirebaseFirestore.instance.collection("/Devices/${docs.get('Device').toString()}/Healthparameters2").where("PatientsId",isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                                              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                                              // stream: FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/Temperature/temperature").where("PatientsId",isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                                              // builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                                              {
                                                // temperature.orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {
                                                //   event.docs.forEach((element) {
                                                //     if(element.data()['PatientsId']==docs.id)
                                                //     {
                                                //       print(element.data());
                                                //       t=element.data()['temperature'];
                                                //     }
                                                //
                                                //   });
                                                // });

                                                if(snapshot.connectionState==ConnectionState.waiting)
                                                {
                                                  return Text("Loading");
                                                }
                                                if(snapshot.hasError)
                                                {
                                                  return Text("Error:${snapshot.error}");
                                                }
                                                if(snapshot.data!.docs.isEmpty)
                                                {
                                                  return Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple));
                                                }
                                                else{
                                                  // snapshot.data.docs.forEach((element) {
                                                  //   // ignore: missing_return
                                                  //   return Text(element.data()['temperature'].toString());
                                                  // });
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(FontAwesomeIcons.thermometerEmpty,color:f? Colors.red: Color(0xFFB71C1C),size: 12),
                                                          Text("Temp",style: TextStyle(color: Colors.deepPurple))
                                                        ],
                                                      ),
                                                      // Text(snapshot.data.docs[0]["temperature"].toStringAsFixed(1),style: TextStyle(color: Colors.deepPurple)),
                                                      Text(t.toStringAsFixed(1),style: TextStyle(color: Colors.deepPurple)),
                                                    ],
                                                  );
                                                }
                                              }

                                          ),

                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection("/Devices/${docs.get('Device').toString()}/Healthparameters2").where("PatientsId",isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                                              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                                              // stream: FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/HeartBeat/heartbeat").where("PatientsId",isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                                              // builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                                              {
                                                // hb.orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {
                                                //   event.docs.forEach((element) {
                                                //     if(element.data()["PatientsId"]==docs.id)
                                                //     {
                                                //       heartbeat=element.data()["heartrate"];
                                                //     }
                                                //   });
                                                // });
                                                if(snapshot.connectionState==ConnectionState.waiting)
                                                {
                                                  return Text("Loading");
                                                }
                                                if(snapshot.hasError)
                                                {
                                                  return Text("Error:${snapshot.error}");
                                                }
                                                if(snapshot.data!.docs.isEmpty)
                                                {
                                                  return Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple));
                                                }
                                                else{
                                                  // snapshot.data.docs.forEach((element) {
                                                  //   // ignore: missing_return
                                                  //   return Text(element.data()['temperature'].toString());
                                                  // });
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Icon(FontAwesomeIcons.heartbeat,color:f? Colors.red: Color(0xFFB71C1C),size: 12),
                                                          Text("BPM",style: TextStyle(color: Colors.deepPurple)),
                                                        ],
                                                      ),
                                                      // Text(snapshot.data.docs[0]["heartrate"].toStringAsFixed(0),style: TextStyle(color: Colors.deepPurple)),
                                                      Text(heartbeat.toStringAsFixed(0),style: TextStyle(color: Colors.deepPurple)),
                                                    ],
                                                  );
                                                }
                                              }

                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection("/Devices/${docs.get('Device').toString()}/Healthparameters2").where("PatientsId",isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots(),
                                              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                                              // stream:FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/SPO2/sp02").where("PatientsId",isEqualTo: docs.id).orderBy("Datetime",descending: true).limit(1).snapshots() ,
                                              // builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
                                              {
                                                // spo2.orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {
                                                //   event.docs.forEach((element) {
                                                //     if(element.data()["PatientsId"]==docs.id)
                                                //     {
                                                //       sp=element.data()["SPO2"];
                                                //     }
                                                //   });
                                                // });
                                                if(snapshot.connectionState==ConnectionState.waiting)
                                                {
                                                  return Text("Loading");
                                                }
                                                if(snapshot.hasError)
                                                {
                                                  return Text("Error:${snapshot.error}");
                                                }
                                                if(snapshot.data!.docs.isEmpty)
                                                {
                                                  return Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple));
                                                }
                                                else{
                                                  // snapshot.data.docs.forEach((element) {
                                                  //   // ignore: missing_return
                                                  //   return Text(element.data()['temperature'].toString());
                                                  // });
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(FontAwesomeIcons.tint,color:f? Colors.red: Color(0xFFB71C1C),size: 12,),
                                                              Text("SPO2",style: TextStyle(color: Colors.deepPurple)),
                                                            ],
                                                          ),
                                                          // Text(snapshot.data.docs[0]['SPO2'].toStringAsFixed(0),style: TextStyle(color: Colors.deepPurple)),
                                                          Text(sp.toStringAsFixed(0),style: TextStyle(color: Colors.deepPurple)),

                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }
                                              }

                                          ),


                                        ],

                                      ),


                                    ],
                                  ),
                                ),
                               ),
                            ),
                          );
                        }).toList()
                    );

                  }

                },

                ),

                ),
            ),
          ],
        ),

    );
  }
}

//
// return ListView(
// children:snapshot.data.docs.map((DocumentSnapshot docs){
// print(docs.id);
//
// CollectionReference hb=FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/HeartBeat/heartbeat");
// CollectionReference spo2=FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/SPO2/sp02");
// CollectionReference temperature=FirebaseFirestore.instance.collection("/Devices/${docs.data()['Device'].toString()}/Healthparameters/Temperature/temperature");
// temperature.orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {
// event.docs.forEach((element) {
// if(element.data()['PatientsId']==docs.id)
// {
// print(element.data());
// t=element.data()['temperature'];
// }
//
// });
// });
// return ListTile(
// title: Text(docs.data()['Name'].toString()),
// subtitle: Row(
// children: [
// Text(docs.data()['Age'].toString()),
// // Text("${t}"),
// StreamBuilder(
// stream: temperature.snapshots(),
// builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
// {
//
// if(snapshot.connectionState==ConnectionState.waiting)
// {
// return Text("Loading");
// }
// if(snapshot.hasError)
// {
// return Text("Error:${snapshot.error}");
// }
// if(snapshot.data.docs.isEmpty)
// {
// return Text("Not Upladed");
// }
// else{
// // snapshot.data.docs.forEach((element) {
// //   // ignore: missing_return
// //   return Text(element.data()['temperature'].toString());
// // });
// return Text(t.toString());
// }
// }
//
// ),
// ],
// ),
// onTap: () {
// // Navigator.of(context).push(MaterialPageRoute(builder: (context){
// // widget.device.connect();
// // return DeviceScreen(device: widget.device);
// // }));},
// });
// }).toList()
// );
