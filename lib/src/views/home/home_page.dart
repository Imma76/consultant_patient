import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/all_providers/all_providers.dart';
import 'package:consult_patient/src/models/appointment_model.dart';
import 'package:consult_patient/src/models/consultant_model.dart';
import 'package:consult_patient/src/views/profile/consultants_profile.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../controllers/central_state.dart';
import '../../controllers/user_controller.dart';
import '../../services/chat_service.dart';
import '../../themes/app_theme.dart';
import '../../utils/widgets/loader.dart';
import '../chats/chat_screen.dart';


class Homepage extends ConsumerStatefulWidget {
  static const id='home_page';

  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> with SingleTickerProviderStateMixin {
  DateTime now = DateTime.now();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    final centralController = ref.read(centralProvider);
    final consultantController = ref.read(consultantProvider);
     ref.read(appointmentProvider).getAppointmentHistory();
     ref.read(consultantProvider).getAllConsultant();
  }
List<String> healthTips = [
  "Exercise regularly and be physically active",
  "Take multivitamin supplements",
  "Go easy on alcohol and stay sober",
  "Eat a well balanced, low-fat diet with lots of fruits, vegetables and grains",
  "Cut down on saturated fat and sugar",
  "Eat less salt: no more than 6g a day for adults",
  "Eat more fish, including a portion of oily fish",
  "Base your meals on higher fibre starchy carbohydrates",
  "Wash or sanitize your hands regularly",
  "Do not eat immediately after a workout, wait for 20-25 minutes before eating after a workout",
  "Have atleast 20-25 grams of raw onion daily",
  "Laugh and smile",
  "Monitor your caffeine intake",
  "Do not eat heavy meals before bed",
  "Spend more time in the sun for more vitamin D",
  "Always use healthier oils when making meals",
  "Eat Whole Foods instead of processed foods",
  "Reject food or drinks made of artificial colors",
  "Try to eat a piece of fruit everyday"
];
String getRandomTip(List<String> tips) {
  Random random = Random();
  int index = random.nextInt(tips.length);
  return tips[index];
}

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authProvider);
    final userController = ref.watch(userProvider);
    final centralController = ref.watch(centralProvider);
    final consultantController = ref.watch(consultantProvider);
    final appointmentController = ref.watch(appointmentProvider);

    // ref.read(appointmentProvider);


    return Scaffold(
      backgroundColor:
      AppTheme.lightGreen,
      body://centralController.isAppLoading?Indicator():
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(35.h),
          Padding(
            padding: const EdgeInsets.only(left:18.0,right:24),
            child: Row(
              children: [
               Image.asset('assets/app_logo.png',width: 87.w,height:77.h),
                Spacer(),

              StreamBuilder<QuerySnapshot>(
                stream: appointmentController.getAppointmentStream(),
                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){

                    print('waiting');
                    return SizedBox();

                  }
                  if(snapshot.hasError ){
                    return Text('Unable to load consultants');
                  }
                  AppointmentModel? appointment;
                  List<AppointmentModel> appointmentList = snapshot.data!.docs.map((e){
                    final snapshotData = e.data()as Map;
                    snapshotData['appointmentId']=e.id;
                   return  AppointmentModel.fromJson(snapshotData);
                  }).toList();
                  for(AppointmentModel appointments in appointmentList){

                    if(
                    appointments
                    .appointmentStart!.day==DateTime.now().day&& DateTime.now().hour>=appointments!.appointmentStart!.hour &&DateTime.now().isBefore(appointments!.appointmentEnd!)&&appointments.sessionEnded == false){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your session with \n Dr. ${appointments.consultant!.firstName} ${appointments.consultant!.lastName} is now open \n click here to begin session',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w500)),
                        Gap(5),
                          GestureDetector(
                              onTap: ()async{
                               // print(userController!.patient!.lastName!);
                                String? chatRoomId = getChatRoomId(appointments!.patient!.firstName!, appointments!.consultant!.firstName!);
                                print(chatRoomId);
                                List<String?> users = [appointments!.patient!.firstName!, appointments!.consultant!.firstName!];
                                Map<String, dynamic> chatRoomMap = {
                                  'users':users,
                                  'chatroomid':chatRoomId,
                                };
                                await FirebaseMessageService.createChatRoom(chatRoomId, chatRoomMap);
                                // _provider.removeAndGoToChatScreen(context, adsOwnerNumber, adsOwner, chatRoomId);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return ChatScreen(appointment: appointments,);
                                }));
                              },
                              child: Container(width: 117.h, height: 26.w,child:Center(child: Text('Begin Session',style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 12.sp,fontWeight: FontWeight.w700))),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppTheme.primary),))
                          ,

                        ],
                      );
                    }
                    if(appointments.appointmentStart!.day == DateTime.now().day&& DateTime.now().isBefore(appointments!.appointmentStart!) ){
                      late CustomTimerController _controller = CustomTimerController(
                          vsync: this,
                          // begin: Duration(hours: now.hour,days: now.day,minutes:  now.minute),
                          // begin: Duration(hours: userController.consultant!.verificationDate!.hour,days: userController.consultant!.verificationDate!.day,minutes:  userController.consultant!.verificationDate!.minute),
                          begin: appointments.appointmentStart!.difference(now),
                          //Duration(hours: now.difference(userController.consultant!.verificationDate!).inHours,days: now.difference(userController.consultant!.verificationDate!).inDays,minutes: now.difference( userController.consultant!.verificationDate!).inMinutes),
                          end: Duration(),
                          initialState: CustomTimerState.counting,
                          interval: CustomTimerInterval.milliseconds
                      );
                      return Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/notification_bell.png',height:16.h, width:16.w),Gap(5.w), Text('Pending consultation \n with Dr. ${appointments!.consultant!.firstName} ${appointments!.consultant!.lastName}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w500)),

                            ],
                          ),


                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom:5.0),
                                child: Image.asset('assets/time.png',height:16.h, width:16.w),
                              ),
                              CustomTimer(
                                  controller: _controller,
                                  builder: (state, time) {


                                    // Build the widget you want!🎉


                                    return   Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Gap(5.w),
                                          time.days.replaceAll('-', '')  == '0'?SizedBox():Column(
                                            children: [
                                              Text('${time.days.replaceAll('-', '')}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600)),
                                              Gap(5.h),
                                             // Text('Days',style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 10.sp,fontWeight: FontWeight.w500)),

                                            ],
                                          ),
                                          Gap(21.w),
                                          time.hours.replaceAll('-', '')  == '0'?SizedBox(): Column(
                                            children: [
                                              Text('${time.hours.replaceAll('-', '')}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600)),
                                              Gap(5.h),
                                           //   Text('Hours',style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 10.sp,fontWeight: FontWeight.w500)),

                                            ],
                                          ),
                                          Gap(21.w),
                                          Column(
                                            children: [
                                              Text('${time.minutes.replaceAll('-', '')}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600)),
                                              Gap(5.h),
                                             // Text('Minutes',style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 10.sp,fontWeight: FontWeight.w500)),

                                            ],
                                          ),
                                          Gap(21.w),
                                          Column(
                                            children: [
                                              Text('${time.seconds.replaceAll('-', '')}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600)),
                                              Gap(5.h),
                                            //  Text('Seconds',style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 10.sp,fontWeight: FontWeight.w500)),

                                            ],
                                          ),

                                          Gap(21.w),



                                        ],
                                      ),
                                    );
                                  }
                              ),
                              ///Text('${DateFormat('HH:mm').format(appointments.appointmentStart!)}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600)),
                            ],
                          )
                        ],
                      );
                    }
                  }

                  return SizedBox();

                }
              ),

                // )
              ],
            ),
          ),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Icon(Icons.access_time,size: 14.sp,color: AppTheme.primary,),Gap(5.w),
          //     Text('1:35:27',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600)),Gap(65.5.w),
          //   ],
          // ),

          Gap(16.h),
          Padding(
            padding: const EdgeInsets.only(left:24.0,right:24),
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
          Padding(
            padding: const EdgeInsets.only(left:24.0,right:24),
            child: Row(
              children: [
                Row(
                  children: [
                    Text('Consultants Online',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 20.sp,fontWeight: FontWeight.w500)),
                    Gap(3.w),
                    CircleAvatar(radius: 3,backgroundColor: AppTheme.primary,),
                  ],
                ),
              ],
            ),
          ),
          Gap(16.h),
          Padding(
            padding: const EdgeInsets.only(left:24.0,right:24),
            child:

             SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: consultantController.consultantListSearchable.length,
                    shrinkWrap:true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) {
                      ConsultantModel consultant = consultantController.consultantListSearchable[index] ;

                      return GestureDetector(
                          onTap: ()async{
                            // print('logout');
                            // centralState.startLoading();
                            // await FirebaseAuth.instance.signOut();
                            // centralState.stopLoading();
                         //   Navigator.pushNamed(context,ConsultantProfile.id);
                          },
                          child: ConsultantAvatar(consultant: consultant,));
                    }
                  ),
                )
            //  }
            //),
          ),
          Padding(
            padding: const EdgeInsets.only(left:24.0,right:24),
            child: Container(
              height: 43.h,
              width:382.w,

              padding: EdgeInsets.only(left:24),
              child:Row(
                children: [
                Icon(Icons.search,color:
              AppTheme.black2,size:

              24.sp,
              ),Gap(8.w),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: TextField(
                        onChanged: consultantController.onSearchForConsultants,
                        cursorColor: AppTheme.black2,
                        decoration: InputDecoration
                          (hintText: 'Search for a consultant by name',
                            hintStyle:
                            GoogleFonts.poppins(color: AppTheme.black2.withOpacity(0.8),fontSize: 12.sp,fontWeight: FontWeight.w400) ,

                        //     prefixIcon: Icon(Icons.search,color:
                        //   AppTheme.black2,size:
                        //
                        //       24.sp,
                        // ),
                        enabledBorder:
                            InputBorder.none,
                          focusedBorder: InputBorder.none


                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(color: AppTheme.white,borderRadius:
                  BorderRadius.circular(20)
              ),
            ),
          ),
          Gap(16.h),


          // Center(
          //   child: Container(width: 295.w,height:259.h,
          //     child: Center(child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text('15 tips to make your doctor\'s consultation better',textAlign:TextAlign.center,style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 24.sp,fontWeight: FontWeight.w500) ,),
          //     )),
          //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors:[
          //     Color.fromRGBO(
          //       224, 239, 48, 0.74),
          //     Color.fromRGBO(72, 181, 83, 0.3922)
          //   ],)),),
          // ),
         // Gap(24.h),
          Expanded(
            child: ListView.builder(

              shrinkWrap: true,
              itemCount:
                2,
                itemBuilder: (context, index) =>  Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(width: 295.w,height:259.h,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(index==1?getRandomTip(healthTips):'Tips for Effective Online Health',textAlign:TextAlign.center,style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 24.sp,fontWeight: FontWeight.w500) ,),
                      )),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:[
                          Color.fromRGBO(
                              224, 239, 48, 0.74),
                          Color.fromRGBO(72, 181, 83, 0.3922)
                        ],)),),
                  ),
                )),
          )

        ],
      ),
    );
  }
getChatRoomId(String receiverName , String senderName){
  if (receiverName.substring(0,1).codeUnitAt(0) > senderName.substring(0,1).codeUnitAt(0)){
    return "$senderName\_$receiverName";

  }else{
    return "$receiverName\_$senderName";
  }
}
}

class Avatar extends ConsumerWidget {
  const Avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final authController = ref.watch(authProvider);

    //final userController = ref.watch(userProvider);
    return Column(
      children: [
        CircleAvatar(
          child: Icon(Icons.person,color:
            AppTheme.primary,),
          backgroundColor: AppTheme.white,
        ),
        Gap(4.h),

        Text('${userController.patient!.firstName} ${userController.patient!.lastName}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600))
      ],
    );
  }
}

class ConsultantAvatar extends StatelessWidget {
  final ConsultantModel? consultant;
  const ConsultantAvatar({
    Key? key,this.consultant
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){

        Navigator.pushNamed(context, ConsultantProfile.id,arguments: consultant);
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(consultant!.photoUrl.toString() ,),
          // child:CachedNetworkImage(),
           //AssetImage('assets/consultant_image.png'),
            backgroundColor: AppTheme.white,
          ),
          Gap(8.h),
          Row(
            children: [
              Text('Dr.${consultant!
              .firstName} ${consultant!.lastName}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.bold)),
              Gap(5),
              CircleAvatar(radius: 2,backgroundColor: AppTheme.primary,),  Gap(5),

            ],
          )
        ],
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  String? time;
  TimeWidget({
    Key? key,this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height:
      32.h,width:32.w,child:Center(child: Text('$time')),decoration:
      BoxDecoration(borderRadius: BorderRadius
      .circular(5),color: AppTheme.white),);
  }
}
