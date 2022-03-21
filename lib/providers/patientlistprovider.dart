
import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_monitor/iirjdart/butterworth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:moving_average/moving_average.dart';
import 'package:intl/intl.dart';




class Patient extends ChangeNotifier
{



  Patient()
  {
     patient_list();
    // health_parameters();
  }

 late StreamSubscription<QuerySnapshot> _monitorSubscription;


  double _spo2=0;
  double get spo2=>_spo2;

  double _hb=0;
  double get hb=>_hb;

  double _temprature=0;
  double get temp=>_temprature;

  String _name="";
  String get name=>_name;

  double _age=0;
  double get age => _age;

  String _fileno="";
  String get fileno=>_fileno;

  String _remarks="";
  String get remarks=>_remarks;

  String _bgtime=""; //blood glucose reading time
  String get bgtime=>_bgtime;

  String _gender=""; //gender of patient
  String get gender=>_gender;

  int _systolic=0;
  int _diastolic=0;

  int get systolic => _systolic;

  int get diastolic => _diastolic;


  int _respiration=0;
  int get respiration => _respiration;

  int _glucose=0;
  int get glucose => _glucose;

  double _bmi=0;
  double get bmi => _bmi;

  List<double> dataset = [];

  List<double> dataset_temp=[];

  List<num> filteredData = [];

  List<double> dataToFilter=[];



  List<double>  dataToFilter_show=[];

  Butterworth butterworth = Butterworth();

  final simpleMovingAverage = MovingAverage<num>(
    averageType: AverageType.simple,
    windowSize: 2,
    partialStart: true,
    getValue: (num n) => n,
    add: (List<num> data, num value) => value,
  );


  double _ymin = -10;

  double get ymin => _ymin;

  double _ymax = 40;

  double get ymax => _ymax;

  bool timer_cancel=true;

  bool ecg_playing=false;

  // Stream<QuerySnapshot> _patients= FirebaseFirestore.instance.collection("Patients").where("Status",isEqualTo: "Admitted").snapshots();
  //
  //
  // Stream<QuerySnapshot> get patients => _patients;
  //
  // void search_patient(String search)
  // {
  //   if( search!="" && search!=null)
  //     {
  //
  //       print("Discharged");
  //       _patients=FirebaseFirestore.instance.collection("Patients").where("searchkeyword",arrayContainsAny: [search]).where("Status",isEqualTo: "Admitted").snapshots();
  //       notifyListeners();
  //     }
  //   else
  //     { _patients.drain();
  //       _patients= FirebaseFirestore.instance.collection("Patients").where("Status",isEqualTo: "Admitted").snapshots();
  //       notifyListeners();
  //     }
  // }


  List<QueryDocumentSnapshot<Map<String, dynamic>>> patientList=[];



  List<String> patient_list_names=[];
  List<String> temp_patient_list=[];
  List<String> search_name_list=[];

  List<QueryDocumentSnapshot<Map<String, dynamic>>> vitals=[];

  void search_patient_name(String val)
  {


    if(val!="" && val.isNotEmpty)
      {
        print(val);
        print(temp_patient_list);
        temp_patient_list.forEach((name) {
          if(name.toLowerCase().contains(val))
            {
              print("Contains val");
              if(search_name_list.isNotEmpty )
                {
                  if(search_name_list.contains(name)==false)
                    {
                      search_name_list.add(name);
                    }
                }
              else
                {
                  search_name_list.add(name);
                }

              // patient_list_names.clear();

              print(patient_list_names);
              notifyListeners();
            }
          else
            {
              search_name_list.remove(name);
              print("Contains no val");
            }
        });
        patient_list_names=search_name_list;
        notifyListeners();
      }
    else
      {
        print("clear List");
        search_name_list.clear();
        patient_list_names=temp_patient_list;
        notifyListeners();
      }

  }

  void remove_patient_from_list(String name)
  {
    patient_list_names.clear();
    patient_list_names.add(name);
    print(patient_list_names);
    notifyListeners();
  }

  void patient_list()
  {
    FirebaseFirestore.instance.collection("Patients").where("Status",isEqualTo: "Admitted").snapshots().listen((event)//Admitted
    {
      // print(event.size);
      patientList.clear();
      patient_list_names.clear();
      temp_patient_list.clear();
     event.docs.map((e) {

        // print(e.get("Name"));
        patientList.add(e);
        patient_list_names.add(e.get('Name'));
        temp_patient_list.add(e.get('Name'));
        notifyListeners();

    }).toList();
      patientList.map((patentlist) {
        FirebaseFirestore.instance.collection("/Devices/${patentlist.get('Device').toString()}/Healthparameters2").
        where('PatientsId',isEqualTo: patentlist.id).orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {
          // print(patentlist.get('Name'));
          if(event.docs.isEmpty)
            {
              print("empty");
            }
          event.docs.map((e) {
            vitals.add(e);
            // print(e.data().toString());
            // print(e.get("PatientsId"));
            // print(e.get("heartrate"));
            // print(e.get('SPO2'));
            // print(e.get('temperature'));
            notifyListeners();
            // vitals.where((element) => element.containsValue("Arun"));
          }).toList();
        });
      }).toList();

    });
  }


  String device_id="";
  String patients_id="";
  int hbmaxL=0;
  int hbminL=0;
  int spo2minL=0;
  double sysminL=0;
  double sysmaxL=0;
  double dysminL=0;
  double dysmaxL=0;
  int rrminL=0;
  int rrmaxL=0;
  double tempminL=0.0;
  double tempmaxL=0.0;
  void patient_details(QueryDocumentSnapshot<Map<String, dynamic>> patient_detail)
  {

    device_id=patient_detail.get("Device");
    patients_id=patient_detail.id;
    _name=patient_detail.get("Name");
    _age=patient_detail.get('Age');
    _fileno=patient_detail.get("FileNo");
    _remarks=patient_detail.get("Remarks");
    _gender=patient_detail.get("Gender");
    hbmaxL=patient_detail.get("hbmax");
    hbminL=patient_detail.get("hbmin");
    spo2minL=patient_detail.get("spo2min");
    sysminL==double.parse(patient_detail.get("sysmin").toString());
    sysmaxL=double.parse(patient_detail.get("sysmax").toString());
    dysminL=double.parse(patient_detail.get("dysmin").toString());
    dysmaxL=double.parse(patient_detail.get("dysmax").toString());
    rrmaxL=patient_detail.get("respmax");
    rrminL=patient_detail.get("respmin");
    tempmaxL=double.parse(patient_detail.get("tempmax").toString());
    tempminL=double.parse(patient_detail.get("tempmin").toString());


    print(_name);
    print(_age);
    print(_fileno);
    print(_remarks);
    print(_gender);
    print(hbmaxL);
    print(hbminL);
    print(spo2minL);
    print("tempmax");
    print(tempmaxL);
    print("tempmin");
    print(tempminL);
    notifyListeners();
  }

  void monitor_parameters(String Device,String patient_id)
  {
    CollectionReference monitor=FirebaseFirestore.instance.collection("/Devices/${Device}/Healthparameters2");

    _monitorSubscription=monitor.where('PatientsId',isEqualTo: patient_id).orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {

     _spo2=event.docs[0].data().toString().contains("SPO2")?event.docs[0].get("SPO2"):0;
     _hb=event.docs[0].data().toString().contains("heartrate")?event.docs[0].get("heartrate"):0;
     _temprature=event.docs[0].data().toString().contains("temperature")?event.docs[0].get("temperature"):0;
     _systolic=event.docs[0].data().toString().contains("Sys")?event.docs[0].get("Sys"):0;
     _diastolic=event.docs[0].data().toString().contains("Dys")?event.docs[0].get("Dys"):0;
     _respiration=event.docs[0].data().toString().contains("rr")?event.docs[0].get("rr"):0;
     _glucose=event.docs[0].data().toString().contains("glucose")?event.docs[0].get("glucose"):0;
     _bmi=event.docs[0].data().toString().contains("bmi")?event.docs[0].get("bmi"):0;
     dataset=event.docs[0].data().toString().contains("ecg")?event.docs[0].get("ecg").cast<double>():0;
     _bgtime=event.docs[0].data().toString().contains("time")?event.docs[0].get("time"):"0";//blood glucose reading time
     // var timestamp=event.docs[0].data().toString().contains("Datetime")?event.docs[0].get("Datetime"):"0";
     // var date = DateTime.fromMillisecondsSinceEpoch(event.docs[0].data().toString().contains("Datetime")?event.docs[0].get("Datetime"):"0" );
     // final date=timestamp.toDate();
     // final fifteenAgo = date.subtract(new Duration(minutes: 15));
     // print(date);
     // print(fifteenAgo);
     butterworth.bandStop(2, 200, 250, 20);
            filteredData=simpleMovingAverage(dataset);
            dataToFilter =
                filteredData.map((e) => butterworth.filter(e.toDouble())).toList();
            // if(dataset.isNotEmpty)
            //   {
            //     _ymax = dataToFilter.reduce(max)+25;
            //     _ymin = dataToFilter.reduce(min)-25;
            //   }
            // _ymax = dataToFilter.reduce(max)+25;
            // _ymin = dataToFilter.reduce(min)-25;
            notifyListeners();
            ecg_generator(dataToFilter);
            // ecg_graph_data(dataToFilter);
     // if(ecg_playing==false)
     //   {
     //     dataset=event.docs[0].data().toString().contains("ecg")?event.docs[0].get("ecg").cast<double>():0;
     //     if(dataset.isEmpty)
     //     {
     //       return;
     //     }
     //     else
     //     {
     //       butterworth.bandStop(2, 200, 250, 20);
     //       filteredData=simpleMovingAverage(dataset);
     //       dataToFilter =
     //           filteredData.map((e) => butterworth.filter(e.toDouble())).toList();
     //       _ymax = dataToFilter.reduce(max)+25;
     //       _ymin = dataToFilter.reduce(min)-25;
     //       notifyListeners();
     //       ecg_generator_1(dataset);
     //
     //     }
     //   }
     // else
     //   {
     //     dataset_temp=event.docs[0].data().toString().contains("ecg")?event.docs[0].get("ecg").cast<double>():0;
     //     if(dataset_temp.isEmpty)
     //     {
     //       return;
     //     }
     //     else
     //     {
     //       butterworth.bandStop(2, 200, 250, 20);
     //       filteredData=simpleMovingAverage(dataset_temp);
     //       dataToFilter =
     //           filteredData.map((e) => butterworth.filter(e.toDouble())).toList();
     //       _ymax = dataToFilter.reduce(max)+25;
     //       _ymin = dataToFilter.reduce(min)-25;
     //       notifyListeners();
     //       ecg_generator_1(dataset_temp);
     //     }
     //   }
     // dataset=event.docs[0].data().toString().contains("ecg")?event.docs[0].get("ecg").cast<double>():0;
   });
  }


  int i=0;
  List<double> _dataToFilter=[];
  List<double> _dataToFilter_buffer=[];

  void ecg_generator(List<double> dataToFilter)
  {
    // print("i-top");
    // print(i);
    // _dataToFilter.addAll(dataToFilter);
    // print(" _dataToFilter_buffer.length");
    // print( _dataToFilter_buffer.length);


    if(ecg_playing==false)
      {
        _dataToFilter.addAll(dataToFilter);
        ecg_playing=true;
        Timer.periodic(Duration(milliseconds: 10), (Timer T)
        {

          if(_dataToFilter.isNotEmpty && i<=_dataToFilter.length && timer_cancel==false)
          {
            // print(ECglist[i]);
            // print(dataToFilter[i]);
            // print("i-middle");
            // print(i);
            dataToFilter_show=_dataToFilter.getRange(0, i).map((e) => e).toList();

            if(dataToFilter_show.length>350)
            {
              _ymax = _dataToFilter.reduce(max)+25;
              _ymin = _dataToFilter.reduce(min)-25;
              dataToFilter_show.removeRange(0,2);//2
              _dataToFilter.removeRange(0, 2);//2
              notifyListeners();

            }
            else{
              i++;

            }

          }
          else
          {

            if(_dataToFilter_buffer.isEmpty)
              {
                T.cancel();
                // print("Cancel Timer");
                //
                // print(_dataToFilter.length);
                // print("i");
                // print(i);

                ecg_playing=false;
              }
            // i=0;
           else
             {
               if(_dataToFilter_buffer.length>500)
                 {
                   // print(_dataToFilter_buffer.length  );
                   _dataToFilter.addAll(_dataToFilter_buffer.getRange(0, 500));
                   _dataToFilter_buffer.removeRange(0, 500);
                 }
               else
                 {
                   _dataToFilter.addAll(_dataToFilter_buffer);
                   _dataToFilter_buffer.removeRange(0, _dataToFilter_buffer.length);
                 }
             }

          }
          notifyListeners();
        });
      }
    else
      {
        _dataToFilter_buffer.addAll(dataToFilter);
      }


  }

  List<double> _dataToFilter_buffer1=[];
  List<double> _dataToFilter_buffer2=[];
  int j=4;
void ecg_graph_data(List<double> dataToFilter)
{
  if(_dataToFilter_buffer1.isEmpty)
    {
      _dataToFilter_buffer1=dataToFilter;
      // print(_dataToFilter_buffer1.length);
    }
  else
    {
      _dataToFilter_buffer2.addAll(dataToFilter);
      if(_dataToFilter_buffer2.length>6000)
        {
          j=8;
        }
      else
        {
          j=4;
        }
    }
  if(ecg_playing==false)
    {
      ecg_playing=true;
      Timer.periodic(Duration(milliseconds: 20), (Timer T)
      {
        if(_dataToFilter_buffer1.isNotEmpty && i<=_dataToFilter_buffer1.length && timer_cancel==false)
        {
          dataToFilter_show=_dataToFilter_buffer1.getRange(0, i).map((e) => e).toList();

          if(dataToFilter_show.length>350)
          {

            _ymax = _dataToFilter_buffer1.reduce(max)+25;
            _ymin = _dataToFilter_buffer1.reduce(min)-25;

            dataToFilter_show.removeRange(0,j);//2
            _dataToFilter_buffer1.removeRange(0, j);//2
            notifyListeners();

          }
          else
          {
            i++;
          }
        }
        else
        {

          if(_dataToFilter_buffer2.isNotEmpty)
          {
            _dataToFilter_buffer1.addAll(_dataToFilter_buffer2);
            _dataToFilter_buffer2.clear();
          }
          else
          {
            T.cancel();
            // print("dataToFilter_show");
            // print(dataToFilter_show.length);
            ecg_playing=false;
          }


        }
      });
    }

}
  // if(ecg_playing==false)
  // {
  //
  // ecg_playing=true;
  // Timer.periodic(Duration(milliseconds: 10), (Timer T)
  // {
  //
  // if(_dataToFilter.isNotEmpty && i<=_dataToFilter.length && timer_cancel==false)
  // {
  // // print(ECglist[i]);
  // // print(dataToFilter[i]);
  // // print("i-middle");
  // // print(i);
  // dataToFilter_show=_dataToFilter.getRange(0, i).map((e) => e).toList();
  //
  // if(dataToFilter_show.length>350)
  // {
  // _ymax = dataToFilter.reduce(max)+25;
  // _ymin = dataToFilter.reduce(min)-25;
  // dataToFilter_show.removeRange(0,2);//2
  // _dataToFilter.removeRange(0, 2);//2
  // notifyListeners();
  //
  // }
  // else{
  // i++;
  //
  // }
  //
  // }
  // else
  // {
  // // i=0;
  // T.cancel();
  // print("Cancel Timer");
  //
  // print(_dataToFilter.length);
  // print("i");
  // print(i);
  //
  // ecg_playing=false;
  // }
  // notifyListeners();
  // });
  // }

  void cancel_monitor()
  {
    _monitorSubscription.cancel();
    dataset.clear();
    filteredData.clear();
    dataToFilter.clear();
    dataToFilter_show.clear();
    _dataToFilter.clear();
    _dataToFilter_buffer.clear();
    ecg_playing=false;
    notifyListeners();
  }
  void health_parameters()
  {
    patientList.map((patentlist) {
      FirebaseFirestore.instance.collection("/Devices/${patentlist.get('Device').toString()}/Healthparameters2").
      where('PatientsId',isEqualTo: patentlist.id).orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {
        print(patentlist.get('Name'));

        event.docs.map((e) {
          print(e.get("heartrate"));
          print(e.get('SPO2'));
          print(e.get('temperature'));
        }).toList();
        // print(event.get('heartrate'));
        // print(event.get('SPO2'));
        // print(event.get('temperature'));
      });
    });

  }


  //function for report generation

  double? spo2max=0;
  double? spo2min=0;
  double? spo2avg=0;

  double? hbmax=0;
  double? hbmin=0;
  double? hbavg=0;

  double? tempmax=0;
  double? tempmin=0;
  double? tempavg=0;

  int? sysmax=0;
  int? sysmin=0;
  double? sysavg=0;

  int? dimax=0;
  int? dimin=0;
  double? diavg=0;

  int? rrmax=0;
  int? rrmin=0;
  double? rravg=0;

  List<double>? dataFiltered=[];

  List? list=<Map>[];
  List? list2=<Map>[];


  Future<void> reportDate(int hrs) async
  {
    CollectionReference monitor=FirebaseFirestore.instance.collection("/Devices/${device_id}/Healthparameters2");
    print(DateFormat.yMEd().add_jms().format(DateTime.now()));
    List<double> heartrate=[];
    List<double> spo2=[];
    List<double> temp=[];
    List<int> sys=[];
    List<int> dys=[];
    List<int> RR=[];


    List<double> ecg=[];
    List<num> filterdata = [];




    await monitor.where('PatientsId',isEqualTo: patients_id).
    where("Datetime",isGreaterThan:DateTime.now().subtract(new Duration(hours: hrs))).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print(doc["Datetime"]);
        
        list?.add({"Date":DateTime.fromMicrosecondsSinceEpoch(doc["Datetime"].microsecondsSinceEpoch),
                  "HeartRate":doc["heartrate"],
                    "SPO2":doc["SPO2"],
                     "Temperature":doc["temperature"],
                      "Systoloic":doc["Sys"],
                       "Dystolic":doc["Dys"],
                       "RR":doc["rr"],
                        "Sugar":doc["glucose"]
                       });

        heartrate.add(doc["heartrate"]);
        spo2.add(doc["SPO2"]);
        temp.add(doc["temperature"]);
        sys.add(doc["Sys"]);
        dys.add(doc["Dys"]);
        RR.add(doc["rr"]);
        ecg=doc["ecg"].cast<double>();


        // double havg=heartrate.fold(0, (avg, element) => avg+element/heartrate.length);
        // print(havg);
        // spo2.add(doc["SPO2"]);
        // temp.add(doc["temperature"]);
        // sys.add(doc["Sys"]);
        // dys.add(doc["Dys"]);
        // print(doc["heartrate"]);
        // print(doc["temperature"]);
        // print(doc["SPO2"]);
        // print(doc["Sys"]);
        // print(doc["Dys"]);
      });
    });
    // print(ecg.length);
    heartrate.removeWhere((element) => element==0);
    spo2.removeWhere((element) => element==0);
    temp.removeWhere((element) => element==0);
    RR.removeWhere((element) => element==0);
    sys.removeWhere((element) => element==0);
    dys.removeWhere((element) => element==0);


    butterworth.bandStop(2, 200, 250, 20);
    filterdata=simpleMovingAverage(ecg.isNotEmpty?ecg:[]);
    dataFiltered =
        filterdata.map((e) => butterworth.filter(e.toDouble())).toList();



    hbavg=(heartrate.isNotEmpty?heartrate.fold(0, (avg, element) => avg!+element/heartrate.length):null);
    hbmax=(heartrate.isNotEmpty?heartrate.reduce(max):null);
    hbmin=(heartrate.isNotEmpty?heartrate.reduce(min):null);

    spo2avg=(spo2.isNotEmpty?spo2.fold(0, (avg, element) => avg!+element/spo2.length):null);
    spo2max=(spo2.isNotEmpty?spo2.reduce(max):null);
    spo2min=(spo2.isNotEmpty?spo2.reduce(min):null);

    tempavg=(temp.isNotEmpty?temp.fold(0, (avg, element) => avg!+element/temp.length):null);
    tempmax=(temp.isNotEmpty?temp.reduce(max):null);
    tempmin=(temp.isNotEmpty?temp.reduce(min):null);

    sysavg=(sys.isNotEmpty?sys.fold(0, (avg, element) => avg!+element/sys.length):null);
    sysmax=(sys.isNotEmpty?sys.reduce(max):null);
    sysmin=(sys.isNotEmpty?sys.reduce(min):null);

    diavg=(dys.isNotEmpty?dys.fold(0, (avg, element) => avg!+element/dys.length):null);
    dimax=(dys.isNotEmpty?dys.reduce(max):null);
    dimin=(dys.isNotEmpty?dys.reduce(min):null);

    rravg=(RR.isNotEmpty?RR.fold(0, (avg, element) => avg!+element/RR.length):null);
    rrmax=(RR.isNotEmpty?RR.reduce(max):null);
    rrmin=(RR.isNotEmpty?RR.reduce(min):null);

   DateTime? startdate=list!.isNotEmpty?list![0]["Date"]:null;
    print("startdate");
   print(startdate);
   // list2?.add(list!.isNotEmpty?list![0]:<Map>[]);
    list!.isNotEmpty?list2!.add(list![0]):null;

    // print(list?[17]["Date"].hour-startdate?.hour);
    list?.forEach((element) {
      // print(startdate.minute-element["Date"].minute);
      if(element["Date"].hour-startdate?.hour==0 && element["Date"].day==startdate?.day)
        {
          if(element["Date"].minute-startdate?.minute==5 )
          {

            print(element["Date"].day);
            startdate=element["Date"];
            list2?.add(element);
          }
         else if(element["Date"].minute-startdate?.minute>5 )
          {

            print(element["Date"].day);
            startdate=element["Date"];
            list2?.add(element);
          }

        }
       if(element["Date"].hour-startdate?.hour==1 && element["Date"].day==startdate?.day)
        {

          if(5-(60-startdate!.minute)==element["Date"].minute)//15 minute is the interval
              {
            print(element["Date"].day);
            startdate=element["Date"];
            list2?.add(element);
              }
          else if(5<(60-startdate!.minute))//15 minute is the interval
              {
            print(element["Date"].day);
            startdate=element["Date"];
            list2?.add(element);
          }


        }
       if(element["Date"].hour-startdate?.hour>1 && element["Date"].day==startdate?.day)
        {


              print(element["Date"].day);
              startdate=element["Date"];
              list2?.add(element);
        }
       if(element["Date"].day!=startdate?.day)
         {
           print(element["Date"].day);
           startdate=element["Date"];
           list2?.add(element);
         }

    });




    // print(sysmax.toString()+"/"+dys[sys.indexOf(sysmax)].toString());
    //
    //
    // print(sys[dys.indexOf(dimax)].toString()+"/"+dimax.toString());
    //
    // print(sys);
    // print(dys);


    // double havg=heartrate.fold(0, (avg, element) => avg+element/heartrate.length);
    // print(havg);
    // heartrate.map((e) => e);

    // print(x.get("heartrate"));
    // _monitorSubscription=monitor.where('PatientsId',isEqualTo: patient_id).orderBy("Datetime",descending: true).limit(1).snapshots().listen((event) {
    //
    //
    // });
    }

    void clearListpdf()
    {
      list?.clear();
      list2?.clear();
    }
}