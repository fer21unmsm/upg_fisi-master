import 'package:flutter/material.dart';
import 'package:upg_fisi/infrastructure/teacher_sqflite_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/teacher.dart';

TeacherSqfliteRepository teacherRepository = TeacherSqfliteRepository(DatabaseProvider.get);
final List<String> choices = const <String> [
  'Save Teacher & Back',
  'Delete Teacher',
  'Back to List'
];

const mnuSave = 'Save Teacher & Back';
const mnuDelete = 'Delete Teacher';
const mnuBack = 'Back to List';

class TeacherDetail extends StatefulWidget {
  final Teacher teacher;
  TeacherDetail(this.teacher);

  @override
  State<StatefulWidget> createState() => TeacherDetailState(teacher);
}

class TeacherDetailState extends State<TeacherDetail> {
  Teacher teacher;
  TeacherDetailState(this.teacher);
  TextEditingController nameController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = teacher.name;
    gradeController.text = teacher.grado;
    specialtyController.text = teacher.especialidad;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(teacher.name),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            style: textStyle,
            onChanged: (value) => this.updateName(),
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: gradeController,
            style: textStyle,
            onChanged: (value) => this.updateGrade(),
            decoration: InputDecoration(
              labelText: "Grado",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          )),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: specialtyController,
            style: textStyle,
            onChanged: (value) => this.updateSpecialty(),
            decoration: InputDecoration(
              labelText: "Especialidad",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ))          
        ],
      )],)
      )
    );
  }

  void select (String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (teacher.id == null) {
          return;
        }
        result = await teacherRepository.delete(teacher);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Teacher"),
            content: Text("The Teacher has been deleted"),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog);
          
        }
        break;
        case mnuBack:
          Navigator.pop(context, true);
          break;
      default:
    }
  }

  void save() {
    if (teacher.id != null) {
      debugPrint('update');
      teacherRepository.update(teacher);
    }
    else {
      debugPrint('insert');
      teacherRepository.insert(teacher);
    }
    Navigator.pop(context, true);
  }

  void updateName(){
    teacher.name = nameController.text;
  }

  void updateGrade() {
    teacher.grado = gradeController.text;
  }

  void updateSpecialty() {
    teacher.especialidad = specialtyController.text;
  }  
}
