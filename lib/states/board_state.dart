// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:test_todo/model/task.dart';

class BoardState {}

class LoadingBoardState implements BoardState {}

class GettedTasksBoardState implements BoardState {
  final List<Task> tasks;

  GettedTasksBoardState({
    required this.tasks,
  });
}

class EmptyBoardState extends GettedTasksBoardState {
  EmptyBoardState() : super(tasks: []);
}

class FailureBoardState implements BoardState {
  final String message;

  FailureBoardState({
    required this.message,
  });
}
