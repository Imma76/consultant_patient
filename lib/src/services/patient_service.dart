import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/controllers/user_controller.dart';
import 'package:consult_patient/src/utils/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../collections/collection.dart';
import '../models/patient_model.dart';
import '../utils/error_codes.dart';

class PatientService{
 static Future findPatient(String userName)async{
    try{
      QuerySnapshot user = await Collections.patientCollection.where("userName",isEqualTo:userName).get();
      if(user.docs.isNotEmpty){
        final userData = user as Map<dynamic,dynamic>;
        return PatientModel.fromJson(userData);
      }
      return null;

    }on SocketException{
      return null;
    } catch(e){
      return null;
    }
  }
 static Future findPatientEmail(String email)async{
   try{
     QuerySnapshot user = await Collections.patientCollection.where("email",isEqualTo:email).get();
     if(user.docs.isNotEmpty){
      return '';
     }
     return null;

   }on SocketException{
     return null;
   } catch(e){
     print(e.toString());
     return null;
   }
 }

 static Future findPatientById(String userId)async{
   try{
     DocumentSnapshot
     user = await Collections.patientCollection.doc(userId).get();
     if(!user.exists){
       return null;
     }
       return PatientModel.fromJson(user.data() as Map
       );

   }on SocketException{
     return null;
   } catch(e){
     return null;
   }
 }

 static Future createPatient(PatientModel patient)async{
   try{
     final user = await Collections.patientCollection.doc(patient.userId).set(patient.toJson());
     return true;
   }on SocketException {
     return null;
   } catch(e){
     print(e.toString());
     return null;
   }
 }
 static Future sendEmail(String message,{String? email})async{
   try{
     final response= await http.post(Uri.parse('https://email-service-fsmn.onrender.com/mail'),body: {
       "name":"Consult",
       "receiver":email??userController.patient!.email,
       "message":"${message}",
       "sender":"Consultant@gmail.com"
     });
     print(response.body);
   }catch(e){
     print(e.toString());
   }
 }

}