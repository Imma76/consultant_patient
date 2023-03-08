import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/utils/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../collections/collection.dart';
import '../models/patient_model.dart';
import '../utils/error_codes.dart';

class PatientService{
 static Future findPatient(String userName)async{
    try{
      QuerySnapshot user = await Collections.patientCollection.where(userName,isEqualTo:"userName").get();
      if(user.docs.isNotEmpty){
        final userData = user as Map<dynamic,dynamic>;
        return Patient.fromJson(userData);
      }
      return null;

    }on SocketException{
      return null;
    } catch(e){
      return null;
    }
  }

 static Future createPatient(Patient patient)async{
   try{
     final user = await Collections.patientCollection.add(patient.toJson());
     return true;

   }on SocketException {
     return null;
   } catch(e){
     print(e.toString());
     return null;
   }
 }
}