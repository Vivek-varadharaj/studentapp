import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:student_details_app/models/student_model.dart';
import 'package:path/path.dart';
// import 'package:student_details_app/models/student_model.dart';




 class DataBaseHelper{
 static Database? _database;
 static DataBaseHelper? _dataBaseHelper;
 DataBaseHelper.createInstance();

 factory DataBaseHelper(){
   if(_dataBaseHelper == null ){
     _dataBaseHelper = DataBaseHelper.createInstance();
   }
   return _dataBaseHelper!;
 }

  Future <Database?> get database async{
   if (_database == null ){
     _database = await createDatabase();
   }
   return _database;
  }
 
 Future<Database> createDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path,'Mystudent.db'),onCreate:(db,version) async{
       await db.execute(
         """
         CREATE TABLE Mystudent(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           roll TEXT,
           name TEXT,
           standard TEXT,
           marks TEXT,
           status TEXT
         )
         """
       );
    },
    version: 1, );
 }
    


  
    

  


  //Adding data to data base function //

  Future <bool> insertStudent(StudentModel student) async {
     final Database? database=  await this.database;
     database!.insert('Mystudent', student.toMap());
     return true;
    
  }


  //Getting data from database//

  Future <List<StudentModel>> getStudent() async{
    final db = await createDatabase();
    final List<Map<String,dynamic>> mapOfStudent = await db.query('Mystudent');
    return List.generate(mapOfStudent.length, (index) {
         return StudentModel(
           id: mapOfStudent[index]['id'],
           rollNumber: mapOfStudent[index]['roll'],
           name: mapOfStudent[index]['name'],
           standard: mapOfStudent[index]['standard'],
           marks: mapOfStudent[index]['marks'],
           status: mapOfStudent[index]['status'],
         );
    });
  }

  //function for deleting

  void deleteStudent (int id) async{
    final db = await this.database;
    db!.delete('Mystudent',where: "id=?", whereArgs: [id]);
  }

  //function for editing

  Future editStudent(StudentModel student ,int id) async{
    final db = await this.database;
    db!.update('Mystudent', student.toMap(), where: "id=?", whereArgs: [id]  );
  }

}