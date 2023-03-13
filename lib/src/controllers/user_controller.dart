

import 'package:consult_patient/src/controllers/central_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/patient_model.dart';
import '../services/patient_service.dart';

class UserController extends ChangeNotifier{

  PatientModel? patient;
  init()async{
    centralState.startLoading();
   patient= await PatientService.findPatientById(FirebaseAuth
       .instance.currentUser
   !.uid);
   centralState.stopLoading();
   notifyListeners();
  }
}

UserController userController = UserController();