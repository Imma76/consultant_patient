import 'package:cached_network_image/cached_network_image.dart';
import 'package:consult_patient/src/all_providers/all_providers.dart';
import 'package:consult_patient/src/models/consultant_model.dart';
import 'package:consult_patient/src/utils/widgets/loader.dart';
import 'package:consult_patient/src/views/booking/time_slots/time_slots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_theme.dart';
import '../../utils/widgets/app_bar.dart';
import '../booking/date_slot.dart';


class ConsultantProfile extends ConsumerStatefulWidget {

  static const id='consultant profile';
  const ConsultantProfile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ConsultantProfileState();
}

class _ConsultantProfileState extends ConsumerState<ConsultantProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(appointmentProvider);
  }

  @override
  Widget build(BuildContext context) {
    final consultant = ModalRoute.of(context)!.settings.arguments as ConsultantModel;
    final appointmentController= ref.watch(appointmentProvider);
    final consultantController = ref.read(consultantProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: PrimaryAppBar(context),
        body: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 21),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Gap(5.h),
                Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                          'assets/app_logo.png', width: 87.w, height: 77.h),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text('Consultants profile', style: GoogleFonts.poppins(
                          color: AppTheme.lightBlack,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,),),
                    ),
                  ],
                ),
                Gap(16.h),
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(consultant!.photoUrl.toString() ,),
                  backgroundColor: AppTheme.white,
                  radius: 58,
                ),
                Gap(16),
                Text('Dr.${consultant!
                    .firstName} ${consultant!.lastName}',style: GoogleFonts
                    .poppins(
                    fontSize: 16.sp,
                    color: AppTheme.black2,
                    fontWeight: FontWeight.w600)),
                Gap(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 274.h,
                      width: 180.w,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Consultant\'s Bio', style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: AppTheme.black2,
                                fontWeight: FontWeight.w500)),
                            Gap(16.h),
                            Row(
                              children: [
                                CircleAvatar(backgroundColor: AppTheme.lightBlack,radius: 2,),Gap(4),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'First Name:',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' ${consultant!
                                              .firstName} ',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2
                                              ,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gap(4),
                            Row(
                              children: [
                                CircleAvatar(backgroundColor: AppTheme.lightBlack,radius: 2,),Gap(4),

                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Last Name:',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' ${consultant!
                                              .lastName} ',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2
                                              ,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gap(4),
                            Row(
                              children: [
                                CircleAvatar(backgroundColor: AppTheme.lightBlack,radius: 2,),Gap(4),

                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'State of origin:',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' ${consultant!
                                              .stateOfOrigin} ',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2
                                              ,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gap(4),
                            Row(
                              children: [
                                CircleAvatar(backgroundColor: AppTheme.lightBlack,radius: 2,),Gap(4),

                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Specialty:',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' ${consultant!
                                              .areaOfSpecialty}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: AppTheme.black2
                                              ,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.lightGreen
                      ),
                    ),
                    Gap(20),
                    Container(
                      height: 274.h,
                      width: 180.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text('Consultant\'s ratings', style: GoogleFonts
                              .poppins(
                              fontSize: 12.sp,
                              color: AppTheme.black2,
                              fontWeight: FontWeight.w500))
                        ],),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.lightGreen
                      ),
                    ),
                  ],
                ),
                Gap(58.h),
                ElevatedButton(onPressed: () {
                   appointmentController.selectedConsultant(consultant);
                  Navigator.pushNamed(context,DateSlot.id);
                //  appointmentController.generateTimeSlots2();
                },
                  child: Text('Book an appointment', style: GoogleFonts.poppins(
                      color: AppTheme.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),),
                  style: ElevatedButton.styleFrom(primary: AppTheme.primary2,
                      minimumSize: Size(382.w, 58.h),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
                Gap(24.h),
                ElevatedButton(onPressed: () {
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      backgroundColor:
                      AppTheme.white
                      ,
                      child: Container(
                        decoration: BoxDecoration(   color:
                        AppTheme.white,borderRadius: BorderRadius.circular(10.r)),
                        height:
                        204.h,
                        width: 382.w,

                        child: Column(
                          children: [
                            Gap(22.h),
                            Text('Rate this consultant',style: GoogleFonts.dmSans(
                                color: AppTheme.lightBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),),
Gap(24.h),
                          RatingBar(
tapOnlyMode: true,
                            glow:
                            true,
                            itemSize: 24,
                            glowColor:
                            AppTheme.primary,
                            initialRating: 2,
                            unratedColor: AppTheme.lightBlack,
                            direction: Axis.horizontal,
                           // allowHalfRating: true,
                            itemCount: 5,
                            ratingWidget:RatingWidget(
                              full: Icon(Icons.star,color: AppTheme.yellow,size: 24.sw,),
                              half:  Icon(Icons.star),

                              empty:  Icon(Icons.star,color:
                              AppTheme.white2,),
                            ),
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            onRatingUpdate: consultantController.updateRating,
                          ),
                            Gap(24.h),
                            ElevatedButton(onPressed: () async{
                              print('rating');
                              await consultantController.rateConsultant(currentRatings: consultant.ratings, consultantId: consultant.consultantId);
                              Navigator.pop(context);
                             },
                              child: Text('Done', style: GoogleFonts.poppins(
                                  color: AppTheme.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),),
                              style: ElevatedButton.styleFrom(primary: AppTheme.primary,
                                  minimumSize: Size(108.w, 58.h),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
                          ],
                        ),
                      ),

                    );
                  });
                },
                  child:consultantController.load?Indicator2(color: AppTheme.white,): Text('Rate Dr. Henry Onah', style: GoogleFonts.poppins(
                      color: AppTheme.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),),
                  style: ElevatedButton.styleFrom(primary: AppTheme.primary2,
                      minimumSize: Size(382.w, 58.h),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
                Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

}