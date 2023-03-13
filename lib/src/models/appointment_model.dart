import 'package:consult_patient/src/models/consultant_model.dart';
import 'package:consult_patient/src/models/patient_model.dart';

class AppointmentModel{
  DateTime? appointmentStart;
  DateTime ? appointmentEnd;
  ConsultantModel? consultant;
  PatientModel? patient;
  List<String>? updates;
  DateTime? createdAt;
  String? appointmentDate;
  String? appointmentTime;
  AppointmentModel({this.patient,this.consultant,this.createdAt,this.appointmentDate
  ,this.appointmentEnd,this.appointmentStart,this.appointmentTime,this.updates,});

  AppointmentModel.fromJson(Map data){

    appointmentStart=data['appointmentStart'].toDate();
    appointmentEnd=data['appointmentEnd'].toDate();
    appointmentDate=data['appointmentData'];
    patient=PatientModel.fromJson(data['patient']);
    consultant=ConsultantModel.fromJson(data['consultant']);
    updates=data['updates'];
    createdAt=data['createdAt'];
    appointmentTime=data['appointmentTime'];
  }

  Map<String,dynamic>toJson(){
    Map<String,dynamic> data={};
    data['appointmentStart']=appointmentStart;
    data['appointmentEnd']=appointmentEnd;
    data['appointmentDate']= appointmentDate;
    data['patient']=patient?.toJson();
    data['consultant'] =consultant?.toJson();
    data['updates'] =updates;
    data['createdAt']=createdAt;
    data['appointmentTime']=appointmentTime;
    return data;
  }
}