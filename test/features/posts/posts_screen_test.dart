import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:together/features/posts/domain/entities/post.dart';
import 'package:together/features/posts/domain/repositories/posts_repository.dart';
import 'package:together/features/posts/presentation/screens/posts_screen.dart';

class _FakePostsRepository implements PostsRepository {
  const _FakePostsRepository(this._posts);

  final List<Post> _posts;

  @override
  Future<Result<List<Post>>> getPosts() async => Ok(_posts);
}

void main() {
  const posts = [
    Post(id: 1, userId: 1, title: 'Hello', body: 'First body'),
    Post(id: 2, userId: 1, title: 'Second', body: 'Second body'),
  ];

  Future<void> pumpScreen(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          postsRepositoryProvider
              .overrideWithValue(const _FakePostsRepository(posts)),
        ],
        child: const MaterialApp(home: PostsScreen()),
      ),
    );
    // First frame is the loading state; let the (fake) future resolve.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('renders a single-column list on a phone', (tester) async {
    await pumpScreen(tester, const Size(390, 844));

    expect(find.text('Posts'), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Second'), findsOneWidget);
  });

  testWidgets('renders a two-pane master/detail on a tablet', (tester) async {
    await pumpScreen(tester, const Size(1024, 768));

    // The detail pane shows the first post by default, so its title appears in
    // both the list card and the detail view.
    expect(find.text('Hello'), findsNWidgets(2));
    expect(find.textContaining('Post #1'), findsOneWidget);
  });
}
