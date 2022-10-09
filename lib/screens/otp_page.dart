import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tumble/constants.dart';

import '../Firebase/Firebase.dart';
import 'name_page.dart';


class OtpPage extends StatefulWidget {
  var phonenumber;

  OtpPage({this.phonenumber});
  static const id='otppage';

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late ConfirmationResult confirmationResult;
  String enteredOTP="";
  TextEditingController controller=TextEditingController()..text="XXXXXX";
  bool codeSent=false;
  late String verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;
   Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult,context);

    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {

      Fluttertoast.showToast(
          msg: "${authException.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, int? forceResend) {
      setState(() {
        print("hello");

        this.codeSent = true;

      });

      this.verificationId = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNo",
      timeout: const Duration(seconds: 30),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone(widget.phonenumber);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading: Container(), ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35,vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verify your\n"
                "number",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),)
            ,
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter the code we've sent by text",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text("to +91 ${widget.phonenumber}",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
                      SizedBox(width: 8,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("Change"
                ,style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,decoration: TextDecoration.underline))),
                      ),
                    ],
                  ),
                ],
              ),
            )
            ,
            SizedBox(height: 20,),
            SizedBox(
              width: 250,
              height: 40,
              child: PinInputTextField(


              decoration: BoxLooseDecoration(bgColorBuilder: PinListenColorBuilder(Colors.white,Colors.white), strokeColorBuilder:PinListenColorBuilder(Colors.white,Colors.white)),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly],
                onChanged: (value){
                  enteredOTP=value;
                },
                // showFieldAsBox: true,
                onSubmit: (String pin){
                  //TODO: add on submit
                }, // end onSubmit
              ),
            ),

            Spacer(),
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 10,
                  child: Text("Didn't get a text?",style: TextStyle(fontSize: 15),)
                ),
                Flexible(flex: 1,
                  child:
                  GestureDetector(
                    onTap: ()async{
                        if(enteredOTP.length==6){
                          if (codeSent) {

                            await AuthService()
                                .signInWithOTP(enteredOTP, verificationId,context);


                          }

                        }
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
            )
            ,
            SizedBox(height: 10,)
          ],),
      ),
    );
  }
}
