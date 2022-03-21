import 'package:flutter/foundation.dart';


class Patientname extends ChangeNotifier
{
  final String name;

  Patientname(this.name);

}

class Patientfile extends ChangeNotifier
{
  final String fileNo;

  Patientfile(this.fileNo);

}

class Patientremarks extends ChangeNotifier
{
  final String remarks;
  Patientremarks(this.remarks);

}

class Patientage extends ChangeNotifier
{
  final double age;
  Patientage(this.age);

}

class PatientGender extends ChangeNotifier
{
  final String gender;
  PatientGender(this.gender);

}

