// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/components/overviewScreenNavBar.dart';
import 'package:notes/controllers/appTheme.dart';
import 'package:notes/controllers/dataServices.dart';
import 'package:notes/views/noteScreen.dart';
import '../components/circleButton.dart';
import '../components/customCard.dart';
import '../constants.dart';

class OverviewScreen extends StatefulWidget {
  User user;
  String path;
  OverviewScreen({Key? key, required this.user, this.path = ""})
      : super(key: key);

  @override
  State<OverviewScreen> createState() => OverviewScreenState();
}

class OverviewScreenState extends State<OverviewScreen> {
  late Stream<QuerySnapshot> _stream;
  late AppTheme theme;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    theme = AppTheme(widget.user.uid);

    theme.addListener(() {
      setState(() {});
    });

    _stream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .collection('notes_and_lists')
        .orderBy("updation", descending: true)
        .snapshots();
  }

  bool currentTheme(snapshot) {
    return (snapshot.data) != null
        ? (snapshot.data as bool)
            ? true
            : false
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getThemeFirestore(widget.user.uid),
      builder: (context, parentSnapshot) {
        return MaterialApp(
          themeMode:
              (currentTheme(parentSnapshot)) ? ThemeMode.dark : ThemeMode.light,
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          title: "Notes",
          home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // TODO: Implement this function to add note or list

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteScreen(
                              newNote: true,
                              data: const {},
                              user: widget.user,
                              themeMode: (currentTheme(parentSnapshot))
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                            )));

                // Note note = Note(
                //   title: "Hello World",
                //   body:
                //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ullamcorper, augue eget mattis venenatis, dolor augue sodales lectus, at sodales enim elit quis mauris. Quisque. ",
                //   creation: DateTime.now().millisecondsSinceEpoch,
                //   updation: DateTime.now().millisecondsSinceEpoch,
                // );

                // TodoList list = TodoList(
                //   creation: DateTime.now().millisecondsSinceEpoch,
                //   updation: DateTime.now().millisecondsSinceEpoch,
                //   title: "TODO",
                //   list: [
                //     {
                //       "0": [true, "uhmm"]
                //     },
                //     {
                //       "0": [false, "Hello"]
                //     },
                //     {
                //       "0": [true, "uhmm"]
                //     },
                //     {
                //       "0": [false, "gasdf"]
                //     },
                //     {
                //       "0": [true, "uhmm"]
                //     },
                //     {
                //       "0": [true, "uhmm"]
                //     },
                //   ],
                // );

                // addDoc(widget.user.uid, note.toMap());
                // addDoc(widget.user.uid, list.toMap());
              },
              child: Icon(Icons.add),
              backgroundColor: kCeruleanBlue,
            ),
            key: _key,
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: OverViewScreenNavBar(
                user: widget.user,
                path: widget.path,
              ),
              // ),
            ),
            appBar: AppBar(
              toolbarHeight: 75,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Container(
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
                                MaterialStateProperty.all(Colors.transparent),
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
                        Text(
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
                          iconTD: (currentTheme(parentSnapshot))
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          colorTD: Colors.white,
                          onTap: () {
                            setState(() {
                              theme.toggleTheme();
                            });
                          },
                          bgTD: kCeruleanBlue,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CircleButton(
                          iconTD: Icons.search,
                          colorTD: Colors.white,
                          bgTD: kCeruleanBlue,
                          onTap: () {
                            // TODO: Search PAGE
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: StreamBuilder(
                  stream: _stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> bodySnapshot) {
                    if (bodySnapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (bodySnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    List<Widget> list = [];
                    for (var document in bodySnapshot.data!.docs) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      var card = CustomCard(
                          docId: document.reference.id,
                          user: widget.user,
                          darkMode: false,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteScreen(
                                          newNote: false,
                                          data: {
                                            "id": document.id,
                                            "data": data,
                                          },
                                          user: widget.user,
                                          themeMode:
                                              (currentTheme(parentSnapshot))
                                                  ? ThemeMode.dark
                                                  : ThemeMode.light,
                                        )));
                          },
                          creation: DateTime.fromMillisecondsSinceEpoch(
                              data['updation']),
                          updation: DateTime.fromMillisecondsSinceEpoch(
                              data['updation']),
                          title: data['title'],
                          body: data['body']);

                      if (widget.path == data["path"]) {
                        list.add(card);
                      }
                    }
                    return ListView(
                      children: list,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
