import 'package:consult_patient/src/views/authentication/sign_up.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_theme.dart';


class LoginScreen extends ConsumerStatefulWidget {
  static const id = 'login';
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.only(left:24.w,right:24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Gap(24.h),
                Row(
mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:20.0),
                      child: Image.asset('assets/app_logo.png',width:87.w, height:77.h),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:12.0),
                      child: Text('Patient Sign in',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 24.sp,fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),Gap(104.h),
                Text('Username',style: GoogleFonts.poppins(color: AppTheme.lightBlack
                    ,fontSize: 16.sp,fontWeight: FontWeight.w400),),
                Gap(8.h),
                SizedBox(
                  height:
                  60.h,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                        focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
                      ),
                    ),
                  ),
                ),
                Gap(24.h),
                Text('Password',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 16.sp,fontWeight: FontWeight.w400),),
                Gap(8.h),
                SizedBox(
                  height:
                  60.h,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                          focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
                      ),
                    ),
                  ),
                ),

                Gap(104.h),
                ElevatedButton(onPressed: (){

Navigator.pushNamed(context, Homepage.id);
                }, child:Text('Sign in',style: GoogleFonts.poppins(color: AppTheme.white,fontSize: 24.sp,fontWeight: FontWeight.w700),),style: ElevatedButton.styleFrom(primary: AppTheme.primary2,minimumSize: Size(382.w,58.h),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), ),
            Gap(24.h),
                GestureDetector(
              onTap: () {
               Navigator.pushNamed(context, SignUpScreen.id);
              },
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Dont have an account?',
                          style: GoogleFonts.dmSans(

                              fontSize: 16.sp,
                              color: AppTheme.black3,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: ' Sign up',
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: AppTheme.primary2,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ))


              ],
            ),
          ),
        ),
      ),
    );
  }
}
