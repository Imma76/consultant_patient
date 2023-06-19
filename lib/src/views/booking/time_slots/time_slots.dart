
import 'package:consult_patient/src/all_providers/all_providers.dart';
import 'package:consult_patient/src/utils/widgets/app_bar.dart';
import 'package:consult_patient/src/utils/widgets/loader.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(appointmentProvider).generateTimeSlots2();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentController= ref.watch(appointmentProvider);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: PrimaryAppBar(context),

      body: appointmentController.load?Indicator2(color: AppTheme.primary,): SingleChildScrollView(
        child: Column(
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
            Gap(30.h),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: appointmentController!.timeSlots.length,
              itemBuilder: (context, index) {
                return  GestureDetector(
                    onTap: (){
                      appointmentController.selectedTimeSlot2(appointmentController!.timeSlots[index]);
                      //appointmentController.selectedTimeSlot(startTime: appointmentController.startTime1,endTime: '${appointmentController.endTime1}' );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TimeSlots(startTime: appointmentController!.timeSlots[index],),
                    ));

              },
            ),
            Gap(24.h),
            // GestureDetector(
            //     onTap: (){
            //       appointmentController.selectedTimeSlot(startTime: appointmentController.startTime2,endTime: '${appointmentController.endTime2}' );
            //     },
            //     child: TimeSlots(startTime: appointmentController.startTime2,endTime: '${appointmentController.endTime2} AM')),
            // Gap(24.h),
            // GestureDetector(
            //     onTap: (){
            //       appointmentController.selectedTimeSlot(startTime: appointmentController.startTime3,endTime: '${appointmentController.endTime3}' );
            //     },
            //     child: TimeSlots(startTime: appointmentController.startTime3,endTime:'${appointmentController.endTime3} PM')),
            // Gap(24.h),
            // GestureDetector(
            //     onTap: (){
            //       appointmentController.selectedTimeSlot(startTime: appointmentController.startTime4,endTime: '${appointmentController.endTime4}' );
            //     },
            //     child: TimeSlots(startTime: appointmentController.startTime4,endTime: '${appointmentController.endTime4} PM')),
            // Gap(24.h),
            // GestureDetector(
            //     onTap: (){
            //       appointmentController.selectedTimeSlot(startTime: appointmentController.startTime5,endTime: '${appointmentController.endTime5}' );
            //     },
            //     child: TimeSlots(startTime: appointmentController.startTime5,endTime: '${appointmentController.endTime5} PM'))


          ],
        ),
      ),

    );
  }
}

class TimeSlots extends ConsumerWidget {
  final String? startTime;
  final String? endTime;
  const TimeSlots({
    Key? key,this.startTime,this.endTime
  }) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final appointmentController= ref.watch(appointmentProvider);
    return Container(
      width: 382.w,height:49.h,
      child: Row(
        children: [
          Gap(63.w),
          Text('$startTime',style: GoogleFonts.poppins(
              color: AppTheme.primary3,
              fontSize: 18.sp,
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

