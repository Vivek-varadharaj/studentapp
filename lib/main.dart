import 'package:flutter/widgets.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:async';

import 'package:student_details_app/models/student_model.dart';
// import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';

// import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/screens/add_student.dart';
import 'package:student_details_app/screens/add_student_tab.dart';
import 'package:student_details_app/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  static const mintGreen = 0xff3EB489;
  static const scarletRed = 0xffFF2400;
  static const royalBlue = 0xff246EE9;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataBaseHelper db = DataBaseHelper();
  List<StudentModel>? studentModel2;

//  *************Functions ***************//

//function for getting student data from database//
  void getStudentData() async {
    await db.createDatabase();
    studentModel2 = await db.getStudent();
    setState(() {});
  }

//function for setting the state after adding student data to database//
  void letState(newStudent, context) async {
    final data = DataBaseHelper();
    await data.insertStudent(newStudent);
    studentModel2 = await db.getStudent();
    setState(() {});
    Navigator.pop(context);
  }

  void deleteIt(id) async {
    print('hai');
    final db = DataBaseHelper();
    db.deleteStudent(id);
    studentModel2 = await db.getStudent();
    setState(
      () {},
    );
    // Navigator.pop(context);
  }

  void editIt(StudentModel student,int id) async {
    final db = DataBaseHelper();
    db.editStudent(student,id);
    studentModel2 = await db.getStudent();
    setState(() {});
  }

  // *************** End of functions*********************//

  @override
  Widget build(BuildContext context) {
    if (studentModel2 == null) {
      studentModel2 = <StudentModel>[];
      getStudentData();
    }

    return Builder(builder: (context) {
      return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Student Log'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(MyApp.royalBlue), Colors.black],
                  ),
                ),
              ),
              centerTitle: true,
              elevation: 20,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                  ),
                  Tab(
                    icon: Icon(Icons.add),
                    text: "Add",
                  ),
                  
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body: TabBarView(
              children: [ListView(
                children: [
                  ...studentModel2!.map((e) {
                    return HomeScreen(
                      standard: e.standard,
                      rollNumber: e.rollNumber!,
                      marks: e.marks,
                      editIt: editIt,
                      student: e,
                      id: e.id!,
                      name: e.name,
                      status: e.status,
                      deleteIt: deleteIt,
                    );
                  }).toList(),
                ],
              ),
              AddStudentTab(studentModel2, letState)
              ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudent(studentModel2, letState),
                  ),
                );
              },
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Color(MyApp.royalBlue),
            ),
          ),
        ),
      );
    });
  }
}
