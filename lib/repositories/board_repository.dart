import 'package:test_todo/model/task.dart';

abstract class BoardRepository {
  Future<List<Task>> fetch();

  Future<List<Task>> update(List<Task> tasks);
}
