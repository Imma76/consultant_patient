import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/models/consultant_model.dart';
import 'package:consult_patient/src/models/patient_model.dart';

class AppointmentModel{
  DateTime? appointmentStart;
  DateTime ? appointmentEnd;
  ConsultantModel? consultant;
  PatientModel? patient;
  List<DateTime>? updates;
  DateTime? createdAt;
  String? appointmentDate;
  String? appointmentStartTime;
  String? appointmentEndTime;
  String? appointmentId;
  bool? sessionEnded;
  bool? isVerified;
  AppointmentModel({this.patient,this.consultant,this.createdAt,this.appointmentDate
  ,this.appointmentEnd,this.appointmentStart,this.appointmentStartTime,this.sessionEnded,this.updates,this.appointmentEndTime,this.isVerified});

  AppointmentModel.fromJson(Map data){

    appointmentStart=Timestamp(data['appointmentStart'].seconds,data['appointmentStart'].nanoseconds).toDate();
    appointmentEnd=Timestamp(data['appointmentEnd'].seconds,data['appointmentEnd'].nanoseconds).toDate();
    appointmentDate=data['appointmentDate'];
    patient=PatientModel.fromJson(data['patient']);
    consultant=ConsultantModel.fromJson(data['consultant']);
    isVerified =data['isVerified'];
    if(updates!=null)
      data['updates'].map((e){
        updates!.add(Timestamp(e.seconds,e.nanoseconds).toDate());
      });
    //updates=List<DateTime>.from(Timestamp(data['updates'].seconds,data['updates'].nanoseconds).toDate());
    createdAt=Timestamp(data['createdAt'].seconds,data['createdAt'].nanoseconds).toDate();
    appointmentStartTime=data['appointmentStartTime'];
    appointmentEndTime
     = data['appointmentEndTime'];
    sessionEnded = data['sessionEnded']??false;
  //  appointmentId=data['appointmentId'];
    appointmentId=data['appointmentId'];
  }

  Map<String,dynamic>toJson(){
    Map<String,dynamic> data={};
    data['appointmentStart']=appointmentStart;
    data['appointmentEnd']=appointmentEnd;
    data['appointmentDate']= appointmentDate;
    data['patient']=patient?.toJson();
    data['consultant'] =consultant?.toJson();
    data['sessionEnded'] = sessionEnded;
    data['updates'] =updates;
    data['createdAt']=createdAt;
    data['appointmentId']=appointmentId;
    data['appointmentStartTime'] = appointmentStartTime;
    data['appointmentEndTime'] = appointmentEndTime;
    data['isVerified'] = isVerified;
    return data;
  }
}