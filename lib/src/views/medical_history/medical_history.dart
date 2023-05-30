import 'package:consult_patient/src/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_theme.dart';
import '../home/home_page.dart';

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppTheme.lightGreen,
      body: Padding(
        padding: const EdgeInsets.only(left:20.0,right:
        24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(35.h),
            Column(
              children: [
                Image.asset('assets/app_logo.png',width: 87.w,height:77.h),

              ],
            ),
            Gap(16.h),
            Padding(
              padding: const EdgeInsets.only(left:2.0),
              child: Row(
                children: [
                  Avatar(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top:2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(

                          children: [
                            TimeWidget(time: DateTime.now().day.toString(),),Gap(8.w), TimeWidget(time: DateTime.now().month.toString(),),Gap(8.w), TimeWidget(time: '${DateTime.now().year}'.split('0')[1],)

                          ],
                        ),
                        Gap(4.h),
                        Text('Date',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Gap(16.h),
            Text('${userController.patient!.firstName!.toUpperCase()} ${userController.patient!.lastName!.toUpperCase()}',style:  GoogleFonts.poppins(color: AppTheme.black2,fontSize: 24.sp,fontWeight: FontWeight.w700),),
            Gap(8),
            Text('- Weight - ${userController.patient!.weight!.toUpperCase()}',style:  GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w500),),
            Gap(8),
            Text('- Height - ${userController.patient!.height!.toUpperCase()}',style:  GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w500),),
            Gap(8),
            Text('- Allergies - ${userController.patient!.allergies!.toUpperCase()}',style:  GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w500),),
            Gap(8),
            Text('- Other Medical Conditions - ${userController.patient!.medicalConditions!.toUpperCase()}',style:  GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w500),),

          ],
        ),
      ),
    );
  }
}
