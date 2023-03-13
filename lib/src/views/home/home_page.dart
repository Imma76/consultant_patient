import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consult_patient/src/all_providers/all_providers.dart';
import 'package:consult_patient/src/models/consultant_model.dart';
import 'package:consult_patient/src/views/profile/consultants_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../controllers/central_state.dart';
import '../../controllers/user_controller.dart';
import '../../themes/app_theme.dart';
import '../../utils/widgets/loader.dart';


class Homepage extends ConsumerStatefulWidget {
  static const id='home_page';

  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    final centralController = ref.read(centralProvider);
    final consultantController = ref.read(consultantProvider);
  }
  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authProvider);
    final userController = ref.watch(userProvider);
    final centralController = ref.watch(centralProvider);
    final consultantController = ref.watch(consultantProvider);

    // ref.read(appointmentProvider);


    return SafeArea(
      child: Scaffold(
        backgroundColor:
        AppTheme.lightGreen,
        body://centralController.isAppLoading?Indicator():
        Padding(
          padding: const EdgeInsets.only(left:24.0,right:24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(35.h),
              Row(
                children: [
                 Image.asset('assets/app_logo.png',width: 87.w,height:77.h),
                  Spacer(),
              //  Image.asset('assets/notification_bell.png',height:16.h, width:16.w),Gap(5.w), Text('Pending consultation \n with Dr. henry onah',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w500)),

                  // )
                ],
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
              Row(
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
              Gap(16.h),
              Row(
                children: [
                  Text('Consultants Online',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 20.sp,fontWeight: FontWeight.w500)),
                  Gap(3.w),
                  CircleAvatar(radius: 3,backgroundColor: AppTheme.primary,),
                ],
              ),
              Gap(16.h),
              StreamBuilder<QuerySnapshot>(
                stream: consultantController.getConsultants(),
                builder: (context, snapshot) {
                 if(snapshot.connectionState == ConnectionState.waiting){

                   print('waiting');
                   return Indicator();

                 }
                 if(snapshot.hasError ){
                   return Text('Unable to load consultants');
                 }
               //  Consultant consultant = Consultant.fromJson(snapshot.data! as Map);
                  return SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap:true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) {
                        ConsultantModel consultant = ConsultantModel.fromJson(snapshot.data!.docs[index].data() as Map);

                        return Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8),
                          child: GestureDetector(
                              onTap: ()async{
                                // print('logout');
                                // centralState.startLoading();
                                // await FirebaseAuth.instance.signOut();
                                // centralState.stopLoading();
                             //   Navigator.pushNamed(context,ConsultantProfile.id);
                              },
                              child: ConsultantAvatar(consultant: consultant,)),
                        );
                      }
                    ),
                  );
                }
              ),
              Container(
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

                          cursorColor: AppTheme.black2,
                          decoration: InputDecoration
                            (hintText: 'Search for a consultant by name or specialty',
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
                            child: Text(index==1?'Tips for Effective Online Health':'15 tips to make your doctor\'s consultation better',textAlign:TextAlign.center,style:  GoogleFonts.poppins(color: AppTheme.white,fontSize: 24.sp,fontWeight: FontWeight.w500) ,),
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
        ),
      ),
    );
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

        Text('${userController.patient!.firstName}',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 12.sp,fontWeight: FontWeight.w600))
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
              CircleAvatar(radius: 2,backgroundColor: AppTheme.primary,),

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
