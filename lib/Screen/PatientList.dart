




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_monitor/Screen/monitor.dart';
import 'package:doctor_monitor/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientList extends StatefulWidget {

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  final TextEditingController _controller= new TextEditingController();

 late String search;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width*0.2,),
              Column(
                children: [
                  Text("     IQRAA"),
                  Text("         Patient Monitoring System",style: TextStyle(fontSize: 12),)
                ],
              ),
            ],
          ),
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
                        // print(search.substring(0,1));
                        // context.read(patientProvider).search_patient_name(search);
                      // setState(() {
                        search=val.toLowerCase();
                        // print(search);
                        context.read(patientProvider).search_patient_name(search);

                      // });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(icon: Icon(Icons.cancel),onPressed: (){
                        search="";
                        _controller.clear();
                        FocusScope.of(context).unfocus();
                        context.read(patientProvider).search_patient_name(search);
                        // setState(() {
                        //   search="";
                        //   _controller.clear();
                        //   context.read(patientProvider).search_patient_name(search);
                        //
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
              child: Consumer(
                builder: (context,watch,child){
                  final patients=watch(patientProvider);
                 
                  if(patients.patient_list_names.isEmpty)
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
                return
                ListView(
                  children: patients.patient_list_names.map(
                          (_patient){
                            QueryDocumentSnapshot<Map<String, dynamic>>? patient_detail;
                             QueryDocumentSnapshot<Map<String, dynamic>>? patient_vitals;
                            patients.patientList.forEach((patientList) {

                              if(patientList.get("Name")==_patient)
                                {
                                  patient_detail=patientList;
                                  patients.vitals.forEach((vitals) {
                                    // print(vitals.data().containsValue(patient_detail.id));
                                    if(vitals.data().containsValue(patient_detail!.id))
                                    {

                                      patient_vitals=vitals;


                                    }

                                  });
                                }
                            });
                           
                            // if(patients.temp_patient_list_names.contains(_patient.get("Name")) || patients.temp_patient_list_names.isEmpty)

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      if(patient_vitals!=null)
                                        {
                                          context.read(patientProvider).timer_cancel=false;
                                          context.read(patientProvider).patient_details(patient_detail!);
                                          context.read(patientProvider).monitor_parameters(patient_detail!.get("Device"), patient_detail!.id);
                                          // context.read(patientProvider).reportDate(patient_detail.get("Device"), patient_detail.id);
                                          // context.read(patientProvider).patient_detail=patient_detail;
                                          // String did=docs.id;
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                            // return Detailed(id: did,name:docs.data()['Name'],device: docs.data()["Device"] ,);
                                            return Monitor();
                                          }));
                                        }

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
                                                  Text(patient_detail!.get("Name"),style: TextStyle(color: Colors.brown,fontSize: 15,fontWeight: FontWeight.bold)),
                                                  Text("Age:",style: TextStyle(color: Colors.brown,fontSize: 15,fontWeight: FontWeight.bold)),
                                                  Text(patient_detail!.get('Age').toStringAsFixed(0),style: TextStyle(color: Colors.brown,fontSize: 15,fontWeight: FontWeight.bold)),
                                                ],
                                              ),
                                              SizedBox(height: 10,),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Icon(FontAwesomeIcons.thermometerEmpty,color:Color(0xFFB71C1C),size: 12),
                                                      Text(" Temp",style: TextStyle(color: Colors.deepPurple))
                                                    ],
                                                  ),

                                                  patient_vitals!=null?
                                                      Text(patient_vitals!.get("temperature").toString(),style: TextStyle(color: Colors.deepPurple)):
                                                  Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple)),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Icon(FontAwesomeIcons.heartbeat,color:Color(0xFFB71C1C),size: 12),
                                                      Text(" BPM ",style: TextStyle(color: Colors.deepPurple))
                                                    ],
                                                  ),

                                                  patient_vitals!=null?
                                                  Text(patient_vitals!.get("heartrate").toStringAsFixed(0),style: TextStyle(color: Colors.deepPurple)):
                                                  Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple)),
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Icon(FontAwesomeIcons.tint,color:Color(0xFFB71C1C),size: 12),
                                                      Text(" SPO2 ",style: TextStyle(color: Colors.deepPurple))
                                                    ],
                                                  ),

                                                  patient_vitals!=null?
                                                  Text(patient_vitals!.get("SPO2").toStringAsFixed(0),style: TextStyle(color: Colors.deepPurple)):
                                                  Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple)),
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Icon(FontAwesomeIcons.lungs,color:Color(0xFFB71C1C),size: 12),
                                                      Text(" RR        ",style: TextStyle(color: Colors.deepPurple))
                                                    ],
                                                  ),

                                                  patient_vitals!=null &&
                                                  patient_vitals!.data().toString().contains("rr")?
                                                  Text(patient_vitals!.get("rr").toString(),style: TextStyle(color: Colors.deepPurple)):
                                                  Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple)),
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SvgPicture.asset("assets/BPICON.svg",color:Color(0xFFB71C1C),width: 14,height: 14,),
                                                      Text(" BP   ",style: TextStyle(color: Colors.deepPurple))
                                                    ],
                                                  ),

                                                  patient_vitals!=null &&
                                                      patient_vitals!.data().toString().contains("Sys")&&
                                                      patient_vitals!.data().toString().contains("Dys")?
                                                  Text(patient_vitals!.get("Sys").toString()+"/"+patient_vitals!.get("Dys").toString(),style: TextStyle(color: Colors.deepPurple)):
                                                  Text("Not Uploaded",style: TextStyle(color: Colors.deepPurple)),
                                                ],
                                              )
                                            ]
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                      }
                  ).toList(),
                );
                }
              ),
            ),

          ),
        ],
      ),

    );
  }
}
