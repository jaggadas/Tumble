import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/interest_page.dart';
class date_pref extends StatefulWidget {
  const date_pref({Key? key}) : super(key: key);
 static const id="date_preferences";
  @override
  State<date_pref> createState() => _date_prefState();
}

class _date_prefState extends State<date_pref> {
  bool value= false;
  bool value1=true;
  bool value2=false;
  String _singleValue = "Female";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container()),

      body: Padding(
        padding: EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 10),
        child: Column(
            children: [
              Text(
                  'Who would you like to date?',
                  style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(fontSize: 35,fontWeight: FontWeight.bold))),
              Text(
                  'You can choose any answer and change any time.',
                  style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15) , color: Colors.white,),
                child: RadioButton(
                  description: "Male",
                  value: "Male",

                  groupValue: _singleValue,
                  onChanged: (value) => setState(
                        () => _singleValue = value.toString(),
                  ),
                  activeColor: Colors.black,

                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15) , color: Colors.white,),
                child: RadioButton(
                  description: "Female",
                  value: "Female",
                  groupValue: _singleValue,
                  onChanged: (value) => setState(
                        () => _singleValue = value.toString(),
                  ),
                  activeColor: Colors.black,

                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),

                ),
              ),
              SizedBox(height: 10,),
              Container(   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15) , color: Colors.white,),

                child: RadioButton(
                  description: "Non-binary",
                  value: "Non-binary",
                  groupValue: _singleValue,
                  onChanged: (value) => setState(
                        () => _singleValue = value.toString(),
                  ),
                  activeColor: Colors.black,

                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
              ),
              Spacer(),
              Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Flexible(flex: 1,
                    child:
                    GestureDetector(
                      onTap: ()async{
                        await AuthService().uploadPreference(_singleValue);
                        Navigator.pushNamed(context, InterestPage.id);

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

            ]
        ),

      ),
    );
  }}