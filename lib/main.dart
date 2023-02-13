import 'package:consult_patient/firebase_options.dart';
import 'package:consult_patient/src/routes/routes.dart';
import 'package:consult_patient/src/views/authentication/login.dart';
import 'package:consult_patient/src/views/authentication/sign_up.dart';
import 'package:consult_patient/src/views/home/home_page.dart';
import 'package:consult_patient/src/views/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),

        builder: (context, child) {
          return MaterialApp(
            title: 'Consultant patient',
            routes:routes,
            initialRoute: Homepage.id,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }

    );
  }
}

