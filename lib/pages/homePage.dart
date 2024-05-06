import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:todo/auth_service/auth.dart';
import 'package:todo/db_service/database.dart';
import 'package:todo/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/pages/SigninPage.dart';
import 'package:todo/pages/loginPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  bool Incomplete = true, Complete = false;
  bool suggest = true;
  int incompleteTaskCount = 0, completeTaskCount = 0;
  TextEditingController todo_controller = TextEditingController();
  Stream? todoStream;

  getonTheLoad() async {
    todoStream = await DatabaseService().getTask(Incomplete ? false : true);
    int completeTaskCountValue = await DatabaseService().getTaskCountOfCompleteAndIncomplete(true);
    int incompleteTaskCountValue = await DatabaseService().getTaskCountOfCompleteAndIncomplete(false);
    setState(() {
      completeTaskCount = completeTaskCountValue;
      incompleteTaskCount = incompleteTaskCountValue;   
    });
  }

  clear() {
    todo_controller.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!;

  void LogOut() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogInPage()));
  }

  Widget getWork() {
    return StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot docSnap = snapshot.data.docs[index];
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11)),
                            tileColor: Colors.amberAccent,
                            leading: Checkbox(
                              value: docSnap["Yes"],
                              onChanged: (newValue) async {
                                await DatabaseService()
                                    .tickMethod(docSnap["id"], newValue!);
                                if (newValue) {
                                  setState(() {
                                    completeTaskCount++;
                                    incompleteTaskCount--;
                                  });
                                } else {
                                  setState(() {
                                    completeTaskCount--;
                                    incompleteTaskCount++;
                                  });
                                }
                              },
                            ),
                            title: Text(docSnap['work']),
                            trailing: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                ),
                                onPressed: () async {
                                  await DatabaseService()
                                      .removeMethod(docSnap["id"]);
                                  if (docSnap["Yes"]) {
                                    setState(() {
                                      completeTaskCount--;
                                    });
                                  } else {
                                    setState(() {
                                      incompleteTaskCount--;
                                    });
                                  }
                                },
                              ),
                            )),
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Incomplete
          ? FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                openBox();
              },
              child: Icon(Icons.add, color: Colors.indigo, size: 35),
            )
          : Column(),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.amber, Color.fromARGB(255, 248, 140, 0)]),
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninPage()),
                                  );
                                },
                                child: Image.asset('assets/images/boy.jpg')),
                          )),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SigninPage()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(top: 11.0, bottom: 11),
                    child: Text('${user.displayName} TO-DO\'s',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.deepPurple,
                            wordSpacing: 1,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search here....',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ))
                ],
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Incomplete
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Text('To-Do ${incompleteTaskCount}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          : GestureDetector(
                              onTap: () async {
                                Incomplete = true;
                                Complete = false;
                                await getonTheLoad();
                                setState(() {});
                              },
                              child: Text('To-Do ${incompleteTaskCount}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                      Complete
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Text('Done ${completeTaskCount}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          : GestureDetector(
                              onTap: () async {
                                Incomplete = false;
                                Complete = true;
                                await getonTheLoad();
                                setState(() {});
                              },
                              child: Text('Done ${completeTaskCount}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                    ]),
                SizedBox(
                  height: 20,
                ),
                getWork(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future openBox() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            clear();
                          },
                          child: Icon(Icons.cancel),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('Add your To-Do task',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurpleAccent)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Add Task',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                              controller: todo_controller,
                              decoration:
                                  InputDecoration(hintText: 'Enter your Task')),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        String id = randomAlphaNumeric(10);
                        String uid = user.uid;
                        Map<String, dynamic> userTodo = {
                          'work': todo_controller.text,
                          'uid': uid,
                          'Yes': false,
                          'id': id,
                        };
                        DatabaseService().addTask(userTodo, id);
                        incompleteTaskCount++;
                        Navigator.pop(context);
                        clear();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Text('Add'),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ));
  }
}
