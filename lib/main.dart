import 'package:flutter/widgets.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/screens/add_student.dart';
import 'package:student_details_app/screens/home_screen.dart';
import 'package:student_details_app/screens/search_student.dart';

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
  List<StudentModel> studentModel3 = <StudentModel>[];

//  *************Functions ***************//

//function for getting student data from database//

  void getStudentData() async {
    await db.createDatabase();
    studentModel2 = await db.getStudent();
  
    setState(() {});
  }

  // void letState1(StudentModel newStudent, context) async {
  //   final data = DataBaseHelper();
  //   await data
  //       .insertStudent(newStudent); //database helper function to insert data
  //   studentModel2 = await db.getStudent();
  //   setState(() {});
    
  // }

//function for setting the state after adding student data to database//
  void letState(StudentModel newStudent, context) async {
    final data = DataBaseHelper();
    await data
        .insertStudent(newStudent); //database helper function to insert data
    studentModel2 = await db.getStudent();
    setState(() {});
    Navigator.pop(context);
  }

  //function fot setting the state of mainscreen when data is deleted
  void deleteIt(id) async {
    final db = DataBaseHelper();
    db.deleteStudent(
        id); //database helper function invoked to delete the data from database
    studentModel2 = await db.getStudent(); // gets the updated data
    setState(() {}); //Sets the state of the screen after getting updated data
  }

//function for editing the student data upon request
  void editIt(StudentModel student, int id) async {
    final db = DataBaseHelper();
    db.editStudent(
        student, id); //database helper function that edits and savesdata
    studentModel2 = await db.getStudent(); //gets the updated data on realtime
    setState(() {}); //sets the state of the screen after getting updated data
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
                    icon: Icon(Icons.search),
                    text: "Search",
                  )
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body: TabBarView(children: [
              ListView(
                children: [
                  ...studentModel2!.map((e) {
                   
                    //building list of widgets according to the input dat and spreading it.
                    return HomeScreen(
                      // passes these many parameters because it is needed to pass these info to another screens from home screen
                      standard: e.standard,
                      rollNumber: e.rollNumber!,
                      marks: e.marks,
                      editIt: editIt,
                      student: e,
                      id: e.id!,
                      name: e.name,
                      status: e.status,
                      deleteIt: deleteIt,
                      image: e.image,
                    );
                  }).toList(),
                ],
              ),
              //passes letstate function to set state here when an event happens there
              SearchStudent(deleteIt, editIt),//passed functions to edit and delete as well as setting the state
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudent(letState),
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
