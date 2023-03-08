import 'package:consult_patient/src/all_providers/all_providers.dart';
import 'package:consult_patient/src/controllers/auth_controller.dart';
import 'package:consult_patient/src/utils/widgets/loader.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
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
 // final
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final  authController = ref.read(authProvider);
    final centralController = ref.read(centralProvider);
  }
  @override
  Widget build(BuildContext context) {
    final  authController = ref.watch(authProvider);
    final centralController = ref.watch(centralProvider);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.only(left:24.w,right:24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(35.h),
                Row(

                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom:20.0.h),
                      child: Image.asset('assets/app_logo.png',width:87.w, height:77.h),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:12.0),
                      child: Text('Sign up as a patient',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 24.sp,fontWeight: FontWeight.w600),),
                    ),
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
                  height: 456.h,
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
                  height:20.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: formList.length,
                    itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(backgroundColor:currentIndex==index? AppTheme.primary:AppTheme.white2,radius: 3),
                      );
                    }
                  ),
                ),
                Gap(44.h),
                ElevatedButton(onPressed: ()async{
                  pageController
                  .nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                  if(currentIndex ==2&& authController.checkInputForSignUp()){
                    await authController.signUp(centralController);
                    //Navigator.pushNamed(context, Homepage.id);
                  }
                }, child:  centralController.isAppLoading?Indicator(color: AppTheme.white2,):Text(currentIndex !=2?'Next':'Sign up',style: GoogleFonts.poppins(color: AppTheme.white,fontSize: 24.sp,fontWeight: FontWeight.w700),),style: ElevatedButton.styleFrom(primary: AppTheme.primary2,minimumSize: Size(382.w,58.h),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Field1 extends ConsumerWidget {
  const Field1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final  authController = ref.read(authProvider);
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text('Surname',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.surNameController),
        Gap(24.h),
        Text('First Name',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.firstNameController),
        Gap(24.h),
        Text('Last Name',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.lastNameController),
        Gap(24.h),
        Text('Email address',style: GoogleFonts.poppins(color: AppTheme.lightBlack,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.emailController),
      ],
    );
  }
}

class Field2 extends ConsumerWidget {
  const Field2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final  authController = ref.read(authProvider);

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text('Gender',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.genderController
        ),
        Gap(24.h),
        Text('Age',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.ageController),
        Gap(24.h),
        Text('Weight (optional)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.weightController),

        Gap(24.h),
        Text('Height (Optional)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.heightController),
      ],
    );
  }
}



class Field3 extends ConsumerWidget {
  const Field3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final  authController = ref.read(authProvider);
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text('Allergies (if any)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.allergiesController),
        Gap(24.h),
        Text('Write down existing medical conditions(optional)',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        SizedBox(
          height:
          100.h,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: authController.medicalConditionsController,
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

        Text('Password',style: GoogleFonts.poppins(color: AppTheme.black2,fontSize: 16.sp,fontWeight: FontWeight.w400),),
        Gap(8.h),
        InputField(controller: authController.passwordController),



      ],
    );
  }
}


class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
      60.h,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: TextFormField(
          cursorColor:
          AppTheme.primary2,
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2)),

              focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: AppTheme.white2))
          ),
        ),
      ),
    );
  }
}


