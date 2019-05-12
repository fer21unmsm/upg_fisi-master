import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/teacher.dart';

abstract class TeacherRepository {
  DatabaseProvider databaseProvider;
  Future<int> insert(Teacher teacher);
  Future<int> update(Teacher teacher);
  Future<int> delete(Teacher teacher);
  Future<List<Teacher>> getList();
}