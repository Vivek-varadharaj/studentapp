// import 'dart:js';

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';
// import 'package:student_details_app/screens/add_student.dart';
import 'package:student_details_app/screens/edit_student.dart';
import 'package:student_details_app/screens/view_student.dart';

class HomeScreen extends StatelessWidget {
  DataBaseHelper db = DataBaseHelper();
  StudentModel? student;
  Function deleteIt;
  Function editIt;
  final String rollNumber;
  final int id;
  final String? name;
  final String? status;
  final String? standard;
  final String? marks;
  HomeScreen(
      {required this.id,
      required this.name,
      required this.marks,
      required this.status,
      required this.standard,
      required this.rollNumber,
      required this.deleteIt,
      required this.student,
      required this.editIt});

  @override
  Widget build(BuildContext context) {
    delete() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Your Wish?"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteIt(id);
                        Navigator.pop(context);
                      },
                      child: Text("Delete"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditStudent(
                                        editIt: editIt,
                                        studentModel: student!,
                                        id: id,
                                        name: name!,
                                        marks: marks!,
                                        rollNumber: rollNumber,
                                        status: status!,
                                        studentClass: standard!,
                                      )));
                        },
                        child: Text("Edit"))
                  ],
                ),
              ));
      //
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shadowColor: Color(MyApp.royalBlue),
        child: ListTile(
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://vivek-varadharaj.github.io/Vivek-Varadharaj/img/vivek3.jpg"),
          ),
          title: Text(name!),
          trailing: Text(status!),
          onLongPress: delete,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewStudent(
                                        editIt: editIt,
                                        studentModel: student!,
                                        id: id,
                                        name: name!,
                                        marks: marks!,
                                        rollNumber: rollNumber,
                                        status: status!,
                                        studentClass: standard!,
                                      )));
          },
        ),
      ),
    );
  }
}
