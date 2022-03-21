import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_monitor/Screen/ListofPatients.dart';
import 'package:doctor_monitor/providers/bmiprovider.dart';
import 'package:doctor_monitor/providers/ecgprovider.dart';
import 'package:doctor_monitor/providers/glucoseprovider.dart';
import 'package:doctor_monitor/providers/hearbeat.dart';
import 'package:doctor_monitor/providers/patient_info_provider.dart';
import 'package:doctor_monitor/providers/patientlistprovider.dart';
import 'package:doctor_monitor/providers/spo2provider.dart';
import 'package:doctor_monitor/providers/systolicprovider.dart';
import 'package:doctor_monitor/providers/temperatureprovider.dart';
import 'package:doctor_monitor/providers/respirationprovider.dart';
import 'package:doctor_monitor/providers/timeprovider_bglucose.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Screen/Authscreen.dart';
import 'Screen/PatientList.dart';





void main() async{

  await WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
    {
      await Firebase.initializeApp(
        options:FirebaseOptions(
          apiKey: "AIzaSyBw6Vhscya2gAgQlSboysJWi3TZoQGtyh8",
          appId: "1:886694662000:web:6665aedb403aec607549b5",
          messagingSenderId: "886694662000",
          projectId: "iotbackend-f31d0",
        ),
      );

    }
  else
    {
      await Firebase.initializeApp(
        // options:FirebaseOptions(
        //   apiKey: "AIzaSyBw6Vhscya2gAgQlSboysJWi3TZoQGtyh8",
        //   appId: "1:886694662000:web:6665aedb403aec607549b5",
        //   messagingSenderId: "886694662000",
        //   projectId: "iotbackend-f31d0",
        // ),
      );
    }

  runApp(ProviderScope(child: MyApp()));
}


// final patient=Provider((ref){
//   return Patient();
// });

final patientProvider=ChangeNotifierProvider((ref)=>Patient());

// final patientAdmitted=StreamProvider.autoDispose<QuerySnapshot>((ref){
//   return Patient().patients;
// });
// final ecgprovider=Provider<List<double>>((ref) {
//   final _hbs=ref.watch(patientProvider);
//   return _hbs.dataToFilter_show;
// } );
//
// final ecgprovider2=ChangeNotifierProvider.autoDispose((ref) {
//   final hbs=ref.watch(ecgprovider);
//   return  EcgPro(hbs);
// } );

final nameprovider=Provider<String>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.name;
} );

final nameprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(nameprovider);
  return  Patientname(hbs);
} );

final ageprovider=Provider<double>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.age;
} );

final ageprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(ageprovider);
  return  Patientage(hbs);
} );

final genderprovider=Provider<String>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.gender;
} );

final genderprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(genderprovider);
  return  PatientGender(hbs);
} );

final fileprovider=Provider<String>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.fileno;
} );

final fileprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(fileprovider);
  return  Patientfile(hbs);
} );

final remarksprovider=Provider<String>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.remarks;
} );

final remarksprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(remarksprovider);
  return  Patientremarks(hbs);
} );

final heartbeats=Provider<double>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.hb;
} );

final heartbeats2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(heartbeats);
  return  Heartbeats(hbs);
} );

final saturation=Provider<double>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.spo2;
} );

final saturation2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(saturation);
  return  SPO2(hbs);
} );

final temperatureprovider=Provider<double>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.temp;
} );

final temperatureprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(temperatureprovider);
  return  Temperature(hbs);
} );

final systolicprovider=Provider<int>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.systolic;
} );

final systolicprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(systolicprovider);
  return  Systolic(hbs);
} );

final diastolicprovider=Provider<int>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.diastolic;
} );

final diastolicprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(diastolicprovider);
  return  Diastolic(hbs);
} );

final glucoseprovider=Provider<int>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.glucose;
} );

final glucoseprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(glucoseprovider);
  return  Glucose(hbs);
} );

final bmiprovider=Provider<double>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.bmi;
} );

final bmiprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(bmiprovider);
  return  Bmi(hbs);
} );


final timeprovider=Provider<String>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.bgtime;
} );

final timeprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(timeprovider);
  return  Time(hbs);
} );

final respirationprovider=Provider<int>((ref) {
  final _hbs=ref.watch(patientProvider);
  return  _hbs.respiration;
} );

final respirationprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(respirationprovider);
  return  RespirationRate(hbs);
} );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                 return Text("Loading");
                }
              if(snapshot.hasData)
              {
                return PatientList();
              }
              else
              {
                return AuthScreen();
              }

            }
        )
    );
  }
}
