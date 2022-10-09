import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tumble/screens/intro_page.dart';
import 'package:tumble/screens/login_page.dart';
import 'dart:io';

import '../screens/name_page.dart';
import '../toast.dart';

class AuthService{
  static const kUsers="users";
  static const kName="name";
  static const kPhone="phone";
  static const kImage1="image1";
  static const kImage2="image2";
  static const kDay="day";
  static const kMonth="month";
  static const kYear="year";
  static const kGender="gender";
  static const kBio="bio";
  static const kPref="pref";
  static const kInterests="interests";
  static const kLatitude="latitude";
  static const kLongitude="longitude";
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  // handleAuth(){
  //   return StreamBuilder(
  //     stream: FirebaseAuth.instance.authStateChanges(),
  //     builder: (BuildContext context,snapshot) {
  //       if(snapshot.hasData){
  //         return Interstitial();
  //       }
  //       else{
  //
  //         return LoginPage();
  //       }
  //     },
  //   );
  // }
  signOut(BuildContext context){
    FirebaseAuth.instance.signOut();
    // handleAuth();
    Navigator.popAndPushNamed(context, IntroPage.id);
  }
  signIn(AuthCredential authCredential,context)async{
    try{
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      Navigator.pushNamed(context, NamePage.id);
      // Navigator.pushNamed(context, Interstitial.id);
    }
    catch(e){
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }
  signInWithOTP(smsCode, verId,BuildContext context) {
    try{
      AuthCredential authCreds = PhoneAuthProvider.credential(
          verificationId: verId, smsCode: smsCode);
      signIn(authCreds,context);}
    catch(e){
      print(e);
    }
  }
  uploadName(String name)async{
    await firestore.collection(kUsers).doc(auth.currentUser?.uid).set({kName:name,kPhone:"${auth.currentUser?.phoneNumber}"});
  }
  getCurrentUser(){
    return auth.currentUser;
  }
  uploadBirthDay(String day,String month,String year)async {
    await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({
      kDay:day,kMonth:month,kYear:year
    });
  }
  uploadGender(String gender)async{
    await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({
     kGender:gender
    });
  }
  uploadBio(String bio)async{
    await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({
      kBio:bio
    });
  }
  uploadPreference(String preference)async{
    await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({
      kPref:preference
    });
  }
  uploadInterests(List interests)async{
    await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({
      kInterests:interests
    });
  }
  uploadLocation(double latitude,double longitude,)async{
    await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({
      kLatitude:latitude,kLongitude:longitude
    });
  }
  Future uploadImageToFirebase(BuildContext context,File imageFile,int number) async {
    String fileName = imageFile.path;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) async{
        if(number==1){
        await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({kImage1: value});
        }
        else if(number==2){
          await firestore.collection(kUsers).doc(auth.currentUser?.uid).update({kImage2: value});
        }

      });
    });

  }
}
