import 'package:consult_patient/src/utils/widgets/app_bar.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../all_providers/all_providers.dart';
import '../../themes/app_theme.dart';
import '../home/base.dart';

class ConfirmationScreen extends ConsumerStatefulWidget {
  static const id = 'confirmation';

  const ConfirmationScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends ConsumerState<ConfirmationScreen> {
  @override
  void initState() {


    // TODO: implement initState

Future.delayed(Duration(seconds: 3),(){
  Navigator.pushNamedAndRemoveUntil(context, Base.id, (route) => false);
});
  }
  @override
  Widget build(BuildContext context) {
    final appointmentController= ref.read(appointmentProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: PrimaryAppBar(context),
        body:Padding(
          padding: const EdgeInsets.only(left:24.0,right:24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Center(
                child: CircleAvatar(
                  radius:
                  382.r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: Padding(
                        padding: const EdgeInsets.only(left: 25.0,right:25),
                        child: Image.asset('assets/app_logo.png',width: 107.w,height:90.h),
                      )),
Gap(16.5),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0,right:21,bottom: 30),
                        child: Center(child: Text('You have secured the ${appointmentController.selectedStartTime}-${appointmentController.selectedEndTime} slot with  Dr. henry onah. A reminder will be sent to your email shortly before your consultation',textAlign:TextAlign.center,style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 19.sp,fontWeight: FontWeight.w500))),
                      ),

                    ],
                  ),
                  backgroundColor: AppTheme.lightGreen,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
