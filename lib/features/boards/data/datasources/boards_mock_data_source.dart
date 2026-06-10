import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/domain/entities/board_member.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';

part 'boards_mock_data_source.g.dart';

/// In-memory mock backend for the boards feature.
///
/// Holds seeded boards and posts built once at construction. This is the seam a
/// real remote data source (Dio + DTOs) will later replace — the repository and
/// everything above it stay unchanged. Images use deterministic picsum URLs;
/// avatars use pravatar. Seed timestamps are fixed constants (no `DateTime.now`)
/// so layout and tests stay deterministic.
class BoardsMockDataSource {
  BoardsMockDataSource();

  static const Duration _latency = Duration(milliseconds: 350);

  /// A fixed "now" the seed is anchored to, so `expiresAt` windows are stable.
  static final DateTime _reference = DateTime(2026, 6, 10, 9);

  late final List<Board> _boards = _seedBoards();
  late final Map<String, List<BoardPost>> _postsByBoard = _seedPosts();

  Future<List<Board>> fetchBoards() async {
    await Future<void>.delayed(_latency);
    return _boards;
  }

  Future<Board> fetchBoard(String id) async {
    await Future<void>.delayed(_latency);
    return _boards.firstWhere((board) => board.id == id);
  }

  Future<List<BoardPost>> fetchPosts(String boardId) async {
    await Future<void>.delayed(_latency);
    return _postsByBoard[boardId] ?? const [];
  }

  // --- seed builders -------------------------------------------------------

  BoardPost _post({
    required String id,
    required String boardId,
    required String author,
    required int daysAgo,
    String? caption,
  }) {
    final created = _reference.subtract(Duration(days: daysAgo));
    return BoardPost(
      id: id,
      boardId: boardId,
      authorName: author,
      authorAvatarUrl: 'https://i.pravatar.cc/150?u=$boardId-$author',
      imageUrl: 'https://picsum.photos/seed/$id/600/800',
      caption: caption,
      createdAt: created,
      expiresAt: created.add(const Duration(days: 7)),
    );
  }

  BoardMember _member(String boardId, String name, {bool posted = false}) =>
      BoardMember(
        id: '$boardId-$name',
        name: name,
        avatarUrl: 'https://i.pravatar.cc/150?u=$boardId-$name',
        hasPostedToday: posted,
      );

  Map<String, List<BoardPost>> _seedPosts() {
    final weekend = [
      _post(id: 'w1', boardId: 'weekend', author: 'Maya', daysAgo: 0, caption: 'Morning light'),
      _post(id: 'w2', boardId: 'weekend', author: 'Theo', daysAgo: 0, caption: 'Coffee run'),
      _post(id: 'w3', boardId: 'weekend', author: 'Ada', daysAgo: 1, caption: 'Park day'),
      _post(id: 'w4', boardId: 'weekend', author: 'Maya', daysAgo: 2),
      _post(id: 'w5', boardId: 'weekend', author: 'Sam', daysAgo: 3, caption: 'Late night'),
      _post(id: 'w6', boardId: 'weekend', author: 'Theo', daysAgo: 5),
    ];
    final tokyo = [
      _post(id: 't1', boardId: 'tokyo', author: 'Ren', daysAgo: 0, caption: 'Shibuya crossing'),
      _post(id: 't2', boardId: 'tokyo', author: 'Lin', daysAgo: 1, caption: 'Ramen, finally'),
      _post(id: 't3', boardId: 'tokyo', author: 'Kai', daysAgo: 1),
      _post(id: 't4', boardId: 'tokyo', author: 'Ren', daysAgo: 4, caption: 'Temple morning'),
      _post(id: 't5', boardId: 'tokyo', author: 'Lin', daysAgo: 6),
    ];
    final studio = [
      _post(id: 's1', boardId: 'studio', author: 'Nora', daysAgo: 0, caption: 'Desk today'),
      _post(id: 's2', boardId: 'studio', author: 'Eli', daysAgo: 0),
      _post(id: 's3', boardId: 'studio', author: 'Jun', daysAgo: 1, caption: 'Prototype #4'),
      _post(id: 's4', boardId: 'studio', author: 'Mia', daysAgo: 2),
      _post(id: 's5', boardId: 'studio', author: 'Leo', daysAgo: 3, caption: 'Whiteboard chaos'),
      _post(id: 's6', boardId: 'studio', author: 'Nora', daysAgo: 4),
      _post(id: 's7', boardId: 'studio', author: 'Jun', daysAgo: 6, caption: 'Shipping it'),
    ];
    return {'weekend': weekend, 'tokyo': tokyo, 'studio': studio};
  }

  List<Board> _seedBoards() {
    final posts = _postsByBoard;
    List<String> covers(String boardId) =>
        (posts[boardId] ?? const [])
            .take(3)
            .map((p) => p.imageUrl)
            .toList(growable: false);

    return [
      Board(
        id: 'weekend',
        name: 'Weekend Crew',
        prompt: 'What made you smile today?',
        createdAt: _reference.subtract(const Duration(days: 40)),
        members: [
          _member('weekend', 'Maya', posted: true),
          _member('weekend', 'Theo', posted: true),
          _member('weekend', 'Ada'),
          _member('weekend', 'Sam'),
        ],
        coverImageUrls: covers('weekend'),
      ),
      Board(
        id: 'tokyo',
        name: 'Tokyo Trip',
        prompt: 'One frame from the road',
        createdAt: _reference.subtract(const Duration(days: 8)),
        members: [
          _member('tokyo', 'Ren', posted: true),
          _member('tokyo', 'Lin'),
          _member('tokyo', 'Kai'),
        ],
        coverImageUrls: covers('tokyo'),
      ),
      Board(
        id: 'studio',
        name: 'Studio 7',
        prompt: 'Show your desk',
        createdAt: _reference.subtract(const Duration(days: 120)),
        members: [
          _member('studio', 'Nora', posted: true),
          _member('studio', 'Eli', posted: true),
          _member('studio', 'Jun'),
          _member('studio', 'Mia'),
          _member('studio', 'Leo'),
        ],
        coverImageUrls: covers('studio'),
      ),
    ];
  }
}

@riverpod
BoardsMockDataSource boardsMockDataSource(Ref ref) => BoardsMockDataSource();
