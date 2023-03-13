import 'package:consult_patient/src/utils/widgets/app_bar.dart';
import 'package:consult_patient/src/views/booking/time_slots/time_slots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../all_providers/all_providers.dart';
import '../../themes/app_theme.dart';


class DateSlot extends ConsumerStatefulWidget {
  static const id='date slot';
  const DateSlot({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DateSlotState();
}

class _DateSlotState extends ConsumerState<DateSlot> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(appointmentProvider);
  }
  @override
  Widget build(BuildContext context) {
    final appointmentController= ref.watch(appointmentProvider);
    return Scaffold(
      appBar: PrimaryAppBar(context),
backgroundColor: AppTheme.backgroundColor,
      body: Column(


        //mainAxisAlignment: MainAxisAlignment.center
        //,
        children: [
          Row(

            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                    'assets/app_logo.png', width: 87.w, height: 77.h),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: Text('Select a date', style: GoogleFonts.poppins(
                    color: AppTheme.lightBlack,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),),
              ),
            ],
          ),
      Gap(64.h),
      Padding(
        padding: EdgeInsets.only(left: 20.w,right:20.h),
        child: Container(


          color: AppTheme.lightGreen
          ,
          child: TableCalendar(
           weekNumbersVisible:
            false
            ,

availableCalendarFormats:
            {
              CalendarFormat.month: 'Month',
            },
daysOfWeekHeight:
            40,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
           currentDay: DateTime.now(),
           headerStyle: HeaderStyle(titleCentered: true),
            daysOfWeekStyle:
            DaysOfWeekStyle(decoration: BoxDecoration()),
           calendarStyle: CalendarStyle(
             cellPadding: EdgeInsets.all(4),
             //    markerDecoration : const BoxDecoration(color: const Color(0xFF263238), shape: BoxShape.circle),
               //  todayTextStyle : const TextStyle(color: AppTheme.black, fontSize: 16.0),
             //
                 //todayDecoration : const BoxDecoration(color: AppTheme.black, shape: BoxShape.circle),
             //    selectedTextStyle : const TextStyle(color: const Color(0xFFFAFAFA), fontSize: 16.0),
            // selectedDecoration : const BoxDecoration(color: AppTheme.white, shape: BoxShape.circle),
             //  rangeStartTextStyle : const TextStyle(color: const Color(0xFFFAFAFA), fontSize: 16.0),
             // rangeStartDecoration : const BoxDecoration(color: const Color(0xFF6699FF), shape: BoxShape.circle),
             //
             //  rangeEndTextStyle :const TextStyle(color: const Color(0xFFFAFAFA), fontSize: 16.0),
             //    rangeEndDecoration : const BoxDecoration(color: const Color(0xFF6699FF), shape: BoxShape.circle),
             //    withinRangeTextStyle : const TextStyle(),
             //   defaultDecoration :const BoxDecoration(shape: BoxShape.circle,color: AppTheme.black),
             //  // rowDecoration : const BoxDecoration(color: AppTheme.lightGreen),
               tableBorder : const TableBorder(
                 // horizontalInside: BorderSide(color: AppTheme.black,strokeAlign: StrokeAlign.outside)
               ),
             tablePadding: EdgeInsets.only(bottom:10,right: 10,left:
             10)
             //  rowDecoration:BoxDecoration(color: AppTheme.lightGreen),

           ),
           // selectedDayPredicate: (date){
           //
           //
           //  if (date.day!=DateTime.now().day){
           //
           //   // return false;
           //  }
           //
           // // return true;
           // },
            calendarBuilders: CalendarBuilders(
                todayBuilder:  (BuildContext context, DateTime date, _) {
                  return Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: GestureDetector(
                      onTap: (){
                        appointmentController.changeSelectedDate(date);
                        Navigator.pushNamed(context, SelectTimeSlot.id);},
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left:5,right:5),

                          child: Text(date.day
                              .toString(),
                            style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color:
                                //  AppTheme.red
                                AppTheme.lightBlack),),   decoration: BoxDecoration(
                          color: AppTheme.white
                          ,border:
                      Border.symmetric(
                          vertical: BorderSide(
                              color: AppTheme.black
                          ),
                        horizontal: BorderSide(
                            color: AppTheme.black
                        ),

                      ),


                      )),
                    ),
                  );
                },
                defaultBuilder:
                (BuildContext context, DateTime date, _) {
              return GestureDetector(
                onTap: (){
                  if(
                  date.isAfter(DateTime.now())==true
                  //||
                     // DateTime.now().isAtSameMomentAs(date)==true
                  ){

                    appointmentController.changeSelectedDate(date);
                    Navigator.pushNamed(context, SelectTimeSlot.id);
                  }else{
                    print('efore');
                  }

                  },
                child : Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left:5,right:5),

                      child: Text(date.day
                      .toString(),
                      style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color:
                      //  AppTheme.red
                      AppTheme.lightBlack)),   decoration: BoxDecoration(
                      color: AppTheme.white,border:
                  Border.symmetric(
                    vertical: BorderSide(
                      color: AppTheme.black
                    ),horizontal: BorderSide(
                      color: AppTheme.black
                  ),
                      ),
                      // borderRadius:
                      // BorderRadius.all(Radius.circular(1)
                      // )


                  )),
                ),
              );
            }, outsideBuilder: (context, date, _) {
              return GestureDetector(
                onTap: (){
                  if(date.month > DateTime.now().month){
    Navigator.pushNamed(context, SelectTimeSlot.id);

                  }
    },
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Container(
                    //  height: 30,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left:5,right:5),
                      decoration: BoxDecoration(
                          color: AppTheme.white,border:
                  Border.symmetric(
                  vertical: BorderSide(
                  color: AppTheme.black
                  ),horizontal: BorderSide(
                      color: AppTheme.black
                  ),
                  ),),
                      child: Text(
                        '${date.day}',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:
                          //  AppTheme.red
                          AppTheme.lightBlack.withOpacity(0.6)
                      ))),
                ),
              );
            }),



    ),
        ),
      )
      ],),
    );
  }
}
