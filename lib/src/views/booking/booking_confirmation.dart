import 'package:consult_patient/src/utils/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_theme.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: PrimaryAppBar(context),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius:
                170,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/app_logo.png',width: 107.w,height:94.h),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('You have secured the 10:00-11:00AM slot with  Dr. henry onah. A reminder will be sent to your email shortly before your consultation',textAlign:TextAlign.center,style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 19.sp,fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                ),
                backgroundColor: AppTheme.lightGreen,
              ),
            )
          ],
        ),
      ),
    );
  }
}
