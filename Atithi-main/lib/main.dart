import 'package:doctorapp/Splash/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'Helper/notification_service.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  print(message.data.toString());
  print(message.notification!.title);
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  try{
    String? token = await FirebaseMessaging.instance.getToken();
    print("-----------token:-----${token}");
  } on FirebaseException{
    print('__________FirebaseException_____________');
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    Future.delayed(Duration.zero, () async { //to run async code in initState
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      //enables secure mode for app, disables screenshot, screen recording
    });
  }

  @override
  void dispose() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    // super.dispose();
  }
    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atithi',
      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        //Splash(),
        // '/home': (context) => Dashboard(),
      },
          );
  }
}


