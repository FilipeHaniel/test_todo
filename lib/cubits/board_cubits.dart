import 'package:bloc/bloc.dart';
import 'package:test_todo/model/task.dart';
import 'package:test_todo/states/board_state.dart';

class BoardCubits extends Cubit<BoardState> {
  BoardCubits() : super(EmptyBoardState());

  Future<void> fetchTasks() async {}

  Future<void> addTask(Task newTask) async {}

  Future<void> removeTask(Task newTask) async {}

  Future<void> checkTask(Task newTask) async {}
}
