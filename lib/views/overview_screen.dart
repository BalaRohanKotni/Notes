// ignore: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/components/overviewScreenNavBar.dart';
import 'package:notes/controllers/dataServices.dart';
import 'package:notes/models/note.dart';
import '../components/circleButton.dart';
import '../components/customCard.dart';
import '../constants.dart';

import '../models/todoList.dart';

class OverviewScreen extends StatefulWidget {
// ignore: prefer_typing_uninitialized_variables
  var user;
  OverviewScreen({
    Key? key,
    @required this.user,
  }) : super(key: key);

  @override
  State<OverviewScreen> createState() => OverviewScreenState();
}

class OverviewScreenState extends State<OverviewScreen> {
  late Stream<QuerySnapshot> _noteStream;
  late Stream<QuerySnapshot> _listStream;
  late Stream<QuerySnapshot> _stream;
  // TODO: implement dark mode
  bool darkMode = false;

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _noteStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .collection('note')
        .snapshots();

    _listStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .collection('todo-list')
        .snapshots();

    _stream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .collection('notes_and_lists')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // TODO: Implement this function to add note or list

            Note note = Note(
              title: "Hello World",
              body:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ullamcorper, augue eget mattis venenatis, dolor augue sodales lectus, at sodales enim elit quis mauris. Quisque. ",
              creation: DateTime.now().millisecondsSinceEpoch,
              updation: DateTime.now().millisecondsSinceEpoch,
            );

            TodoList list = TodoList(
              creation: DateTime.now().millisecondsSinceEpoch,
              updation: DateTime.now().millisecondsSinceEpoch,
              title: "TODO",
              list: [
                {
                  "0": [true, "uhmm"]
                },
                {
                  "0": [false, "Hello"]
                },
                {
                  "0": [true, "uhmm"]
                },
                {
                  "0": [false, "gasdf"]
                },
                {
                  "0": [true, "uhmm"]
                },
                {
                  "0": [true, "uhmm"]
                },
              ],
            );

            addDoc(widget.user.uid, note.toMap());
            addDoc(widget.user.uid, list.toMap());
          },
          child: Icon(Icons.add),
          backgroundColor: kCeruleanBlue,
        ),
        key: _key,
        drawer: OverViewScreenNavBar(),
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Container(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: SizedBox(
                          width: 45,
                          height: 75,
                          child: Icon(
                            Icons.menu,
                            color: kCeruleanBlue,
                            size: 30,
                          ),
                        ),
                        onPressed: () {
                          _key.currentState?.openDrawer();
                        },
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Notes",
                        style: TextStyle(
                          color: kCaledonBLue,
                          fontSize: 40.0,
                          fontFamily: 'LobsterTwo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleButton(
                        iconTD: Icons.search,
                        colorTD: Colors.white,
                        bgTD: kCeruleanBlue,
                        onTap: () async {
                          // TODO: Search PAGE
                        },
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      CircleButton(
                        iconTD: Icons.settings,
                        colorTD: Colors.white,
                        bgTD: kCeruleanBlue,
                        onTap: () async {
                          // TODO: SETTINGS PAGE
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: darkMode ? kDarkModeBG : Colors.white,
            child: StreamBuilder(
              stream: _stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return CustomCard(
                        type: data['type'],
                        darkMode: false,
                        onTap: () {},
                        creation: DateTime.fromMillisecondsSinceEpoch(
                            data['updation']),
                        updation: DateTime.fromMillisecondsSinceEpoch(
                            data['updation']),
                        title: data['title'],
                        body: data['body']);
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
