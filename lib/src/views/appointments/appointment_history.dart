import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../all_providers/all_providers.dart';
import '../../themes/app_theme.dart';
import '../home/home_page.dart';




class AppointmentHistory extends ConsumerWidget {
  const AppointmentHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentController = ref.watch(appointmentProvider);
    return Scaffold(
      backgroundColor:
      AppTheme.lightGreen,
      body:Padding(
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

            Gap(18.h),
            Text('History',style:GoogleFonts.poppins(color: AppTheme.black2,fontSize: 20.sp,fontWeight: FontWeight.w500)),
          //  Gap(15.h),
            ListView.builder(
              itemCount: appointmentController.appointmentHistory.length,
              shrinkWrap: true,
              itemBuilder: (context,index) {

                return Padding(
                  padding: const EdgeInsets.only(right: 4,left: 4,bottom: 16),
                  child: AppointmentHistoryBlock(
                    consultantName:'${appointmentController.appointmentHistory
                  [index].consultant!.firstName} ${appointmentController.appointmentHistory
                  [index].consultant!.lastName}',
                    appointmentTime:'${appointmentController.appointmentHistory
                  [index].appointmentStartTime!}-${appointmentController.appointmentHistory
                  [index].appointmentEndTime!} ',
                    appointmentDate: appointmentController.appointmentHistory
                [index].appointmentDate,),
                );
              }
            )
          ],
        ),
      ),
    ) ;
  }
}

class AppointmentHistoryBlock extends StatelessWidget {
  final String? consultantName;
  final String? appointmentTime;
  final String? appointmentDate;
  const AppointmentHistoryBlock({
    Key? key,this.consultantName, this.appointmentTime,this.appointmentDate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18,top:
      5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Consultation with Dr. $consultantName',style:GoogleFonts.dmSans(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400)),
          Text('Duration: $appointmentTime  Date: $appointmentDate',style:GoogleFonts.dmSans(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w400))
        ],
      ),
      height: 57.h,width: 382.w,
      decoration: BoxDecoration(color: AppTheme.white,borderRadius: BorderRadius.circular(5)),

    );
  }
}
