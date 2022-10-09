import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/constants.dart';
import 'package:tumble/screens/otp_page.dart';
import 'package:tumble/toast.dart';


class LoginPage extends StatelessWidget {

   LoginPage({Key? key}) : super(key: key);
  static const id='loginpage';
  String phoneNumber='';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ), ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35,vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("What's your\n"
              "number?",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),)
            ,
            Text("We protect our community by\n"
                "making sure everyone on Bumble\n"
                "is real.",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)))
            ,
            SizedBox(height: 20,),
            Row(children: [
              Flexible(child:   TextField(
              controller: TextEditingController()..text="+91",
              cursorColor: kBumbleYellow,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: kTextFieldInputDecoration,

              onChanged: (value) {

              },
            ),flex: 1,),
              SizedBox(width: 5,),
              Flexible(child:
              TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              cursorColor: kBumbleYellow,

              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: kTextFieldInputDecoration,
              onChanged: (value) {
                phoneNumber=value;
              },
            ),flex: 5,)],),

            Spacer(),
            Row(

              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(flex: 10,
                  child: ListTile(leading: Icon(Icons.lock,color: Colors.black,),title: Text("We never share this with anyone and\n"
                      "it won't be on your profile",style:GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)) ,),),
                ),
                Flexible(flex: 1,
                  child:
                  GestureDetector(
                    onTap: (){
                      if(phoneNumber.length==10)
                        Navigator.push(context, MaterialPageRoute(builder: (context){return OtpPage(phonenumber: phoneNumber,);}));
                      else{
                        FlutterToastService().showToast("Please check your number");
                        print("invalid phone number");
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
        ],),
      ),
    );
  }
}
