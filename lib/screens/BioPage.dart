import 'package:flutter/material.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/interest_page.dart';
import 'package:tumble/screens/preference_page.dart';
class BioPage extends StatefulWidget {
  static const id="biopage";
  const BioPage({Key? key}) : super(key: key);

  @override
  State<BioPage> createState() => _BioPageState();
}

class _BioPageState extends State<BioPage> {
  String bio="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container()),

      body: Padding(
        padding: EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
                'Tell people a little bit about yourself ',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 35,fontWeight: FontWeight.bold))),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLength: 100,
              maxLines: null,
              minLines: 5,
              cursorColor: kBumbleYellow,
              style: TextStyle(color: Colors.black),
              decoration: kTextFieldInputDecoration.copyWith(hintText: 'Start expressing yourself', contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
              onChanged: (value) {
                  bio=value;
              },
            ),
            Spacer(),
            Row(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Flexible(flex: 1,
                  child:
                  GestureDetector(
                    onTap: ()async{
                      await AuthService().uploadBio(bio);
                          Navigator.pushNamed(context, date_pref.id);

                    },
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
            ),
          ],
        ),
      ),
    );
  }
}