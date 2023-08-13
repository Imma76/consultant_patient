import 'package:bot_toast/bot_toast.dart';
import 'package:consult_patient/firebase_options.dart';
import 'package:consult_patient/src/all_providers/all_providers.dart';
import 'package:consult_patient/src/controllers/central_state.dart';
import 'package:consult_patient/src/controllers/user_controller.dart';
import 'package:consult_patient/src/routes/routes.dart';
import 'package:consult_patient/src/themes/app_theme.dart';
import 'package:consult_patient/src/utils/widgets/loader.dart';
import 'package:consult_patient/src/views/authentication/login.dart';
import 'package:consult_patient/src/views/authentication/sign_up.dart';
import 'package:consult_patient/src/views/booking/booking_confirmation.dart';
import 'package:consult_patient/src/views/booking/date_slot.dart';
import 'package:consult_patient/src/views/booking/time_slots/time_slots.dart';
import 'package:consult_patient/src/views/home/base.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:consult_patient/src/views/profile/consultants_profile.dart';
import 'package:consult_patient/src/views/welcome.dart';
//import 'package:device_preview/device_preview.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
      //DevicePreview(
      //enabled: !kReleaseMode,

     //builder :(context)=>
     const MyApp()
     //)
          );
}

final botToastBuilder = BotToastInit();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return ProviderScope(
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Consultant patient',
              routes:routes,
             debugShowCheckedModeBanner: false,
              navigatorObservers: [BotToastNavigatorObserver()],
              builder: BotToastInit(),
             //builder: DevicePreview.appBuilder,
             home: LoadApp(),
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              //home: const MyHomePage(title: 'Flutter Demo Home Page'),
            ),
          );
        }

    );
  }
}


class LoadApp extends ConsumerStatefulWidget {
  const LoadApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoadAppState();
}

class _LoadAppState extends ConsumerState<LoadApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(centralProvider).initializeApp();

  }
  @override
  Widget build(BuildContext context) {
    final centralController = ref.watch(centralProvider);
    if(centralController.isAppLoading) {
      return Scaffold(
          backgroundColor: AppTheme.lightGreen,
          body:Indicator2());
    }
      if(centralController.isUserPresent){
        if(userController.patient!= null){
          if( userController.patient!.verificationStatus == 'banned' || userController.patient!.verificationStatus=='restricted'){

            return WelcomeScreen();
          }

        }

          return Base();
        }
          //c

        return WelcomeScreen();

  }
}



//
// class LoadApp extends ConsumerWidget {
//   const LoadApp({
//     Key? key,
//   }) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//     return Consumer(
//       builder: (context, widget,ref){
//         if(centralState.isUserPresent){
//          return Homepage();
//        }
//         return WelcomeScreen();
//       },
//     );
//   }
// }