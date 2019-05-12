import 'package:flutter/material.dart';
import 'package:upg_fisi/infrastructure/teacher_sqflite_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/teacher.dart';
import 'package:upg_fisi/screens/teacher_detail.dart';

class TeacherList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TeacherListState();
}

class TeacherListState extends State<TeacherList> {
  TeacherSqfliteRepository courseRepository = TeacherSqfliteRepository(DatabaseProvider.get);
  List<Teacher> teachers;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (teachers == null) {
      teachers = List<Teacher>();
      getData();
    }
    return Scaffold(
      body: teacherListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToDetail(Teacher('', '', ''));
        }
        ,
        tooltip: "Add new teacher",
        child: new Icon(Icons.add),
      ),
    );
  }
  
  ListView teacherListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.teachers[position].id),
              child:Text(this.teachers[position].especialidad.toString()[0]),
            ),
          title: Text(this.teachers[position].name),
          subtitle: Text(this.teachers[position].especialidad.toString()),
          onTap: () {
            debugPrint("Tapped on " + this.teachers[position].id.toString());
            navigateToDetail(this.teachers[position]);
          },
          ),
        );
      },
    );
  }
  
  void getData() {    
      final teachersFuture = teacherRepository.getList();
      teachersFuture.then((teacherList) {
        setState(() {
          teachers = teacherList;
          count = teacherList.length;
        });
        debugPrint("Items " + count.toString());
      });
  }

  Color getColor(int id) {
    switch (id) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Teacher teacher) async {
    bool result = await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => TeacherDetail(teacher)),
    );
    if (result == true) {
      getData();
    }
  }
}
