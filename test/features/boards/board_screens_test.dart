import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/boards/data/repositories/boards_repository_impl.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/domain/repositories/boards_repository.dart';
import 'package:together/features/boards/presentation/screens/board_collage_screen.dart';
import 'package:together/features/boards/presentation/screens/board_viewer_screen.dart';
import 'package:together/features/boards/presentation/widgets/swipe_card.dart';

class _FakeBoardsRepository implements BoardsRepository {
  const _FakeBoardsRepository(this._posts);

  final List<BoardPost> _posts;

  @override
  Future<Result<List<Board>>> getBoards() async => const Ok([]);

  @override
  Future<Result<Board>> getBoard(String id) async => throw UnimplementedError();

  @override
  Future<Result<List<BoardPost>>> getPosts(String boardId) async => Ok(_posts);
}

BoardPost _post(String id, String caption) => BoardPost(
      id: id,
      boardId: 'b',
      authorName: 'Author $id',
      imageUrl: 'x',
      caption: caption,
      createdAt: DateTime(2026),
      expiresAt: DateTime(2026, 1, 8),
    );

Widget _wrap(Widget child, List<BoardPost> posts) => ProviderScope(
      retry: (_, _) => null,
      overrides: [
        boardsRepositoryProvider
            .overrideWithValue(_FakeBoardsRepository(posts)),
      ],
      child: MaterialApp(home: child),
    );

void main() {
  // Stable phone surface so swipe thresholds are predictable.
  Future<void> settle(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('collage screen renders tiles and the view entry', (tester) async {
    await tester.pumpWidget(
      _wrap(const BoardCollageScreen(boardId: 'b'), [
        _post('p1', 'one'),
        _post('p2', 'two'),
      ]),
    );
    await settle(tester);

    expect(find.text('View moments'), findsOneWidget);
    // Two tiles are laid out in the collage.
    expect(find.byType(GestureDetector), findsWidgets);
  });

  testWidgets('viewer hides a post after it is swiped past (view-once)',
      (tester) async {
    await tester.pumpWidget(
      _wrap(const BoardViewerScreen(boardId: 'b'), [
        _post('p1', 'one'),
        _post('p2', 'two'),
        _post('p3', 'three'),
      ]),
    );
    await settle(tester);

    expect(find.byType(SwipeCard), findsNWidgets(3)); // top + 2 peeks
    expect(find.text('one'), findsOneWidget); // top card caption

    // Fling the top card off to the right, past the threshold.
    await tester.fling(find.text('one'), const Offset(400, 0), 1200);
    await tester.pumpAndSettle();

    // The swiped post is gone, does not return, and the stack shrank by one.
    expect(find.text('one'), findsNothing);
    expect(find.byType(SwipeCard), findsNWidgets(2));
  });

  testWidgets('viewer shows the all-caught-up state when nothing is unseen',
      (tester) async {
    await tester.pumpWidget(
      _wrap(const BoardViewerScreen(boardId: 'b'), const []),
    );
    await settle(tester);

    expect(find.text("You're all caught up"), findsOneWidget);
  });
}
