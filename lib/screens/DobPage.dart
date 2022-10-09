import 'package:flutter/material.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/GenderPage.dart';
import 'package:tumble/toast.dart';
class DobPage extends StatelessWidget {
  const DobPage({Key? key}) : super(key: key);
  static const id= "Dobpage";
  @override
  Widget build(BuildContext context) {
    String Day="";
    String Month="";
    String Year="";
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container()),

      body: Padding(
        padding: EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 0),
        child: Column(
          children: [
            Text(
                'When\'s your birthday?',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 35,fontWeight: FontWeight.bold))),
            Row(
              children: [
                Text(
                    'Day',
                    style: GoogleFonts.sourceSansPro(textStyle:
                    TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w800))),
                SizedBox(width: 38, height: 15,),
                Text(
                    'Month',
                    style: GoogleFonts.sourceSansPro(textStyle:
                    TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w800))
                ),
                SizedBox(width: 55,height: 15,),
                Text(
                    'Year',
                    style: GoogleFonts.sourceSansPro(textStyle:
                    TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w800))
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(

                    cursorColor: kBumbleYellow,
                    style: TextStyle(color: Colors.black),
                    decoration: kTextFieldInputDecoration.copyWith(hintText: 'DD'),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      // Move the focus to the next node explicitly.
                      FocusScope.of(context).nextFocus();
                    },
                    onChanged: (value) {
                        Day=value;
                    },
                  ),
                ),
                SizedBox(width: 10, height: 15,),
                Flexible(
                  flex: 2,
                  child: TextField(
                    maxLength: 2,
                    onEditingComplete: () {
                      // Move the focus to the next node explicitly.
                      FocusScope.of(context).nextFocus();
                    },
                    cursorColor: kBumbleYellow,
                    style: TextStyle(color: Colors.black),
                    decoration: kTextFieldInputDecoration.copyWith(hintText: 'MM'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                        Month=value;
                    },
                  ),
                ),
                SizedBox(width: 10, height: 15,),
                Flexible(
                  flex: 3,

                  child: TextField(
                    maxLength: 4,
                    cursorColor: kBumbleYellow,
                    style: TextStyle(color: Colors.black),
                    decoration: kTextFieldInputDecoration.copyWith(hintText: 'YYYY'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      Year=value;
                    },
                  ),
                ),
              ],

            ),
            Spacer(),
            Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(flex: 10,
                  child: ListTile(leading: Icon(Icons.lock,color: Colors.black,),title: Text("We only show your age to potential matches, not your birthday ",style:GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)) ,),),
                ),
                Flexible(flex: 1,
                  child:
                  GestureDetector(
                    onTap: ()async{
                      if (Day.length==2 &&Month.length==2&&Year.length==4){
                        await AuthService().uploadBirthDay(Day, Month, Year);
                          Navigator.pushNamed(context, GenderPage.id);
                      }else{
                        FlutterToastService().showToast("Enter valid date");

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
            ),
          ],

        ),
      ),

    );
  }
}