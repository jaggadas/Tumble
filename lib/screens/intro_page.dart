import 'package:flutter/material.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);
  static const id="intropage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,

      body: Stack(
        children: [
          Container(decoration: BoxDecoration(image: DecorationImage(
            image: AssetImage("assets/background_intro.png"),
            fit: BoxFit.cover,
          )

          ), ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38,vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,


              children: [

                Padding(padding: EdgeInsets.only(top: 100),  child: Image.asset("assets/logo.png",height: 50,)),
                Image.asset("assets/text_intro.png",),
                SizedBox(height:450,),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [ SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: TextButton(

                    style: ButtonStyle(

                        alignment: Alignment.center,
                        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all<Color>(kWhite),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(30.0),
                            )
                        )
                    ),
                    onPressed: () async{
                    },
                    child: Text('Use mobile number',style: GoogleFonts.sourceSansPro(textStyle:
                    TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600))),
                  ),
                ),
                  SizedBox(height: 20,),
                  Text("By signing up, you agree to our Terms. See how\n"
                      "we use your data in our Privacy Policy\n"
                      "We never post to Facebook",textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontWeight: FontWeight.w500),),
                    // style: TextStyle(fontWeight: FontWeight.w400),
                  )],),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
