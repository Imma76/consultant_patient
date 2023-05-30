
import 'package:consult_patient/src/views/appointments/appointment_history.dart';
import 'package:consult_patient/src/views/medical_history/medical_history.dart';
import 'package:consult_patient/src/views/profile/patient_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../all_providers/all_providers.dart';
import '../../themes/app_theme.dart';

import 'home_page.dart';


class Base extends ConsumerStatefulWidget {
  static const id ='base';
  const Base({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BaseState();
}

class _BaseState extends ConsumerState<Base> {

  int currentIndex =0;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final centralController = ref.read(centralProvider);
  // }
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList=[
      Homepage(),
      AppointmentHistory(),
      MedicalHistory(),
     PatientProfile()


    ];
    return Scaffold(
      body:widgetList
      [currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppTheme.lightBlack,

        selectedItemColor: AppTheme.lightBlack,
        unselectedLabelStyle: GoogleFonts.dmSans(fontWeight:
        FontWeight.w500,fontSize: 12.sp,color: AppTheme.lightBlack),
        selectedLabelStyle: GoogleFonts.dmSans(fontWeight:
        FontWeight.w500,fontSize: 12.sp,color: AppTheme.lightBlack)
        ,
        unselectedFontSize: 12,
        backgroundColor: AppTheme.lightGreen,
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/home.svg',color:currentIndex ==0?AppTheme.primary: AppTheme.black,height: 24),label: 'Home \n '),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/appointment_history.svg',height: 20,color:currentIndex ==1?AppTheme.primary: AppTheme.black,),label: 'Appointment \n      history'),
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/medical_history.svg",height: 20,color:currentIndex ==2?AppTheme.primary: AppTheme.black,),label: 'Medical\n history'),
         currentIndex==3? BottomNavigationBarItem(icon: SvgPicture.asset("assets/profile2.svg",height: 20,),label: 'Profile \n', ):
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/profile.svg",height: 20,),label: 'Profile \n', ),

          // BottomNavigationBarItem(icon: Icon(Icons.calen))
        ],

        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
      ),
    );
  }
}



//
// class Base extends StatefulWidget {
//   static const id ='base';
//   const Base({Key? key}) : super(key: key);
//
//   @override
//   State<Base> createState() => _BaseState();
// }
//
// class _BaseState extends State<Base> {
//   List<Widget> widgetList=[
//     Homepage(),
//     Appointments(),
//     AppointmentReschedule(),
//     ConsultantProfile(),
//
//   ];
//   int currentIndex =0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:widgetList
//         [currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         unselectedItemColor: AppTheme.lightBlack,
//
//         selectedItemColor: AppTheme.lightBlack,
//         unselectedLabelStyle: GoogleFonts.dmSans(fontWeight:
//         FontWeight.w500,fontSize: 12.sp,color: AppTheme.lightBlack),
//         selectedLabelStyle: GoogleFonts.dmSans(fontWeight:
//         FontWeight.w500,fontSize: 12.sp,color: AppTheme.lightBlack)
//         ,
//         unselectedFontSize: 12,
//         backgroundColor: AppTheme.lightGreen,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: AppTheme.black,),label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded,color: AppTheme.black,),label: 'Appointments'),
//           BottomNavigationBarItem(icon: Image.asset("assets/calendar.png",height: 24,),label: 'Appointment \n Re-schedule '),
//           BottomNavigationBarItem(icon: Image.asset("assets/profile.png",height: 24,),label: 'Profile'),
//
//           // BottomNavigationBarItem(icon: Icon(Icons.calen))
//         ],
//
//         onTap: (index){
//           setState(() {
//             currentIndex=index;
//           });
//         },
//       ),
//     );
//   }
// }
