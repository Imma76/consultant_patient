import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_theme.dart';


class SignUpScreen extends ConsumerStatefulWidget {
  static const id = 'sign_up';
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUpScreen> {
  List<Widget> formList=[
    Field1(),
    Field2(),
    Field3()

  ];
  int currentIndex=0;
  PageController pageController= PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left:24.w,right:24.w),
        child: Column(
          children: [
            Gap(35.h),
            Row(

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:20.0),
                  child: Image.asset('assets/app_logo.png',width:87.w, height:77.h),
                ),
                Text('Sign up as a patient',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 24.sp,fontWeight: FontWeight.w600),),
              ],
            ),
            Gap(104.h),
            // SizedBox(
            //  // height:500,
            //   width:200,
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemCount: formList.length,
            //       itemBuilder: (context,index) {
            //       return formList[currentIndex];
            //     }
            //   ),
            // ),
            // Gap(47.h),
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: pageController,
                  itemCount: formList.length,
                  onPageChanged:(int){
                  setState(() {
                    currentIndex=int;
                  });
                  },
                  itemBuilder: (context,index){

                return formList[index];
              }),
            ),
            SizedBox(
              height:20,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: formList.length,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(backgroundColor:currentIndex==index? AppTheme.primary:AppTheme.black,radius: 3),
                  );
                }
              ),
            ),
            Gap(44.h),
            ElevatedButton(onPressed: (){
              pageController
              .nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
            }, child:Text('Next',style: GoogleFonts.poppins(color: AppTheme.white,fontSize: 24.sp,fontWeight: FontWeight.w700),),style: ElevatedButton.styleFrom(primary: AppTheme.primary,minimumSize: Size(382.w,58.h)), ),

          ],
        ),
      ),
    );
  }
}


class Field1 extends StatelessWidget {
  const Field1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text('Surname',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
        Gap(24.h),
        Text('First Name',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
        Gap(24.h),
        Text('Last Name',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),

        Gap(24.h),
        Text('Email address',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(

                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class Field2 extends StatelessWidget {
  const Field2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text('Gender',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
        Gap(24.h),
        Text('Age',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
        Gap(24.h),
        Text('Weight (optional)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),

        Gap(24.h),
        Text('Height (Optional)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(

              decoration: InputDecoration(

                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class Field3 extends StatelessWidget {
  const Field3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text('Allergies (if any)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          60.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
        Gap(24.h),
        Text('Write down existing medical conditions(optional)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          100.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLines: 5,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
              ),
            ),
          ),
        ),
        Gap(24.h),



      ],
    );
  }
}

