




import 'dart:typed_data';
import 'dart:math';


import 'package:doctor_monitor/Screen/LoadingPage.dart';
import 'package:doctor_monitor/main.dart';
import 'package:doctor_monitor/providers/pdfapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';

import '../pdfDemo.dart';



class Reportpdf extends StatefulWidget {


  @override
  _ReportpdfState createState() => _ReportpdfState();
}

class _ReportpdfState extends State<Reportpdf> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(int j=0;j<8;j++)
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text("Report"),
            trailing:j==0?Text("4 Hrs Report"):j==1?Text("6 Hrs Report"):j==2?Text("8 Hrs Report"):
            j==3?Text("10 Hrs Report"):j==4?Text("12 Hrs Report"):j==5?Text("24 Hrs Report"):j==6?Text("48 Hrs Report"):
            j==7?Text("72 Hrs Report"):Text("96 Hrs Report"),
            tileColor: Colors.blue,
            shape: RoundedRectangleBorder(
                side: BorderSide(color:Colors.black, width:1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
            onTap: ()async{
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)  {
                // return DeviceScreen(device: r.device,);
                // return PatientDetail();
                return LoadingPage();
              }));
              int hrs=0;
              if(j==0)
                {
                   hrs=4;
                }
              else if(j==1)
                {
                  hrs=6;
                }
              else if(j==2)
              {
                hrs=8;
              }
              else if(j==3)
              {
                hrs=10;
              }
              else if(j==4)
              {
                hrs=12;
              }
              else if(j==5)
              {
                hrs=24;
              }
              else if(j==6)
              {
                hrs=48;
              }
              else if(j==7)
              {
                hrs=72;
              }


              await context.read(patientProvider).reportDate(hrs);
              double? hbmax=context.read(patientProvider).hbmax;
              double? hbmin=context.read(patientProvider).hbmin;
              double? hbavg=context.read(patientProvider).hbavg;

              double? spo2max=context.read(patientProvider).spo2max;
              double? spo2min=context.read(patientProvider).spo2min;
              double? spo2avg=context.read(patientProvider).spo2avg;

              double? tempmax=context.read(patientProvider).tempmax;
              double? tempmin=context.read(patientProvider).tempmin;
              double? tempavg=context.read(patientProvider).tempavg;

              int? sysmax=context.read(patientProvider).sysmax;
              int? sysmin=context.read(patientProvider).sysmin;
              double? sysavg=context.read(patientProvider).sysavg;

              int? diamax=context.read(patientProvider).dimax;
              int? diamin=context.read(patientProvider).dimin;
              double? diaavg=context.read(patientProvider).diavg;

              int? rrmax=context.read(patientProvider).rrmax;
              int? rrmin=context.read(patientProvider).rrmin;
              double? rravg=context.read(patientProvider).rravg;

              String name=context.read(nameprovider2).name;
              String gender=context.read(genderprovider2).gender;
              int age=context.read(ageprovider2).age.toInt() ;

              int hbmaxL=context.read(patientProvider).hbmaxL;
              int hbminL=context.read(patientProvider).hbminL;
              int spo2minL=context.read(patientProvider).spo2minL;
              double sysminL=context.read(patientProvider).sysminL;
              double sysmaxL=context.read(patientProvider).sysmaxL;
              double dysminL=context.read(patientProvider).dysminL;
              double dysmaxL=context.read(patientProvider).dysmaxL;
              int rrminL=context.read(patientProvider).rrminL;
              int rrmaxL=context.read(patientProvider).rrmaxL;
              double tempminL=context.read(patientProvider).tempminL;
              double tempmaxL=context.read(patientProvider).tempmaxL;

              List<dynamic>? tabledata=context.read(patientProvider).list2;




             await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
                tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
                   rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs,
                  hbmaxL,  hbminL,  spo2minL,  sysminL,  sysmaxL,  dysminL,  dysmaxL,  rrminL,  rrmaxL,  tempminL,  tempmaxL,tabledata)
                 .onError((error, stackTrace) =>  null);




              context.read(patientProvider).clearListpdf();
              Navigator.of(context).pop();
            },
          ),
        ),

      ],
    );
  }
}
