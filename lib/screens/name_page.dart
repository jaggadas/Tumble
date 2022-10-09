import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/photo_page.dart';
import 'package:tumble/toast.dart';
class NamePage extends StatelessWidget {
  NamePage({Key? key}) : super(key: key);
  static const id="namepage";
  String name="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container()),

      body: Padding(
        padding: EdgeInsets.fromLTRB(35.0,0, 35.0, 0),
        child: Column(

          children: [
            Text(
                'What\'s your first name?',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 35,fontWeight: FontWeight.bold))),
            Text(
                'You won\'t be able to change this later.',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: TextField(

                cursorColor: kBumbleYellow,
                style: TextStyle(color: Colors.black),
                decoration: kTextFieldInputDecoration.copyWith(hintText:'Add your first name' ),
                onChanged: (value) {
                      name=value;
                },
              ),
            ),
            Spacer(),
            Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(flex: 10,
                  child: ListTile(leading: Icon(Icons.remove_red_eye,color: Colors.black,),title: Text("This will be shown on your profile",style:GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)) ,),),
                ),
                Flexible(flex: 1,
                  child:
                  GestureDetector(
                    onTap: ()async{
                      if(name.length>1){
                        await AuthService().uploadName(name);
                      Navigator.pushNamed(context, PhotoPage.id);}
                      else{
                          FlutterToastService().showToast("Please enter correct name");
                      }
                      }

                    ,
                    child: Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                        child:Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: 20,)
                      // TextButton(onPressed: (){
                      //   Navigator.pushNamed(context, OtpPage.id);
                      //
                      // }, child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: 20,),
                      // ),
                    ),
                  ),
                )
              ],
            )



          ],
        ),
      ),
    );
  }
}