import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/profile_card.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/home_page.dart';



class ProfilePage extends StatefulWidget {

  static const id="profile_page";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const id="profile_page";
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
  var imagePath1= 'assets/girls/image1.jpeg';
  var imagePath2= 'assets/girls/image2.jpeg';
  var name='Sarah';
  var about= 'bio';
  var interests= [];
  var birthday= 'hbd';
  var birthyear= 'hbd';
  var birthmonth= 'hbd';
  var phone= 'no';
  var preference= 'x';
  bool  gotDetails=false;
  getUserDetails()async{
    var userData =
        await firestore.collection(kUsers).doc(auth.currentUser?.uid).get();
    imagePath1=userData.get(kImage1);
    imagePath2=userData.get(kImage2);
    name=userData.get(kName);
    about=userData.get(kBio);
    interests=userData.get(kInterests);
    birthday=userData.get(kDay);
    birthmonth=userData.get(kMonth);
    birthyear=userData.get(kYear);
    phone=userData.get(kPhone);
    preference = userData.get(kPref);
    gotDetails=true;
    setState(() {
      gotDetails;
    });
  }
  @override
  void initState() {

   getUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserDetails();
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container(),centerTitle: true,title: Text("bumble",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(color: Colors.black,fontSize: 30)),),),
      body: gotDetails?
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('$imagePath1'),
                SizedBox(height: 10,),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                  child: Text('$name', style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500,) ), textAlign: TextAlign.left,),
                ),   SizedBox(height: 10,),
            Text('Bio', style: GoogleFonts.sourceSansPro(textStyle:
            TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600,))),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                  child: Text('$about', style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500))),
                ),   SizedBox(height: 10,),
                Text('Interests', style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600,))),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                  child: Text('$interests', style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500))),
                ),   SizedBox(height: 10,),
                Text('Birth Date', style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600,))),
                Row(
                  children: [
                    Flexible(flex: 1,
                      child: Container(width: double.infinity,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                        child: Text('$birthday', style: GoogleFonts.sourceSansPro(textStyle:
                        TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500))),
                      ),
                    ),   SizedBox(width: 10,),
                    Flexible(
                      child: Container(width: double.infinity,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                        child: Text('$birthmonth', style: GoogleFonts.sourceSansPro(textStyle:
                        TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500))),
                      ),
                    ),   SizedBox(width: 10,),
                    Flexible(
                      child: Container(width: double.infinity,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                        child: Text('$birthyear',style: GoogleFonts.sourceSansPro(textStyle:
                        TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500))),
                      ),
                    ),
                  ],
                ),   SizedBox(height: 10,),
                Text('Phone', style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600,))),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                  child: Text('$phone' ,style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500))),
                ),   SizedBox(height: 10,),
                Text('Preferences', style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600,))),
                Container(width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Colors.white,),
                  child: Text('$preference', style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500))),
                ),
              ],
            ),
          ],
        ),
      ):Container(),
      bottomNavigationBar: Container(
        height: 60,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [MyTheme.orange4, MyTheme.orange2],
        //     begin: FractionalOffset(0, 0),
        //     end: FractionalOffset(0, 1),
        //     stops: [0, 1.0],
        //   ),
        //   //color: MyTheme.orange2.withOpacity(0.8),
        //   borderRadius: const BorderRadius.only(
        //     topLeft: Radius.circular(20),
        //     topRight: Radius.circular(20),
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {

                } ,
                icon: const Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
                icon: const Icon(
                  Icons.home,
                  size: 35,
                  color: Colors.black,
                )),


          ],
        ),
      ),
    );
  }
}