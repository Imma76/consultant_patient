
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/main.dart';
import 'package:consult_patient/src/collections/collection.dart';
import 'package:consult_patient/src/controllers/user_controller.dart';
import 'package:consult_patient/src/models/appointment_model.dart';
import 'package:consult_patient/src/models/consultant_model.dart';
import 'package:consult_patient/src/models/patient_model.dart';
import 'package:consult_patient/src/services/appointment_service.dart';
import 'package:consult_patient/src/views/booking/booking_confirmation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/patient_service.dart';
import '../themes/app_theme.dart';

class AppointmentController extends ChangeNotifier{
  bool load = false;

  DateTime? selectedDate;
  String? appointmentStartTime = '';
  String? appointmentEndTime ='';
  String? startTime1='8:00';
  String? startTime2='10:00';
  String? startTime3='2:00';
  String? startTime4='4:34';
  String? startTime5='6:25';
  String? endTime1 = '9:30';
  String? endTime2 = '11:00';
  String? endTime3 = '3:45';
  String? endTime4 = '6:25';
  String? endTime5 = '7:30';
  String? selectedEndTime;
  String? selectedStartTime;
  String? appointmentTime;
  DateTime? appointmentDateTimeStartTime;
  DateTime? appointmentDateTimeEndTime;
  ConsultantModel? consultantModel;

  List<String> timeSlots = [];

  List<AppointmentModel> appointmentHistory = [];



  generateTimeSlots() {
    List<TimeOfDay> timeSlots = [];
    TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 19, minute: 30);

    while (startTime != endTime) {
      timeSlots.add(startTime);
      startTime = TimeOfDay.fromDateTime(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          startTime.hour,
          startTime.minute,
        ).add(const Duration(minutes: 30)),
      );
    }
    timeSlots.add(endTime);


  }

  List<String> generateTimeSlots2() {
   timeSlots.clear();
    TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 19, minute: 30);

    while (startTime != endTime) {
      String slot = '${formatTime(startTime)} - ${formatTime(getNextTime(startTime))}';
      timeSlots.add(slot);
      startTime = getNextTime(startTime);
    }
    String slot = '${formatTime(endTime)} - ${formatTime(getNextTime(endTime))}';
    timeSlots.add(slot);
    print(timeSlots.length);
    return timeSlots;
  }

  TimeOfDay getNextTime(TimeOfDay currentTime) {
    int minutes = currentTime.hour * 60 + currentTime.minute;
    minutes += 30;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  String formatTime(TimeOfDay time) {
    String hour = time.hourOfPeriod.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  selectedConsultant(ConsultantModel? newConsultantModel){

    consultantModel=newConsultantModel;
    notifyListeners();
  }

  changeSelectedDate(DateTime? sDate){
    selectedDate= sDate;
    notifyListeners();
  }

  Stream<QuerySnapshot> getAppointmentStream(){
    return Collections.appointment.where('patient.userId',isEqualTo:userController.patient!.userId).snapshots();
  }

  selectedTimeSlot({String? startTime, String? endTime})async{

    selectedEndTime= endTime;
    selectedStartTime=startTime;
    appointmentTime='$selectedStartTime - $selectedEndTime';
    print(appointmentTime);
    notifyListeners();
    await saveAppointment();

  }
  selectedTimeSlot2(String time)async{


    splitTimeToSeparateTime(time);
    await saveAppointment2();

  }

  List<String> generateTimeSlots3() {
    List<String> timeSlots2 = [];
    TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 19, minute: 30);

    while (startTime != endTime) {
      String slot = formatTime(startTime);
      timeSlots2.add(slot);
      startTime = getNextTime2(startTime, 30);
    }
    String slot = formatTime2(endTime);
    timeSlots2.add(slot);
    print(timeSlots2);

    return timeSlots2;
  }

  TimeOfDay getNextTime2(TimeOfDay currentTime, int minutesToAdd) {
    int minutes = currentTime.hour * 60 + currentTime.minute;
    minutes += minutesToAdd;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  String formatTime2(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  splitTimeToSeparateTime(String timeString){
    // Split the string using the '-' delimiter
    List<String> timeRange = timeString.split('-');

// Extract the start and end time strings
    String startTime = timeRange[0];
    String endTime = timeRange[1];

// Trim any leading or trailing whitespace
    startTime = startTime.trim();
    endTime = endTime.trim();
    appointmentStartTime = startTime;
    appointmentEndTime = endTime;
    putEndTimeInDateTimeObject(startTime, endTime);
    print('Start Time: $startTime');
    print('End Time: $endTime');
  }

  putEndTimeInDateTimeObject(String startTimeValue, String endTimeValue){
    String startTimeString = startTimeValue;
    String endTimeString = endTimeValue;

// Create a DateTime object for today
    DateTime now = DateTime(selectedDate!.year,selectedDate!.month,selectedDate!.day);

// Combine the date portion from 'now' with the time portion from 'startTimeString'
    String combinedDateStartTimeString = DateFormat('yyyy-MM-dd').format(now) + ' ' + startTimeString;
    String combinedDateEndTimeString = DateFormat('yyyy-MM-dd').format(now) + ' ' + endTimeString;

// Parse the combined date and time string into a DateTime object
     appointmentDateTimeStartTime = DateFormat('yyyy-MM-dd hh:mm a').parse(combinedDateStartTimeString);
    appointmentDateTimeEndTime = DateFormat('yyyy-MM-dd hh:mm a').parse(combinedDateEndTimeString);

    print('Start Time: $appointmentDateTimeStartTime');
  }


  saveAppointment()async{
    print(userController.patient!.lastName);

   // PatientModel? patientModel = PatientModel(firstName: userController.patient!.firstName,lastName: userController.patient!.lastName);
    //ConsultantModel? _consultantModel= ConsultantModel(firstName: consultantModel!.firstName,lastName: consultantModel!.firstName);
    if(int.parse(selectedEndTime!.split(":")[0].toString())<8 &&int.parse(selectedStartTime!.split(":")[0].toString())<8){
      selectedEndTime = '${(12+int.parse(selectedEndTime!.split(":")[0].toString()))}:${selectedEndTime!.split(":")[1]}';
      selectedStartTime='${(12+int.parse(selectedStartTime!.split(":")[0].toString()))}:${selectedStartTime!.split(":")[1]}';
    }
    AppointmentModel appointmentModel = AppointmentModel(
      appointmentDate: '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
      appointmentEnd: DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        int.parse(selectedEndTime!.split(":")[0].toString()),
        int.parse(selectedEndTime!.split(":")[1].toString()),

      ),
      appointmentStart: DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        int.parse(selectedStartTime!.split(":")[0].toString()),
        int.parse(selectedStartTime!.split(":")[1].toString()),

      ),
      createdAt: DateTime.now(),
      appointmentStartTime: selectedStartTime,
      patient:userController.patient,
      appointmentEndTime: selectedEndTime,
      consultant:consultantModel);
    load = true;
    notifyListeners();

   bool createAppointment =  await AppointmentService.createAppointment(appointmentModel);
   load = false;
   notifyListeners();
   if(createAppointment){
     await PatientService.sendEmail('You have booked an appointment with Dr. ${appointmentModel.consultant!.firstName} ${appointmentModel.consultant!.lastName} for  ${ DateFormat('MMM d, H:mm a y').format(appointmentModel.appointmentStart!)} ');
     await PatientService.sendEmail('${appointmentModel.patient!.firstName} ${appointmentModel.patient!.lastName} has booked an appointment with you for ${ DateFormat('MMM d, H:mm a y').format(appointmentModel.appointmentStart!)} ',email: appointmentModel.consultant!.email);

     Navigator.pushNamed(navigatorKey!.currentContext!,ConfirmationScreen.id);
   }
  }

  saveAppointment2()async{
    print(userController.patient!.lastName);

    for(var appHistory in appointmentHistory){

      bool isSameDayMonthYear(DateTime date1, DateTime date2) {
        bool isSameDay = date1.day == date2.day;
        bool isSameMonth = date1.month == date2.month;
        bool isSameYear = date1.year == date2.year;

        return isSameDay && isSameMonth && isSameYear;
      }
      if(appHistory.appointmentStart == appointmentDateTimeStartTime &&isSameDayMonthYear(appHistory.appointmentStart!, appointmentDateTimeStartTime!)){
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
                    child: Text('Consultant has been booked at this time, choose another time',textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          color: AppTheme.lightBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),),
                  ),
                  Gap(24.h),

                  ElevatedButton(onPressed: () async {

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
        return;
      }
    }

    if(appointmentDateTimeStartTime!.isBefore(DateTime.now())){
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
                  child: Text('Selected time has passed, choose another slot',textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                        color: AppTheme.lightBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),),
                ),
                Gap(24.h),

                ElevatedButton(onPressed: () async {

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

      return;
    }

    // PatientModel? patientModel = PatientModel(firstName: userController.patient!.firstName,lastName: userController.patient!.lastName);
    //ConsultantModel? _consultantModel= ConsultantModel(firstName: consultantModel!.firstName,lastName: consultantModel!.firstName);
    // if(int.parse(selectedEndTime!.split(":")[0].toString())<8 &&int.parse(selectedStartTime!.split(":")[0].toString())<8){
    //   selectedEndTime = '${(12+int.parse(selectedEndTime!.split(":")[0].toString()))}:${selectedEndTime!.split(":")[1]}';
    //   selectedStartTime='${(12+int.parse(selectedStartTime!.split(":")[0].toString()))}:${selectedStartTime!.split(":")[1]}';
    // }
    AppointmentModel appointmentModel = AppointmentModel(
        appointmentDate: '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
        appointmentEnd:appointmentDateTimeEndTime,
        appointmentStart: appointmentDateTimeStartTime,
        createdAt: DateTime.now(),
        appointmentStartTime:appointmentStartTime,
        patient:userController.patient,
        appointmentEndTime: appointmentEndTime,
        sessionEnded :false,
        consultant:consultantModel);
    load = true;
    notifyListeners();

    bool createAppointment =  await AppointmentService.createAppointment(appointmentModel);

    if(createAppointment){
      await PatientService.sendEmail('You have booked an appointment with Dr. ${appointmentModel.consultant!.firstName} ${appointmentModel.consultant!.lastName} for  ${ DateFormat('MMM d, H:mm a y').format(appointmentModel.appointmentStart!)} ');
      await PatientService.sendEmail('${appointmentModel.patient!.firstName} ${appointmentModel.patient!.lastName} has booked an appointment with you for ${ DateFormat('MMM d, H:mm a y').format(appointmentModel.appointmentStart!)} ',email: appointmentModel.consultant!.email);
      load = false;
      notifyListeners();
      Navigator.pushNamed(navigatorKey!.currentContext!,ConfirmationScreen.id);
    }
  }


  // List<String> appointmentTime =[  '8:00', '9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00','20:00','21:00'];

  init(){

  }

  getAppointmentHistory()async{

   final history =  await AppointmentService.getAppointmentHistory();
   if(history != null){
     load = false;
     appointmentHistory = history;
     notifyListeners();
   }else{
     load = false;
     notifyListeners();
   }
  }


}