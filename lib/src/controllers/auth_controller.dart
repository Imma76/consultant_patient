import 'package:consult_patient/src/controllers/user_controller.dart';
import 'package:consult_patient/src/models/patient_model.dart';
import 'package:consult_patient/src/services/auth_service.dart';
import 'package:consult_patient/src/services/patient_service.dart';
import 'package:consult_patient/src/utils/widgets/reusable_widget.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../views/home/base.dart';

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


  PatientModel? patient;

  AuthService authService = AuthService();

  void logOut()async{

  }
  Future signIn(centralState)async{
   centralState.startLoading();


    final user=await authService.signIn(email: emailController.text.trim(),password: passwordController.text);
    if(user==null){
      centralState.stopLoading();
      return;
    }
   await userController.init();
   // if(login ){
   //   load=false;
   //   notifyListeners();
   //
   // }
  centralState.stopLoading();
   Navigator.pushNamedAndRemoveUntil(navigatorKey!
       .currentContext!, Base.id, (route) => false);

  }
  clearControllers(){
    emailController.clear();
    passwordController.clear();
    genderController.clear();
    firstNameController.clear();
    lastNameController.clear();

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
     patient =PatientModel(
      email: emailController.text.trim(),
      surName: surNameController.text.trim(),
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
    await userController.init();
    centralState.stopLoading();
    await PatientService.sendEmail('Welcome to consult, Your account has been created successfully');
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(navigatorKey!
        .currentContext!, Base.id, (route) => false);
  }

}