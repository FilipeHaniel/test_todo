import 'package:bloc/bloc.dart';
import 'package:test_todo/model/task.dart';
import 'package:test_todo/repositories/board_repository.dart';
import 'package:test_todo/states/board_state.dart';

class BoardCubits extends Cubit<BoardState> {
  final BoardRepository repository;

  BoardCubits(this.repository) : super(EmptyBoardState());

  Future<void> fetchTasks() async {
    emit(LoadingBoardState());

    try {
      final tasks = await repository.fetch();

      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }

  Future<void> addTask(Task newTask) async {
    final state = this.state;

    if (state is! GettedTasksBoardState) {
      return;
    }

    final tasks = state.tasks.toList();

    tasks.add(newTask);

    try {
      await repository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }

  Future<void> removeTask(Task newTask) async {}

  Future<void> checkTask(Task newTask) async {}
}
