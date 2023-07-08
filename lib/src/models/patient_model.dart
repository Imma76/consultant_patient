import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel{

  String? surName;
  String? email;
  String? firstName;
  String? lastName;
  String? age;
  String? weight;
  String? height;
  String? gender;
  String? allergies;
  DateTime? createdAt;
  String? userId;
  String?verificationStatus;
  String? medicalConditions;
  PatientModel({this.email,this.surName,this.verificationStatus,this.lastName,this.userId,this.firstName,this.medicalConditions,this.allergies,this.height,this.createdAt,this.age,this.gender,this.weight});

  PatientModel.fromJson(Map<dynamic,dynamic> data){
    surName=data['lastName'];
    email=data['email'];
    firstName=data['firstName'];
    verificationStatus= data['verificationStatus'];
    lastName=data['lastName'];
    age=data['age'];
    weight=data['weight'];
    height=data['height'];
    if(data['createdAt']!=null)
    createdAt=Timestamp(data['createdAt'].seconds,data['createdAt'].nanoseconds).toDate();
    gender=data['gender'];
    allergies=data['allergies'];
    medicalConditions=data['medicalConditions'];
    userId=data['userId'];
  }

   toJson(){
    Map<String,dynamic> data=<String, dynamic>{};
    data['surName']=surName;
    data['email']=email;
    data['firstName']=firstName;
    data['lastName']=lastName;
    data['age']=age;
    data['weight']=weight;
    data['height']=height;
    data['gender']=gender;
    data['allergies']=allergies;
    data['verificationStatus']= verificationStatus;
    data['userId']=userId;
    data['createdAt']=createdAt;
    data['medicalConditions']=medicalConditions;
    return data;
  }
}