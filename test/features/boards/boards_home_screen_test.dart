import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/boards/data/repositories/boards_repository_impl.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/domain/entities/board_member.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/domain/repositories/boards_repository.dart';
import 'package:together/features/boards/presentation/screens/boards_home_screen.dart';

class _FakeBoardsRepository implements BoardsRepository {
  const _FakeBoardsRepository(this._boards);

  final List<Board> _boards;

  @override
  Future<Result<List<Board>>> getBoards() async => Ok(_boards);

  @override
  Future<Result<Board>> getBoard(String id) async =>
      throw UnimplementedError();

  @override
  Future<Result<List<BoardPost>>> getPosts(String boardId) async =>
      throw UnimplementedError();
}

void main() {
  final boards = [
    Board(
      id: 'weekend',
      name: 'Weekend Crew',
      prompt: 'What made you smile today?',
      members: const [BoardMember(id: 'm1', name: 'Maya', hasPostedToday: true)],
      createdAt: DateTime(2026),
    ),
    Board(
      id: 'tokyo',
      name: 'Tokyo Trip',
      members: const [BoardMember(id: 'm2', name: 'Ren')],
      createdAt: DateTime(2026),
    ),
  ];

  testWidgets('renders the seeded boards', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          boardsRepositoryProvider
              .overrideWithValue(_FakeBoardsRepository(boards)),
        ],
        child: const MaterialApp(home: BoardsHomeScreen()),
      ),
    );
    // First frame is the loader; let the fake future resolve.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Together'), findsOneWidget);
    expect(find.text('Weekend Crew'), findsOneWidget);
    expect(find.text('Tokyo Trip'), findsOneWidget);
  });
}
