import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../collections/collection.dart';
import '../models/consultant_model.dart';
import '../utils/error_codes.dart';

class ConsultantService{
  static Future findPatient(String userName)async{
    try{
      QuerySnapshot user = await Collections.patientCollection.where(userName,isEqualTo:"userName").get();
      if(user.docs.isNotEmpty){
        final userData = user as Map<dynamic,dynamic>;
        return ConsultantModel.fromJson(userData);
      }
      return null;

    }on SocketException{
      return null;
    } catch(e){
      return null;
    }
  }

  static Future findConsultantById(String userId)async{
    try{
      DocumentSnapshot
      user = await Collections.consultant.doc(userId).get();
      if(!user.exists){
        return null;
      }

      return ConsultantModel.fromJson(user.data() as Map
      );

    }on SocketException{
      return null;
    } catch(e){
      return null;
    }
  }
 static  Stream<List<ConsultantModel>>? getConsultant( {String? orderBy = 'createdAt',
    bool? descending = true,
    var startAt,}){
    try{
      Query query =  Collections.consultant.orderBy("createdAt",descending: true).where("isVerified",isEqualTo:true);

      return query.snapshots()
          .map((snapShot) => snapShot.docs.map<ConsultantModel>((consultant) {
            print(consultant);
        Map _temp = consultant.data() as Map<dynamic, dynamic>;
        _temp['docId'] = consultant.id;
        // //(_temp);
        return ConsultantModel.fromJson(_temp as Map<String, dynamic>);
      }).toList());
    }catch(e){
      return null;
    }
  }

  static Future createConsultant(ConsultantModel consultant)async{
    try{
      final user = await Collections.consultant.doc(consultant.userId).set(consultant.toJson());
      return true;
    }on SocketException {
      return null;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future updateConsultantRatings(double ratings, String? consultantId)async{
    print(ratings);
    try{
      await Collections.consultant.doc(consultantId).update({"ratings":ratings});
      return true;
    }catch(e){
      return false;
    }
    }
  static Future findConsultantEmail(String email)async{
    try{
      QuerySnapshot user = await Collections.consultant.where("email",isEqualTo:email).get();
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
}