import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_todo/cubits/board_cubits.dart';
import 'package:test_todo/model/task.dart';
import 'package:test_todo/repositories/board_repository.dart';
import 'package:test_todo/states/board_state.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  final repository = BoardRepositoryMock();

  final cubit = BoardCubits(repository);

  tearDown(() => reset(repository));

  group('fetchTasks |', () {
    test('deve pegar todas as tasks', () async {
      when(() => repository.fetch()).thenAnswer((_) async => [
            const Task(id: 1, description: 'description', check: false),
          ]);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.fetchTasks();
    });

    test('Deve retornar um estado de erro ao falhar', () async {
      when(() => repository.fetch()).thenThrow(Exception('Error'));

      expect(
          cubit.stream,
          emitsInOrder(
            [
              isA<LoadingBoardState>(),
              isA<FailureBoardState>(),
            ],
          ));

      await cubit.fetchTasks();
    });
  });

  group('addTasks |', () {
    test('deve adicionar uma task', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      const task = Task(id: 1, description: 'description');

      await cubit.addTask(task);

      final state = cubit.state as GettedTasksBoardState;

      expect(state.tasks.length, 1);
      expect(state.tasks, [task]);
    });

    test('Deve retornar um estado de erro ao falhar', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));

      expect(
          cubit.stream,
          emitsInOrder(
            [
              isA<FailureBoardState>(),
            ],
          ));

      const task = Task(id: 1, description: 'description');

      await cubit.addTask(task);
    });
  });

  group('removeTasks |', () {
    test('deve remover uma tasks', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);

      const task = Task(id: 1, description: 'description');
      cubit.addTask([task]);

      expect((cubit.state as GettedTasksBoardState).tasks.length, 0);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.removeTask(task);
      final state = cubit.state as GettedTasksBoardState;

      expect(state.tasks.length, 0);
      expect(state.tasks, [task]);
    });

    test('Deve retornar um estado de erro ao falhar', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));

      const task = Task(id: 1, description: 'description');
      cubit.addTask(task);

      expect(
          cubit.stream,
          emitsInOrder(
            [
              isA<FailureBoardState>(),
            ],
          ));

      await cubit.addTask(task);
    });
  });
}
