import 'package:upg_fisi/infrastructure/dao.dart';
import 'package:upg_fisi/model/teacher.dart';

class TeacherDao implements Dao<Teacher> {
  final tableName = 'teachers';
  final columnId = 'id';
  final _columnName = 'name';
  final _columnGrade = 'grade';
  final _columnSpecialty = 'specialty';

  @override
  String get createTableQuery =>
    "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
    " $_columnName TEXT,"
    " $_columnGrade TEXT,"
    " $_columnSpecialty TEXT)";

  @override
  Teacher fromMap(Map<String, dynamic> query) {
    Teacher teacher = Teacher(query[columnId], query[_columnGrade], query[_columnSpecialty]);
    return teacher;
  }

  @override
  Map<String, dynamic> toMap(Teacher teacher) {
    return <String, dynamic>{
      _columnName: teacher.name,
      _columnGrade: teacher.grado,
      _columnSpecialty: teacher.especialidad
    };
  }

  Teacher fromDbRow(dynamic row) {
    return Teacher.withId(row[columnId], row[_columnName], row[_columnGrade], row[_columnSpecialty]);
  }

  @override
  List<Teacher> fromList(result) {
    List<Teacher> teachers = List<Teacher>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      teachers.add(fromDbRow(result[i]));
    }
    return teachers;
  }
}
