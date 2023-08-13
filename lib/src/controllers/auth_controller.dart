import 'package:consult_patient/src/controllers/user_controller.dart';
import 'package:consult_patient/src/models/patient_model.dart';
import 'package:consult_patient/src/services/auth_service.dart';
import 'package:consult_patient/src/services/patient_service.dart';
import 'package:consult_patient/src/utils/widgets/reusable_widget.dart';
import 'package:consult_patient/src/views/authentication/login.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../themes/app_theme.dart';
import '../views/home/base.dart';

class AuthController extends ChangeNotifier{
  bool load = false;
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
 // TextEditingController userNameController= TextEditingController();
  TextEditingController genderController= TextEditingController(text: '');
  TextEditingController surNameController= TextEditingController();
  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController= TextEditingController();
  TextEditingController ageController= TextEditingController();
  TextEditingController weightController= TextEditingController();
  TextEditingController heightController= TextEditingController();
  TextEditingController allergiesController= TextEditingController();
  TextEditingController medicalConditionsController= TextEditingController();

  TextEditingController userNameController= TextEditingController();


  changeGender (value) {
    genderController.text =value!;
    notifyListeners();
    notifyListeners();
  }

  PatientModel? patient;

  AuthService authService = AuthService();

  void logOut()async{

  }
  Future signIn(centralState)async{
   centralState.startLoading();


    final user=await authService.signIn(email: emailController.text.trim(),password: passwordController.text);


    if(user==false){
      centralState.stopLoading();
      return;
    }
    final patientMail = await PatientService.findPatientEmail(user.email);
    if(patientMail == null){
      showToast("account does not exist");
      return;
    }
   await userController.init();
   if(userController.patient!= null){
     if(userController.patient!.verificationStatus == 'banned' || userController.patient!.verificationStatus=='restricted') {



       showDialog(context: navigatorKey.currentState!.context, builder: (context){
         return Dialog(
           backgroundColor:
           AppTheme.white
           ,
           child: Container(
             decoration: BoxDecoration(   color:
             AppTheme.white,borderRadius: BorderRadius.circular(10.r)),
             height:
             165.h,
             width: 390.w,

             child: Column(
               children: [
                 Gap(22.h),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text('Your Account has been ${userController.patient!.verificationStatus} by the admin ',textAlign: TextAlign.center,style: GoogleFonts.dmSans(
                       color: AppTheme.lightBlack,
                       fontSize: 16.sp,
                       fontWeight: FontWeight.w500),),
                 ),

                 Gap(24.h),
                 ElevatedButton(onPressed: () async{
                   print('rating');
                   Navigator.pop(context);
                 },
                   child: Text('Okay', style: GoogleFonts.poppins(
                       color: AppTheme.white,
                       fontSize: 20.sp,
                       fontWeight: FontWeight.w700),),
                   style: ElevatedButton.styleFrom(primary: AppTheme.primary,
                       minimumSize: Size(108.w, 52.h),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
               ],
             ),
           ),

         );
       });
       centralState.stopLoading();
       return;
     }

   }

  centralState.stopLoading();
   Navigator.pushNamedAndRemoveUntil(navigatorKey!
       .currentContext!, Base.id, (route) => false);

  }



  Future resetPassword(centralState)async{
    if(emailController.text.isEmpty){
      showToast("Enter your email");
      return;
    }
    centralState.startLoading();

    final getEmailAddress = await PatientService.findPatientEmail(emailController.text.trim());
    if(getEmailAddress == null){
      showToast("User does not exist");
      centralState.stopLoading();
      return;
    }



    final user=await authService.resetPassword(email: emailController.text.trim(),);
    if(user==null){
      centralState.stopLoading();
      return;
    }

    centralState.stopLoading();
    showDialog(context: navigatorKey!
        .currentContext!, builder: (context) {
      return Dialog(
        backgroundColor:
        AppTheme.white
        ,
        child: Container(
          decoration: BoxDecoration(color:
          AppTheme.white, borderRadius: BorderRadius.circular(10.r)),
          height:
          150.h,
          width: 382.w,

          child: Column(
            children: [
              Gap(22.h),
              Center(
                child: Text('Password reset link has been sent to your email',textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      color: AppTheme.lightBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),),
              ),
              Gap(24.h),

              ElevatedButton(onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(navigatorKey!
                    .currentContext!,);
              },
                child: Text('Okay', style: GoogleFonts.poppins(
                    color: AppTheme.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),),
                style: ElevatedButton.styleFrom(primary: AppTheme.primary,
                    minimumSize: Size(108.w, 48.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),),
            ],
          ),
        ),

      );
    });



  }
  clearControllers(){
    emailController.clear();
    passwordController.clear();
    genderController.clear();
    firstNameController.clear();
    lastNameController.clear();

  }

  bool checkInputForSignUp(){
    // if(surNameController.text.isEmpty){
    //   showToast('fill in surname');
    //   return false;;
    // }
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
  bool loadAuth = false;

  Future signUp(centralState)async{
    //centralState.stopLoading();
     loadAuth = true;
    notifyListeners();
    final user= await  authService.signUp(email: emailController.text.trim(),password: passwordController.text);

    if(user == null){
      loadAuth = false;
      notifyListeners();
      centralState.stopLoading();
      return;
    }
     patient =PatientModel(
      email: emailController.text.trim(),
      surName: surNameController.text.trim(),
      allergies: allergiesController.text.trim(),

      verificationStatus: '',
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
      loadAuth = false;
      notifyListeners();
      return;
    }
    await userController.init();

    await PatientService.sendEmail('Welcome to consult, Your account has been created successfully');
    notifyListeners();
     loadAuth = false;
     notifyListeners();
    Navigator.pushNamedAndRemoveUntil(navigatorKey!
        .currentContext!, LoginScreen.id, (route) => false);
  }

}