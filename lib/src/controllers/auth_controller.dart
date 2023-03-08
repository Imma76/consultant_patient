import 'package:consult_patient/src/models/patient_model.dart';
import 'package:consult_patient/src/services/auth_service.dart';
import 'package:consult_patient/src/services/patient_service.dart';
import 'package:consult_patient/src/utils/widgets/reusable_widget.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class AuthController extends ChangeNotifier{
  bool load = false;
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
 // TextEditingController userNameController= TextEditingController();
  TextEditingController genderController= TextEditingController();
  TextEditingController surNameController= TextEditingController();
  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController= TextEditingController();
  TextEditingController ageController= TextEditingController();
  TextEditingController weightController= TextEditingController();
  TextEditingController heightController= TextEditingController();
  TextEditingController allergiesController= TextEditingController();
  TextEditingController medicalConditionsController= TextEditingController();

  TextEditingController userNameController= TextEditingController();


  Patient? patient;

  AuthService authService = AuthService();
  Future signIn(centralState)async{
   centralState.startLoading();
   print('hhhs${ centralState.isAppLoading}');
    final user=await authService.signIn(email: emailController.text.trim(),password: passwordController.text);
    if(user==null){
      centralState.stopLoading();
      return;
    }
    patient = await PatientService.findPatientById(user.uid);
    notifyListeners();

   // if(login ){
   //   load=false;
   //   notifyListeners();
   //
   // }
  centralState.stopLoading();
   Navigator.pushNamedAndRemoveUntil(navigatorKey!
       .currentContext!, Homepage.id, (route) => false);

  }

  bool checkInputForSignUp(){
    if(surNameController.text.isEmpty){
      showToast('fill in surname');
      return false;;
    }
    if(firstNameController.text.isEmpty){
      showToast('fill in first name');
      return false;;
    }
    if(lastNameController.text.isEmpty){
      showToast('fill in last name');
      return false;;
    }
    if(emailController
        .text.isEmpty){
      showToast('fill in your email address');
      return false;;
    }
    if(genderController.text.isEmpty){
      showToast('fill in your gender');
      return false;;
    }
    if(ageController.text.isEmpty){
      showToast('fill in your age');
      return false;
    }
    if(passwordController.text.isEmpty){
      showToast('fill in your password');
      return false;
    }
    return true;
  }

  bool checkInputForSignIn(){
    if(emailController.text.isEmpty){
      showToast('fill in your email');
      return false;
    }
    if(passwordController.text.isEmpty){
      showToast('fill in your password');
      return false;
    }
    return true;
  }
  Future signUp(centralState)async{
    centralState.stopLoading();
    final user= await  authService.signUp(email: emailController.text.trim(),password: passwordController.text);

    if(user == null){
      centralState.stopLoading();
      return;
    }
     patient =Patient(
      email: emailController.text.trim(),
      userName: userNameController.text.trim(),
      allergies: allergiesController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      medicalConditions: medicalConditionsController.text.trim(),
      height: heightController.text.trim(),
      weight: weightController.text.trim(),
      createdAt: DateTime.now(),
      age:ageController.text.trim(),
      gender: genderController.text.trim(),
      userId:user.uid,
    );
   final createUser = await PatientService.createPatient(patient!);
    if(createUser  == null){
      centralState.stopLoading();
      return;
    }
    centralState.stopLoading();
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(navigatorKey!
        .currentContext!, Homepage.id, (route) => false);
  }

}