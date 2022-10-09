import 'package:flutter/material.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/DobPage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tumble/toast.dart';
class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);
  static const id="photopage";

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {

  File? imageFile=null;
  File? imageFile2=null;
  pickImage(int id)async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if(id==1){
      imageFile=File(image!.path);
    }else if(id==2){
      imageFile2=File(image!.path);
    }

    setState(() {
      imageFile;
      imageFile2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container()),

      body: Padding(
        padding: EdgeInsets.fromLTRB(35.0,0, 35.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Add your first 2\n'
                    'photos',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 35,fontWeight: FontWeight.bold)
                )),
            Text(
                '2 photos are better than 1, it\'s\n'
                    ' Bumble science. You can change\n'
                    'these later.',
                style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 20,fontWeight: FontWeight.w500)
                )
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: imageFile==null?
                  GestureDetector(
                    onTap: (){pickImage(1);},
                    child:   Container(height: 120,width: 120,child: Center(child: Icon(Icons.add,color: Colors.black,),),decoration: BoxDecoration(color: Colors.white,
                        borderRadius:BorderRadius.circular(10) ),),
                  ):
                  GestureDetector(
                    onTap: (){pickImage(1);},
                    child: Container(decoration: BoxDecoration(color: Colors.white,
                        borderRadius:BorderRadius.circular(10) ),
                        height: 120,
                        width: 120,

                        child: Image.file(imageFile!,fit: BoxFit.cover,),
                         ),
                  ),),

                SizedBox(width: 10,),
                Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: imageFile2==null?
                    GestureDetector(
                      onTap: (){pickImage(2);},
                      child:   Container(height: 120,width: 120,child: Center(child: Icon(Icons.add,color: Colors.black,),),decoration: BoxDecoration(color: Colors.white,
                          borderRadius:BorderRadius.circular(10) ),),
                    ):
                    GestureDetector(
                      onTap: (){pickImage(2);},
                      child: Container(decoration: BoxDecoration(color: Colors.white,
                          borderRadius:BorderRadius.circular(10) ),
                        height: 120,
                        width: 120,

                        child: Image.file(imageFile2!,fit: BoxFit.cover,),
                      ),
                    ),
                ),
              ],
            ),
            Spacer(),
            Row(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  child: GestureDetector(
                    onTap: ()async{
                      if(imageFile==null || imageFile2==null){
                        FlutterToastService().showToast("Please upload your images");
                      }else{
                        await AuthService().uploadImageToFirebase(context, imageFile!, 1);
                        await AuthService().uploadImageToFirebase(context, imageFile2!, 2);
                        Navigator.pushNamed(context, DobPage.id);
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
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
}