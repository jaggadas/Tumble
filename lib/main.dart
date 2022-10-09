import 'package:flutter/material.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/screens/BioPage.dart';
import 'package:tumble/screens/DobPage.dart';
import 'package:tumble/screens/GenderPage.dart';
import 'package:tumble/screens/MyProfilePage.dart';
import 'package:tumble/screens/home_page.dart';
import 'package:tumble/screens/interest_page.dart';
import 'package:tumble/screens/intro_page.dart';
import 'package:tumble/screens/login_page.dart';
import 'package:tumble/screens/name_page.dart';
import 'package:tumble/screens/otp_page.dart';
import 'package:tumble/screens/photo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tumble/screens/preference_page.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:HomePage(),
        // AuthService().getCurrentUser()==null?IntroPage():HomePage(),
        routes: {
          IntroPage.id: (context) => IntroPage(),
          LoginPage.id:(context)=>LoginPage(),
          OtpPage.id:(context)=>OtpPage(),
          NamePage.id:(context)=>NamePage(),
          PhotoPage.id :(context)=>PhotoPage(),
          DobPage.id:(context)=>DobPage(),
          GenderPage.id:(context)=>GenderPage(),
          BioPage.id:(context)=>BioPage(),
          InterestPage.id:(context)=>InterestPage(),
          date_pref.id:(context)=>date_pref(),
          HomePage.id:(context)=>HomePage(),
          ProfilePage.id:(context)=>ProfilePage()
        } );


  }
}
