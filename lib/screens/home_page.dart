import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tumble/Firebase/Firebase.dart';
import 'package:tumble/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumble/screens/GenderPage.dart';
import 'package:tumble/screens/MyProfilePage.dart';
import 'package:tumble/toast.dart';
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

      }


      // this.bgcolour=Colors.orange;
      ,
      child: Container(
        padding: EdgeInsets.all(10),
        child: widget.title,

        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);
  static const id= "homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}
class ListElementData{
  ListElementData({required this.text,required this.cellCount});
  int cellCount;
  String text;
}
class Content {
  final String name;
  final String url1;
  final String url2;
  final String interests;
  final String bio;
  final String age;

  Content({required this.name,required this.age,required this.url1,required this.url2,required this.interests, required this.bio});
}
class Content2 {
  final String name;
  final String url1;
  final String url2;
  final String interests;
  final String bio;
  final String age;

  Content2({required this.name,required this.age,required this.url1,required this.url2,required this.interests, required this.bio});
}

class _HomePageState extends State<HomePage> {
  var firestore=FirebaseFirestore.instance;
  List<SwipeItem> _swipeItems = [];

  late MatchEngine matchEngine;
  bool loaded=false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];

  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];
  Future<void> getData() async {
    // for (int i = 0; i < _names.length; i++) {
    //   _swipeItems.add(SwipeItem(
    //       content: Content2(name: "name", age: "19",
    //           url1:"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Capybara_%28Hydrochoerus_hydrochaeris%29.JPG/1200px-Capybara_%28Hydrochoerus_hydrochaeris%29.JPG",
    //           url2: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Capybara_%28Hydrochoerus_hydrochaeris%29.JPG/1200px-Capybara_%28Hydrochoerus_hydrochaeris%29.JPG"
    //             , interests: "interests", bio: "bio"),
    //       likeAction: () {
    //         _scaffoldKey.currentState?.showSnackBar(SnackBar(
    //           content: Text("Liked ${_names[i]}"),
    //           duration: Duration(milliseconds: 500),
    //         ));
    //       },
    //       nopeAction: () {
    //         _scaffoldKey.currentState?.showSnackBar(SnackBar(
    //           content: Text("Nope ${_names[i]}"),
    //           duration: Duration(milliseconds: 500),
    //         ));
    //       },
    //       superlikeAction: () {
    //         _scaffoldKey.currentState?.showSnackBar(SnackBar(
    //           content: Text("Superliked ${_names[i]}"),
    //           duration: Duration(milliseconds: 500),
    //         ));
    //       },
    //       onSlideUpdate: (SlideRegion? region) async {
    //         print("Region $region");
    //       }));
    // }
    //
    // matchEngine = MatchEngine(swipeItems: _swipeItems);
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await firestore.collection(AuthService.kUsers).get();

    // Get data from docs and convert map to List
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //for a specific field
    final allNameData =
    querySnapshot.docs.map((doc) => doc.get(AuthService.kName)).toList();
    final allUrl1Data =
    querySnapshot.docs.map((doc) => doc.get(AuthService.kImage1)).toList();
    final allUrl2Data =
    querySnapshot.docs.map((doc) => doc.get(AuthService.kImage2)).toList();
    final allInterestsData =
    querySnapshot.docs.map((doc) => doc.get(AuthService.kInterests)).toList();
    final allBioData =
    querySnapshot.docs.map((doc) => doc.get(AuthService.kBio)).toList();

    print(allNameData);

    for (int i = 0; i < allNameData.length; i++) {
      _swipeItems.add(SwipeItem(
          content:
          Content(name: allNameData[i], url1: allUrl1Data[i], url2: allUrl2Data[i], interests: "allInterestsData", bio: allBioData[i], age: '20'),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    matchEngine = MatchEngine(swipeItems: _swipeItems);

    setState(() {
      matchEngine;
      loaded=true;
    });

    print("hello");
  }
  @override
  void initState() {

   getData();
    super.initState();
  }

  generateListOfWidgets(List list){
    List<Widget> listOfWidgets=[];
    for(ListElementData elem in list){
      listOfWidgets.add(
          StaggeredGridTile.count(crossAxisCellCount: elem.cellCount, mainAxisCellCount: 1,
              child:
              Widgett(bgcolour: kBumbleYellow, icon: Icon(Icons.interests), title: Text(elem.text,style: TextStyle(fontSize: 15),),
                  onPress: (){

                  })
          )
      );
    }
    return listOfWidgets;

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,centerTitle: true,leading: IconButton(onPressed: (){AuthService().signOut(context);}, icon: Icon(Icons.arrow_back_ios_rounded,color: kBumbleYellow,)),title: Text('bumble',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(color: kBumbleYellow,fontSize: 30)),),),

      body:  Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
              height: 600,
              child:loaded?
              SwipeCards(
                matchEngine: matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Stack(
                         children: [
                           Image.network( _swipeItems[index].content.url1),

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Text("${   _swipeItems[index].content.name}, 19",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold)),),
                               ],
                             ),
                           ),
                         ],
                       ),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Text(
                           "My Interests",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          color: Colors.white,
                          child: StaggeredGrid.count(
                              crossAxisCount: 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              children:
                              generateListOfWidgets([ListElementData(text: "Yoga", cellCount: 1),ListElementData(text: "Running", cellCount: 2),
                                ListElementData(text: "Gym", cellCount: 1),ListElementData(text: "Football", cellCount: 2,),ListElementData(text: "Cricket", cellCount: 2)
                              ])
                          ),
                        ),

                        Image.network(_swipeItems[index].content.url2),

                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Text(
                            "Bio",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          color: Colors.white,
                          child:Text(_swipeItems[index].content.bio,style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 18)),)
                        ),

                      ],
                    ),
                  );
                },
                onStackFinished: () {

                  _scaffoldKey.currentState?.showSnackBar(SnackBar(
                    content: Text("Stack Finished"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                itemChanged: (SwipeItem item, int index) {
                  print("item: ${item.content.text}, index: $index");
                },

                fillSpace: true,
              ):Container(),
            ),

          ]))
    ,
      bottomNavigationBar: Container(
      height: 60,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [MyTheme.orange4, MyTheme.orange2],
      //     begin: FractionalOffset(0, 0),
      //     end: FractionalOffset(0, 1),
      //     stops: [0, 1.0],
      //   ),
      //   //color: MyTheme.orange2.withOpacity(0.8),
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(20),
      //     topRight: Radius.circular(20),
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfilePage.id);
              } ,
              icon: const Icon(
                Icons.person,
                size: 35,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                size: 35,
                color: Colors.black,
              )),


        ],
      ),
    ),
    );

  }
}