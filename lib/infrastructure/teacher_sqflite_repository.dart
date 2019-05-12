import 'package:upg_fisi/infrastructure/teacher_dao.dart';
import 'package:upg_fisi/infrastructure/teacher_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/teacher.dart';

class TeacherSqfliteRepository implements TeacherRepository {
  final dao = TeacherDao();

  @override
  DatabaseProvider databaseProvider;

  TeacherSqfliteRepository(this.databaseProvider);

  @override
  Future<int> insert(Teacher teacher) async {
    final db = await databaseProvider.db();
    var id = await db.insert(dao.tableName, dao.toMap(teacher));
    return id;
  }

  @override
  Future<int> delete(Teacher teacher) async {
    final db = await databaseProvider.db();
    int result = await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [teacher.id]);
    return result;
  }

  @override
  Future<int> update(Teacher teacher) async {
    final db = await databaseProvider.db();
    int result = await db.update(dao.tableName, dao.toMap(teacher),
        where: dao.columnId + " = ?", whereArgs: [teacher.id]);
    return result;
  }

  @override
  Future<List<Teacher>> getList() async {
    final db = await databaseProvider.db();
    var result = await db.rawQuery("SELECT * FROM teachers order by specialty ASC, name ASC");
    return dao.fromList(result);
  }
}