import 'package:consult_patient/src/utils/widgets/app_bar.dart';
import 'package:consult_patient/src/views/booking/booking_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../themes/app_theme.dart';



class SelectTimeSlot extends ConsumerStatefulWidget {
  static const id= 'time_slots';
  const SelectTimeSlot({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SelectTimeSlotState();
}

class _SelectTimeSlotState extends ConsumerState<SelectTimeSlot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: PrimaryAppBar(context),

      body: Column(
        children: [
          Row(

            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                    'assets/app_logo.png', width: 87.w, height: 77.h),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top:8.0),
                child: Text('Pick a slot', style: GoogleFonts.poppins(
                    color: AppTheme.lightBlack,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),),
              ),
            ],
          ),
          Gap(130.h),
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, ConfirmationScreen.id);
              },
              child: TimeSlots()),
          Gap(24.h),
          TimeSlots(),
          Gap(24.h),
          TimeSlots(),
          Gap(24.h),
          TimeSlots()

        ],
      ),

    );
  }
}

class TimeSlots extends StatelessWidget {
  const TimeSlots({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382.w,height:49.h,
      child: Row(
        children: [
          Gap(63.w),
          Text('8:00 - 9:30 Am',style: GoogleFonts.poppins(
          color: AppTheme.primary3,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500),),
          Spacer(),
          Container(
            height: 49.h,

            width: 122.w,
            child: Center(child: Text('Select', style: GoogleFonts.poppins(
                color: AppTheme.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),)),decoration: BoxDecoration(
            color:
              AppTheme.primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius
            .circular(20),bottomRight:  Radius
                  .circular(20),topRight:  Radius
                  .circular(20),)),)
        ],
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius
      .circular(20),border:Border.all(color: AppTheme.primary) ),
    );
  }
}
