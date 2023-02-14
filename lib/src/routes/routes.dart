
import 'package:consult_patient/src/views/authentication/login.dart';
import 'package:consult_patient/src/views/authentication/sign_up.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:consult_patient/src/views/profile/consultants_profile.dart';
import 'package:consult_patient/src/views/time_slots/time_slots.dart';
import 'package:consult_patient/src/views/welcome.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder>routes={
  WelcomeScreen.id:(context)=> WelcomeScreen(),
  LoginScreen.id:(context)=>LoginScreen(),
  SignUpScreen.id:(context)=>SignUpScreen(),
  Homepage.id:(context)=>Homepage(),
  ConsultantProfile.id:(context)=>ConsultantProfile(),
  SelectTimeSlot.id:(context)=>SelectTimeSlot()
};