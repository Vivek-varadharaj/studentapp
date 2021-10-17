// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';

import 'package:student_details_app/widgets/dropdown_button.dart';

class EditStudent extends StatefulWidget {
  StudentModel studentModel;
  Function editIt;
  int id;
  String name;
  String marks;
  String rollNumber;
  String status;
  String studentClass;
  EditStudent({
    required this.studentModel,
    required this.editIt,
    required this.id,
    required this.name,
    required this.status,
    required this.rollNumber,
    required this.marks,
    required this.studentClass,
  });
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  
  changeIt(selectedValue) {
    setState(() {
      widget.status = selectedValue;
    });
    print(widget.status);
  }

  // final ImagePicker _picker = new ImagePicker();
  var image =
      "https://vivek-varadharaj.github.io/Vivek-Varadharaj/img/vivek3.jpg";
 

  StudentModel? newStudent;

  void addNewStudent(String newId, String newName, String newClass,
      String newStatus, String newMarks) {
    newStudent = StudentModel(
      id: widget.id,
      rollNumber: widget.rollNumber,
      name: widget.name,
      standard: widget.studentClass,
      status: widget.status,
      marks: widget.marks,
    );
    widget.editIt(newStudent, widget.id);
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // nameController.value = TextEditingValue(text: widget.name);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(children: [
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Card(
                elevation: 10,
                // color: Colors.lightBlue,
                shadowColor: Color(MyApp.royalBlue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: InkWell(
                          child: CircleAvatar(
                            // backgroundImage: FileImage(File(image)),

                            radius: 60,
                          ),
                          onTap: () {
                            // takePhoto(ImageSource.camera);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
                          initialValue: widget.rollNumber,
                          // controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Student ID'),
                          ),
                          onChanged: (value) {
                            widget.rollNumber = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
                          initialValue: widget.name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Name of Student'),
                          ),
                          onChanged: (value) {
                            widget.name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
                          initialValue: widget.studentClass,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.school),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Class of Student'),
                          ),
                          onChanged: (value) {
                            widget.studentClass = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
                          initialValue: widget.marks,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Mark of Student'),
                          ),
                          onChanged: (value) {
                            widget.marks = value;
                          },
                        ),
                      ),
                      DropDown(widget.status, changeIt),
                      ElevatedButton(
                        onPressed: () async {
                          addNewStudent(widget.rollNumber, widget.name, widget.studentClass,
                              widget.status, widget.marks);
                          Navigator.pop(context);
                        },
                        child: Text("Save Edited"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // takePhoto(source) async {
  //   final images = (await _picker.pickImage(
  //     source: source,
  //   ));

  //   setState(() {
  //     image = images!.path;
  //   });
  // }
}
