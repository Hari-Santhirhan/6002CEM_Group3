import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../model/user_model.dart';
import '../../widget/appbar_widget.dart';
import 'widget/profile_widget.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List user = [];

  @override
  Widget build(BuildContext context) {

    // getUser();
    // return FutureBuilder<List>(
    //     future: Future.wait([
    //       getUser(),
    //     ]),
    //     builder: (BuildContext context, AsyncSnapshot<List> snapshot){
    //       if( snapshot.connectionState == ConnectionState.waiting){
    //         return  Scaffold(
    //             body: Center(
    //                 child: LoadingAnimationWidget.staggeredDotsWave(
    //                     color: Colors.purple, size: 200
    //                 )
    //             )
    //         );
    //       }
    //       else{
    //         user = snapshot.data![0];
            return Scaffold(
              //top bar
              appBar: buildAppBar(context, "Profile Page"),
              backgroundColor: Color.fromARGB(255, 228, 218, 218),
              //list view # maybe edit this to change the look
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  //the image method
                  ProfileWidget(
                    imagePath: "../assets/user_profile.png",
                    onClicked: () async {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  buildInfo(user.first),
                  buildContent(user.first),
                  buildActivity(user.first),
                ],
              ),
            );
          }
  //       });
  // }

  // user info display
  Widget buildInfo(Users user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        user.email,
        style: TextStyle(color: Colors.black),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        "Total Points: 1000 ", //${user.points}
        style: TextStyle(color: Colors.black),
      ),
    ],
  );

  // Container with icons & user info
  Widget buildContent(Users user) => Container(
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 222, 202, 186),
        border: Border.all(width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
    padding: const EdgeInsets.all(30),
    margin: EdgeInsets.all(20),
    child: Row(
      //putting the 3 icons and text next to each other
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          //to put the icon, and 2 text on top of each other
          children: [
            Container(
              //box surrounding the icon
              decoration: BoxDecoration(
                  color: Color.fromARGB(116, 115, 150, 74),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Icon(Icons.local_fire_department_sharp,
                  size: 35, color: Color.fromARGB(255, 228, 218, 218)),
            ),
            Text(
              '500',//${user.calories}
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Calories'),
          ],
        ),
        Column(
          //to put the icon, and 2 text on top of each other
          children: [
            Container(
              //box surrounding the icon
              decoration: BoxDecoration(
                  color: Color.fromARGB(116, 115, 150, 74),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Icon(Icons.timer,
                  size: 35, color: Color.fromARGB(255, 228, 218, 218)),
            ),
            Text(
              '10', //${user.hours}
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Hours'),
          ],
        ),
        Column(
          //to put the icon, and 2 text on top of each other
          children: [
            Container(
              //box surrounding the icon
              decoration: BoxDecoration(
                  color: Color.fromARGB(116, 115, 150, 74),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Icon(Icons.directions_walk,
                  size: 40, color: Color.fromARGB(255, 228, 218, 218)),
            ),
            Text(
              '100', //${user.steps}
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Steps'),
          ],
        ),
      ],
    ),
  );

  Widget buildActivity(Users user) => Container(
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 222, 202, 186),
        border: Border.all(width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
    padding: const EdgeInsets.all(20),
    margin: EdgeInsets.all(20),
    child: Column(
      children: [
        //Displaying the Last Activity Text
        Align(
          alignment: Alignment(-1, -1),
          child: Text("Last Activity",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10,
        ),
        //Aligning the Icon & Latest Exercise
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.circle,
              size: 10,
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              "Total calories burned as of today: 100 cal ", //${user.calories}
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );

  // Future<List> getUser() async {
  //   final curr_user = FirebaseAuth.instance.currentUser!.uid;
  //
  //   QuerySnapshot query = await FirebaseFirestore.instance.collection("User").where("id", isEqualTo: curr_user).get();
  //
  //   final user = query.docs.map((doc)=> Users.fromJson(doc.data() as Map<String, dynamic>)).toList();
  //
  //   print(user);
  //
  //   return user;
  // }
}
