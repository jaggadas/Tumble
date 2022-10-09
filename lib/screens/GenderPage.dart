import 'package:flutter/material.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:tumble/screens/BioPage.dart';
class GenderPage extends StatefulWidget {
  GenderPage({Key? key}) : super(key: key);
  bool value=false;
  static const id='genderpage';
  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String _singleValue = "Female";
  String _verticalGroupValue = "Pending";

  List<String> _status = ["Pending", "Released", "Blocked"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container()),

      body:Padding(
        padding: EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'What\'s your gender?',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 35,fontWeight: FontWeight.bold)
                )
            ),
            Text(
                'Pick which best describes you.\nThen add more about your gender if you\'d like.',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
            ),
            Text(
              'Learn more about what this means',
              style: GoogleFonts.sourceSansPro(textStyle:
              TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500,decoration: TextDecoration.underline,)),
            ),
            SizedBox(height: 10,),
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

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(flex: 10,
                  child: ListTile(leading: Icon(Icons.remove_red_eye,color: Colors.black,),title: Text("You can always update this later. We got you.",style:GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)) ,),),
                ),
                Flexible(flex: 1,
                  child:
                  GestureDetector(
                    onTap: ()async{
                        await AuthService().uploadGender(_singleValue);
                        Navigator.pushNamed(context, BioPage.id);
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