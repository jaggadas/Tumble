import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/GenderPage.dart';
import 'package:tumble/screens/home_page.dart';
import 'package:tumble/toast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
List<String> interests=[];
class InterestPage extends StatefulWidget {
  InterestPage({Key? key}) : super(key: key);
  static const id= "interest_page";

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  late List creativity;

  late List sports;

  late List film;

  stateUpdate(){setState(() {
    interests;
  });}

  generateListOfWidgets(List list){
    List<Widget> listOfWidgets=[];
    for(ListElementData elem in list){
      listOfWidgets.add(
          StaggeredGridTile.count(crossAxisCellCount: elem.cellCount, mainAxisCellCount: 1,
          child:
          Widgett(bgcolour: Colors.white, icon: Icon(Icons.interests), title: Text(elem.text,style: TextStyle(fontSize: 15),),
              onPress: (){
                if(interests.length<5){
                  print("hello");
                  interests.add(elem.text);
                  // setState(() {
                  //   // interests;
                  // });
                  print(interests.length);
                }else{print("whyu");}

              })
          )
      );
    }
    return listOfWidgets;

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: kBumbleYellow,
      appBar: AppBar(elevation: 0,backgroundColor: kBumbleYellow,leading:Container()),

      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(
              top: 0, left: 35, right: 35, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Your interests',
                  style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(fontSize: 35,fontWeight: FontWeight.bold))),
              Text(
                  'Pick up to 5 things you love. It\'ll\n'
                      'help you match with people\n'
                      'who love them too',
                  style: GoogleFonts.sourceSansPro(textStyle:
                  TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Creativity",style: GoogleFonts.sourceSansPro(textStyle:
                TextStyle(fontSize: 25,fontWeight: FontWeight.w600))),
                  SizedBox(height: 5,),
                  StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children:
                      generateListOfWidgets([ListElementData(text: "Art", cellCount: 1),ListElementData(text: "Design", cellCount: 1),
                      ListElementData(text: "Make-up", cellCount: 2),ListElementData(text: "Photography", cellCount: 2,),ListElementData(text: "Writing", cellCount: 2)
                    ])
                  )

                ],
              ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Sports",style: GoogleFonts.sourceSansPro(textStyle:
                    TextStyle(fontSize: 25,fontWeight: FontWeight.w600))),
                      SizedBox(height: 5,),
                      StaggeredGrid.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          children:
                          generateListOfWidgets([ListElementData(text: "Yoga", cellCount: 1),ListElementData(text: "Running", cellCount: 2),
                          ListElementData(text: "Gym", cellCount: 1),ListElementData(text: "Football", cellCount: 2,),ListElementData(text: "Cricket", cellCount: 2)
                        ])
                      )

                    ],
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Film & TV",style: GoogleFonts.sourceSansPro(textStyle:
                    TextStyle(fontSize: 25,fontWeight: FontWeight.w600))),
                      SizedBox(height: 5,),
                      StaggeredGrid.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          children:
                          generateListOfWidgets([ListElementData(text: "Romance", cellCount: 2),ListElementData(text: "Comedy", cellCount: 2),
                          ListElementData(text: "Fantasy", cellCount: 2),ListElementData(text: "Horror", cellCount:1,),ListElementData(text: "Thriller", cellCount: 1)
                        ])
                      )

                    ],
                  ),
                  // InterestsCategoryWidget( title: "Creativity",list:[ListElementData(text: "Art", cellCount: 1),ListElementData(text: "Design", cellCount: 1),
                  //   ListElementData(text: "Make-up", cellCount: 2),ListElementData(text: "Photography", cellCount: 2,),ListElementData(text: "Writing", cellCount: 2)
                  // ]),
                  // InterestsCategoryWidget( title: "Sports",list:[ListElementData(text: "Yoga", cellCount: 1),ListElementData(text: "Running", cellCount: 2),
                  //   ListElementData(text: "Gym", cellCount: 1),ListElementData(text: "Football", cellCount: 2,),ListElementData(text: "Cricket", cellCount: 2)
                  // ]),
                  // InterestsCategoryWidget( title: "Film & TV",list:[ListElementData(text: "Romance", cellCount: 2),ListElementData(text: "Comedy", cellCount: 2),
                  //   ListElementData(text: "Fantasy", cellCount: 2),ListElementData(text: "Horror", cellCount:1,),ListElementData(text: "Thriller", cellCount: 1)
                  // ]),
                  // InterestsCategoryWidget( title: "Sports",list:[
                  //
                  // ]),
                  // InterestsCategoryWidget( title: "Film & TV",list: [],),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.end  ,
                    children: [
                      Flexible(flex: 10,
                        child: ListTile(title: Text("",style:GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)) ,),),
                      ),
                      Flexible(flex: 1,
                        child:
                        GestureDetector(
                          onTap: ()async{
                              await AuthService().uploadInterests(interests);
                              LocationPermission permission = await Geolocator.requestPermission();
                              Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
                              double longitude=position.longitude;
                              double latitude=position.latitude;
                              await AuthService().uploadLocation(latitude, longitude);
                              Navigator.pushNamed(context, HomePage.id);

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

              // Spacer(),

            ],

          ),
        ),
      ),

    );
  }
}
class ListElementData{
  ListElementData({required this.text,required this.cellCount});
  int cellCount;
  String text;
}

class Widgett extends StatefulWidget {
  Widgett({required this.bgcolour, required this.icon, required this.title, required this.onPress});

  Color bgcolour;
  final Icon icon;
  final Text title;
  final Function onPress;

  @override
  State<Widgett> createState() => _WidgettState();
}

class _WidgettState extends State<Widgett> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        if(interests.length<5){
        setState(() {
          widget.bgcolour=Colors.orange;
        });}
        print("bye bitch");
        widget.onPress();
      }


        // this.bgcolour=Colors.orange;
      ,
      child: Container(
        padding: EdgeInsets.all(10),
        child: widget.title,

        decoration: BoxDecoration(
          color: widget.bgcolour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
// class InterestsCategoryWidget extends StatefulWidget {
//    InterestsCategoryWidget({
//   required this.title,
//      required this.list
//   }) ;
//   String title;
//   List<ListElementData> list;
//
//   @override
//   State<InterestsCategoryWidget> createState() => _InterestsCategoryWidgetState();
// }
//
// class _InterestsCategoryWidgetState extends State<InterestsCategoryWidget> {
//   late List<StaggeredGridTile> listOfWidgets=[];
//
//   generateListOfWidgets(){
//     listOfWidgets.clear();
//     for(ListElementData elem in widget.list){
//       listOfWidgets.add(StaggeredGridTile.count(crossAxisCellCount: elem.cellCount, mainAxisCellCount: 1,
//           child: Widgett(bgcolour: Colors.white, icon: Icon(Icons.interests), title: Text(elem.text,style: TextStyle(fontSize: 15),),
//           onPress: (){
//             if(interests.length<5){
//               print("hello");
//               interests.add(elem.text);
//
//               print(interests.length);
//             }
//
//           })));
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     generateListOfWidgets();
//     return
//       Column(crossAxisAlignment: CrossAxisAlignment.start,
//       children: [Text(widget.title,style: GoogleFonts.sourceSansPro(textStyle:
//       TextStyle(fontSize: 25,fontWeight: FontWeight.w600))),
//               SizedBox(height: 5,),
//               StaggeredGrid.count(
//                 crossAxisCount: 4,
//                 mainAxisSpacing: 4,
//                 crossAxisSpacing: 4,
//                 children:
//                   listOfWidgets
//               )
//
//       ],
//     );
//   }
// }