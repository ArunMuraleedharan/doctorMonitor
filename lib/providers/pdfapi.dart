// import 'dart:convert';
// import 'dart:html' as html;
import 'dart:convert';
import 'dart:io';
// import 'dart:html' as html;


import 'package:download/download.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class Pdfapi
{



  static Future<File?> generateCenteredText  (String name,String gender,int age,
      double? hbmax,double? hbmin,double? hbavg,
      double? spo2max,double? spo2min,double? spo2avg,
      double? tempmax,double? tempmin,double? tempavg,
      int? sysmax,int? sysmin,double? sysavg,
      int? diamax,int? diamin,double? diaavg,
      int? rrmax,int? rrmin,double? rravg,
      List<double>? ecg,int hrs,
      int hbmaxL, int hbminL, int spo2minL, double sysminL, double sysmaxL, double dysminL, double dysmaxL, int rrminL, int rrmaxL, double tempminL, double tempmaxL
      ,List? tabledata) async
  {





    final pdf=Document();



    pdf.addPage(MultiPage(
      build: (context) =><Widget>[
        // Wrap(children: [
          buildCustomHeader(),
          SizedBox(height: 2* PdfPageFormat.cm),
          buildCustomHeadline(),
          patientdetail(name,gender,age,hrs),
          vitalheadline(),
          vitalTable(hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,rrmax, rrmin, rravg),
          rangeheadline(),
          refrange(hbmaxL,  hbminL,  spo2minL,  sysminL.toInt(),  sysmaxL.toInt(),  dysminL.toInt(),  dysmaxL.toInt(),  rrminL,  rrmaxL,tempminL,  tempmaxL),
          // Divider(thickness: 1,color: PdfColors.white),
          vitalsummaryheadline( ),
        tabledata!.isNotEmpty? vitasummary(hbmaxL,  hbminL,  spo2minL,  sysminL.toInt(),  sysmaxL.toInt(),  dysminL.toInt(),  dysmaxL.toInt(),  rrminL,  rrmaxL,tempminL,  tempmaxL, tabledata):Text("No Data Found"),

          // Container(
          //   height: 300,
          //   width: double.infinity,
          //   color: PdfColors.black,
          //   child:Center(
          //     child: Image(MemoryImage(image),
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
          ecg!.isNotEmpty?ecgGraph(ecg):Text("ECG Graph Not Uploaded"),

        // ])

      ],
      footer: (context)=>Text("IQRAA International Hospital"),

    ));
    if(kIsWeb)
    {
      return webpdf(pdf, name+".pdf");
    }
    else
    {
      return saveDocument(name:  name+".pdf",pdf: pdf);
    }


  }


  static Future<File?> webpdf(Document pdf,String name) async
  {
    File? file;
    final bytes = await pdf.save();
    // html.AnchorElement(
    //     href:
    //     "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    //   ..setAttribute("download", "$name")
    //   ..click();
    return file;
  }


  static Future<File> saveDocument({

    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);
    openFile(file);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    print(file.path);
    await OpenFile.open(url);

  }





  //  static Widget buildCustomHeader() => Container(
  //       padding: EdgeInsets.only(bottom:2* PdfPageFormat.mm),
  //       decoration: BoxDecoration(
  //         border: Border(bottom: BorderSide(width: 2, color: PdfColors.green900)),
  //       ),
  //       child: Row(
  //         children: [
  //           SizedBox(width: 0.25 * PdfPageFormat.cm),
  //           Text(
  //             'REPORT',
  //             style: TextStyle(fontSize: 15, color: PdfColors.black,fontWeight: FontWeight. bold),
  //           ),
  //         ],
  //       ),
  //     );

  static Widget buildCustomHeader() => Container(
    padding: EdgeInsets.only(bottom:2* PdfPageFormat.mm),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 2, color: PdfColors.green900)),
    ),
    child: Row(
      children: [
        SizedBox(width: 0.25 * PdfPageFormat.cm),
        Text(
          'REPORT',
          style: TextStyle(fontSize: 15, color: PdfColors.black,fontWeight: FontWeight. bold),
        ),
      ],
    ),
  );





  static Widget vitalheadline() => Container(
    padding: EdgeInsets.only(bottom:3* PdfPageFormat.mm,top: 10* PdfPageFormat.mm),
    child: Row(
      children: [
        SizedBox(width: 0.5 * PdfPageFormat.cm),
        Text(
          'Vital Summary',
          style: TextStyle(fontSize: 10, color: PdfColors.black,fontWeight: FontWeight. bold),
        ),
      ],
    ),
  );

  static Widget vitalsummaryheadline() => Container(
    padding: EdgeInsets.only(bottom:3* PdfPageFormat.mm,top: 10* PdfPageFormat.mm),
    child: Row(
      children: [
        SizedBox(width: 0.5 * PdfPageFormat.cm),
        Text(
          'Vital Signs Table',
          style: TextStyle(fontSize: 10, color: PdfColors.black,fontWeight: FontWeight. bold),
        ),
      ],
    ),
  );

  static Widget rangeheadline() => Container(
    padding: EdgeInsets.only(bottom:3* PdfPageFormat.mm,top: 10* PdfPageFormat.mm),
    child: Row(
      children: [
        SizedBox(width: 0.5 * PdfPageFormat.cm),
        Text(
          'Vital Limit Range',
          style: TextStyle(fontSize: 10, color: PdfColors.black,fontWeight: FontWeight. bold),
        ),
      ],
    ),
  );

  static Widget ecgheadline() => Container(
    padding: EdgeInsets.only(bottom:3* PdfPageFormat.mm),
    child: Row(
      children: [
        SizedBox(width: 0.5 * PdfPageFormat.cm),
        Text(
          'ECG Graph',
          style: TextStyle(fontSize: 10, color: PdfColors.black,fontWeight: FontWeight. bold),
        ),
      ],
    ),
  );

  static Widget buildCustomHeadline() => Container(
    padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
    child: Row(
      children: [
        SizedBox(width: 0.5 * PdfPageFormat.cm),
        Text(
          'Patient Details',
          style: TextStyle(fontSize: 10, color: PdfColors.black,fontWeight: FontWeight. bold),
        ),
      ],
    ),
  );

  static Widget patientdetail(String name,String gender,int age,int hrs) =>
      Container(
          padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
          child: Row(
              children: [
                SizedBox(width: 0.5 * PdfPageFormat.cm),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Name: $name',
                        style: TextStyle(fontSize: 10, color: PdfColors.black),
                      ),
                      SizedBox(width: 0.5 * PdfPageFormat.cm),
                      Text(
                        'Gender: $gender',
                        style: TextStyle(fontSize: 10, color: PdfColors.black),),
                      Text(
                        'Age: $age',
                        style: TextStyle(fontSize: 10, color: PdfColors.black),)
                    ]
                ),

                SizedBox(width: 2 * PdfPageFormat.cm),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report Start: ${DateFormat.yMEd().add_jms().format(DateTime.now()).toString()}',
                        style: TextStyle(fontSize: 10, color: PdfColors.black),
                      ),
                      SizedBox(width: 0.5 * PdfPageFormat.cm),
                      Text(
                        'Report End: ${DateFormat.yMEd().add_jms().format(DateTime.now().subtract(Duration(hours: hrs))).toString()}',
                        style: TextStyle(fontSize: 10, color: PdfColors.black),),
                      Text(
                        'Report Duration: ${hrs} hours',
                        style: TextStyle(fontSize: 10, color: PdfColors.black),)
                    ]
                ),
              ]
          )
      );


  static Widget vitalTable(double? hbmax,double? hbmin,double? hbavg,
      double? spo2max,double? spo2min,double? spo2avg,
      double? tempmax,double? tempmin,double? tempavg,
      int? sysmax,int? sysmin,double? sysavg,
      int? diamax,int? diamin,double? diaavg,
      int? rrmax,int? rrmin,double? rravg) =>
      Table(border: TableBorder.all(width: 1,color: PdfColors.teal),
        children: [
          TableRow(children: [
            Center(child: Text("BPM",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("SPO2",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("BP",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("RR",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("TEMP",style: TextStyle(fontWeight: FontWeight.bold))),
          ]),
          TableRow(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("HIGH:"),
                          Text(hbmax==null?"-":hbmax.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("LOW:"),
                          Text(hbmin==null?"-":hbmin.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5* PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("AVG:"),
                          Text(hbavg==null?"-":hbavg.toInt().toString())//bpm
                        ]
                    )
                  ]
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("HIGH:"),
                          Text(spo2max==null?"-":spo2max.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("LOW:"),
                          Text(spo2min==null?"-":spo2min.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5* PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("AVG:"),
                          Text(spo2avg==null?"-":spo2avg.toInt().toString())//spo2
                        ]
                    )
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("HIGH:"),
                          Text(sysmax==null || diamax==null?"-":sysmax.toString()+"/"+diamax.toString())
                        ]
                    ),
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("LOW:"),
                          Text(sysmin==null || diamin==null?"-":sysmin.toString()+"/"+diamin.toString())
                        ]
                    ),
                    SizedBox(height: 0.5* PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("AVG:"),
                          Text(sysavg==null || diaavg==null?"-":sysavg.toInt().toString()+"/"+diaavg.toInt().toString())
                        ]
                    )
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("HIGH:"),
                          Text(rrmax==null?"-":rrmax.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("LOW:"),
                          Text(rrmin==null?"-":rrmin.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5* PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("AVG:"),
                          Text(rravg==null?"-":rravg.toInt().toString())
                        ]
                    )
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("HIGH:"),
                          Text(tempmax==null?"-":tempmax.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("LOW:"),
                          Text(tempmin==null?"-":tempmin.toInt().toString())
                        ]
                    ),
                    SizedBox(height: 0.5* PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("AVG:"),
                          Text(tempavg==null?"-":tempavg.toInt().toString())
                        ]
                    )
                  ]
              ),
            ),

          ]),
        ],

      );


  static Widget refrange(int hbmaxL, int hbminL, int spo2minL, int sysminL, int sysmaxL, int dysminL, int dysmaxL,
      int rrminL, int rrmaxL,double tempminL, double tempmaxL)=>
   Row(
     mainAxisAlignment: MainAxisAlignment.spaceAround,
     children: [
       for(int i=0;i<5;i++)
         Container(

           height: 30,
           width: 90,
           child: i==0?Center(child:Text("$hbminL-$hbmaxL")):
           i==1?Center(child:Text("$spo2minL")):
           i==2?Center(child:Text("$sysminL-$sysmaxL\n$dysminL-$dysmaxL")):
           i==3?Center(child:Text("$rrminL-$rrmaxL")):
           Center(child:Text("$tempminL-$tempmaxL")),
           foregroundDecoration: BoxDecoration(border: Border.all(color: PdfColors.teal))
         )

     ]
   );

  static Widget vitasummary(int hbmaxL, int hbminL, int spo2minL, int sysminL, int sysmaxL, int dysminL, int dysmaxL,
      int rrminL, int rrmaxL,double tempminL, double tempmaxL,List? tabledata) =>
  // Padding(
  //   padding: EdgeInsets.only(bottom:3* PdfPageFormat.mm,top: 10* PdfPageFormat.mm),
  //   child:
    Table(border: TableBorder.all(width: 1,color: PdfColors.teal),
        children: [
          TableRow(children: [
            Center(child: Text("Date",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("Time",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("BPM",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("SPO2",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("BP",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("RR",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("TEMP",style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text("BLOOD GL",style: TextStyle(fontWeight: FontWeight.bold)))

          ],),
          for(int i=0;i<tabledata!.length;i++)
            // DateFormat.yMEd().add_jms().format(DateTime.now())
            TableRow(children: [
              Center(child: Text(DateFormat.MMMMd().format(tabledata[tabledata.length-1-i]["Date"]))),
            Center(child: Text(DateFormat.jm().format(tabledata[tabledata.length-1-i]["Date"]))),
            Center(child: Text(tabledata[tabledata.length-1-i]["HeartRate"].toString())),
            Center(child: Text(tabledata[tabledata.length-1-i]["SPO2"].toString())),
              Center(child: Text(tabledata[tabledata.length-1-i]["Systoloic"].toString()+"/"+tabledata[tabledata.length-1-i]["Dystolic"].toString())),

            Center(child:tabledata[tabledata.length-1-i]["RR"]!=0?
            Text(tabledata[tabledata.length-1-i]["RR"].toString(),style:tabledata[tabledata.length-1-i]["RR"]>rrminL&&tabledata[tabledata.length-1-i]["RR"]<rrmaxL?TextStyle(color: PdfColors.red):
            TextStyle(color: PdfColors.black)):
            Text("-")),

            Center(child: Text(tabledata[tabledata.length-1-i]["Temperature"].toString())),
              Center(child: Text(tabledata[tabledata.length-1-i]["Sugar"].toString())),
          ]),

        ]);
  // );

  static Widget ecgGraph(List<double> ecg)
  {

    List<int> range(int stop, {int start: 0, int step: 1}){
      if (step == 0)
        throw Exception("Step cannot be 0");

      return start < stop == step > 0
          ? List<int>.generate(((start-stop)/step).abs().ceil(), (int i) => start + (i * step))
          : [];
    }



    int rangelength1=(ecg.length/2).toInt();
    final chart2 = Chart(
      right: ChartLegend(),
      grid: CartesianGrid(
        xAxis: FixedAxis(
            (range(rangelength1, start:0, step: 25)),
            // Iterable<int>.generate(ecg.length).toList(),
            textStyle: TextStyle(color: PdfColors.white),
          divisions: true,
          // divisionsDashed: true,


        ),
        yAxis: FixedAxis(
          [ -100,-90,-80,-70,-60,-50,-40,-30,-20, -10, 0,10,20,30,40,50,60,70,80,90,100],
            divisions: true,
          textStyle: TextStyle(color: PdfColors.white),

      ),
      ),

      datasets: [
        LineDataSet(
          drawLine: true,
          surfaceColor: PdfColors.lightBlueAccent,
          surfaceOpacity: 1,
          lineWidth: 1,
          legend: 'ECG',
          drawSurface: false,
          isCurved: true,
          drawPoints: false,
          color: PdfColors.teal,
          data: List<LineChartValue>.generate(
            rangelength1,
                (i) {
              final v = ecg[i];
              return LineChartValue(i.toDouble(), v.toDouble());
            },
          ),
        ),
      ],
    );
    final chart3 = Chart(
      right: ChartLegend(),
      grid: CartesianGrid(
        xAxis: FixedAxis(
          (range(ecg.length, start:rangelength1, step: 25)),
          // Iterable<int>.generate(ecg.length).toList(),
          textStyle: TextStyle(color: PdfColors.white),
          divisions: true,
          // divisionsDashed: true,


        ),
        yAxis: FixedAxis(
          [-100,-90,-80,-70,-60,-50,-40,-30,-20, -10, 0,10,20,30,40,50,60,70,80,90,100],
          divisions: true,
          textStyle: TextStyle(color: PdfColors.white),


        ),
      ),

      datasets: [
        LineDataSet(
          drawLine: true,
          surfaceColor: PdfColors.lightBlueAccent,
          surfaceOpacity: 1,
          lineWidth: 1,
          legend: 'ECG',
          drawSurface: false,
          isCurved: true,
          drawPoints: false,
          color: PdfColors.teal,
          data: List<LineChartValue>.generate(
            ecg.length,
                (i) {
              final v = ecg[i];
              return LineChartValue(i.toDouble(), v.toDouble());
            },
          ),
        ),
      ],
    );
    return Container(
        height: 400,
        child:Center(
            child:Column(
              children: [
                ecgheadline(),
                Container(
                    height: 150,
                    width: double.infinity,
                    child: chart2),
                Container(
                    height: 150,
                    width: double.infinity,
                    child: chart3)
              ]
            )

    ));
  }

}
