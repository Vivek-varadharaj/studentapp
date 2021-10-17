// import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';

import 'package:student_details_app/widgets/dropdown_button.dart';

class AddStudent extends StatefulWidget {
  var studentModel;
  Function letState;
  AddStudent(this.studentModel, this.letState);
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  String? currentItemSelected;
  changeIt(selectedValue) {
    setState(() {
      this.currentItemSelected = selectedValue;
    });
    print(currentItemSelected);
  }

  final ImagePicker _picker = new ImagePicker();
  var image =
      "https://vivek-varadharaj.github.io/Vivek-Varadharaj/img/vivek3.jpg";
  String? rollNumber;
  String? name;
  String? studentClass;
  String? status;
  String? marks;

  StudentModel? newStudent;

  void addNewStudent(String newId, String newName, String newClass,
      String newStatus, String newMarks) {
    newStudent = StudentModel(
      rollNumber: newId,
      name: newName,
      standard: newClass,
      status: newStatus,
      marks: newMarks,
    );
    widget.letState(newStudent, context);
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        color: Colors.black,
        child: Form(
          key: _formKey,
          
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
                              takePhoto(ImageSource.camera);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              rollNumber = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              name = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              studentClass = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required field";
                              }
                              return null;
                            },
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
                              marks = value;
                            },
                          ),
                        ),
                        DropDown(currentItemSelected, changeIt),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              addNewStudent(rollNumber!, name!, studentClass!,
                                  currentItemSelected!, marks!);
                            }
                          },
                          child: Text("Add Student"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  takePhoto(source) async {
    final images = (await _picker.pickImage(
      source: source,
    ));

    setState(() {
      image = images!.path;
    });
  }
}
