// // Table(
// // border: TableBorder.all(width: 1,color: PdfColors.black),
// // children: [
// // TableRow(children: [
// //
// // Center(
// //
// // child: Column(
// // mainAxisAlignment:MainAxisAlignment.spaceAround,
// // children: [
// // // Text("BPM",style: TextStyle(fontWeight: FontWeight.bold)),
// // Center(
// // child: Text("50-120"))
// // ]
// // ),
// // ),
// //
// // Center(
// // child: Column(
// // mainAxisAlignment:MainAxisAlignment.spaceAround,
// // children: [
// // // Text("SPO2",style: TextStyle(fontWeight: FontWeight.bold)),
// // Text("85")
// // ]
// // ),
// // ),
// // Center(
// // child: Column(
// // mainAxisAlignment:MainAxisAlignment.spaceAround,
// // children: [
// // // Text("BP",style: TextStyle(fontWeight: FontWeight.bold)),
// // Text("50-120"),
// // Text("80-160")
// // ]
// // ),
// // ),
// // Center(
// // child: Column(
// // mainAxisAlignment:MainAxisAlignment.spaceAround,
// // children: [
// // // Text("RR"),
// // Text("8-40"),
// // ]
// // ),
// // ),
// // Center(
// // child: Column(
// // mainAxisAlignment:MainAxisAlignment.spaceAround,
// // children: [
// // // Text("TEMP"),
// // Text("33.4-38.5"),
// // ]
// // ),
// // ),
// // ]),
// // ]
// // );
//
//
//
//
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("6 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=6;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("8 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=8;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("10 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=10;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("12 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=12;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("24 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=24;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("48 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=48;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("72 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=72;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// title: Text("Report"),
// trailing: Text("96 Hrs Report"),
// tileColor: Colors.blue,
// shape: RoundedRectangleBorder(
// side: BorderSide(color:Colors.black, width:1),
// borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
// onTap: ()async{
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context)  {
// // return DeviceScreen(device: r.device,);
// // return PatientDetail();
// return LoadingPage();
// }));
// int hrs=96;
// await context.read(patientProvider).reportDate(hrs);
// double hbmax=context.read(patientProvider).hbmax;
// double hbmin=context.read(patientProvider).hbmin;
// double hbavg=context.read(patientProvider).hbavg;
//
// double spo2max=context.read(patientProvider).spo2max;
// double spo2min=context.read(patientProvider).spo2min;
// double spo2avg=context.read(patientProvider).spo2avg;
//
// double tempmax=context.read(patientProvider).tempmax;
// double tempmin=context.read(patientProvider).tempmin;
// double tempavg=context.read(patientProvider).tempavg;
//
// int sysmax=context.read(patientProvider).sysmax;
// int sysmin=context.read(patientProvider).sysmin;
// double sysavg=context.read(patientProvider).sysavg;
//
// int diamax=context.read(patientProvider).dimax;
// int diamin=context.read(patientProvider).dimin;
// double diaavg=context.read(patientProvider).diavg;
//
// int rrmax=context.read(patientProvider).rrmax;
// int rrmin=context.read(patientProvider).rrmin;
// double rravg=context.read(patientProvider).rravg;
//
// String name=context.read(nameprovider2).name;
// String gender=context.read(genderprovider2).gender;
// int age=context.read(ageprovider2).age.toInt() ;
//
// // Uint8List ecgImage;
//
// //  var container=
// //  Center(
// //      child:Container(
// //        color: Colors.white,
// //        child: Sparkline(
// //          data: context.read(patientProvider).dataFiltered.getRange(0, 700).toList(),
// //          enableGridLines: true,
// //          lineColor: Colors.teal,
// //          lineWidth: 2,
// //          sharpCorners: false,
// //          pointsMode: PointsMode.last,
// //          min:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(min)-50,
// //          max:context.read(patientProvider).dataFiltered.getRange(0, 700).toList().reduce(max)+50,
// //          pointColor: Colors.white70,
// //          gridLineColor: Colors.lightBlueAccent,
// //          gridLineWidth: 5,
// //          // gridLineAmount: 6,
// //        ),
// //      )
// //  );
// //
// // await screenshotController
// //      .captureFromWidget(
// //    InheritedTheme.captureAll(
// //        context, Material(child: container)),
// //    delay: Duration(milliseconds: 500),
// //    pixelRatio: 1.5,
// //  )
// //      .then((capturedImage) async{
// //    ecgImage=capturedImage;
// //  });
//
//
// await Pdfapi.generateCenteredText(name,gender,age,hbmax,hbmin,hbavg,spo2max,spo2min,spo2avg,
// tempmax,tempmin,tempavg, sysmax, sysmin, sysavg, diamax, diamin, diaavg,
// rrmax, rrmin, rravg,context.read(patientProvider).dataFiltered,hrs).onError((error, stackTrace) =>  null);
//
// Navigator.of(context).pop();
// },
// ),
// ),