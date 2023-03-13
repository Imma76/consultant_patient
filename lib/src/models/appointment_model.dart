import 'package:consult_patient/src/models/consultant_model.dart';
import 'package:consult_patient/src/models/patient_model.dart';

class AppointmentModel{
  DateTime? appointmentStart;
  DateTime ? appointmentEnd;
  ConsultantModel? consultant;
  PatientModel? patient;
  List<String>? updates;
  DateTime? createdAt;
  DateTime? appointmentDate;
  AppointmentModel({this.patient,this.consultant,this.createdAt,this.appointmentDate
  ,this.appointmentEnd,this.appointmentStart,this.updates,});

  AppointmentModel.fromJson(Map data){

    appointmentStart=data['appointmentStart'].toDate();
    appointmentEnd=data['appointmentEnd'].toDate();
    appointmentDate=data['appointmentData'].toDate();
    patient=PatientModel.fromJson(data['patient']);
    consultant=ConsultantModel.fromJson(data['consultant']);
    updates=data['updates'];
    createdAt=data['createdAt'];
  }

  toJson(){
    Map data={};
    data['appointmentStart']=appointmentStart;
    data['appointmentEnd']=appointmentEnd;
    data['appointmentData']= appointmentDate;
    data['patient']=patient;
    data['consultant'] =consultant;
    data['updates'] =updates;
    data['createdAt']=createdAt;
    return data;
  }
}