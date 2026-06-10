import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:together/features/posts/domain/entities/post.dart';
import 'package:together/features/posts/domain/repositories/posts_repository.dart';
import 'package:together/features/posts/presentation/controllers/posts_controller.dart';

class _FakePostsRepository implements PostsRepository {
  const _FakePostsRepository(this._result);

  final Result<List<Post>> _result;

  @override
  Future<Result<List<Post>>> getPosts() async => _result;
}

void main() {
  const post = Post(id: 1, userId: 1, title: 'Hello', body: 'World');

  /// Builds a container with the repository faked, and keeps
  /// [postsControllerProvider] (autoDispose by default) alive while it builds
  /// so it isn't disposed mid-load during the test.
  ProviderContainer containerWith(Result<List<Post>> result) {
    final container = ProviderContainer(
      // Match the app: no implicit auto-retry, so an error settles on
      // AsyncError deterministically.
      retry: (_, _) => null,
      overrides: [
        postsRepositoryProvider.overrideWithValue(_FakePostsRepository(result)),
      ],
    );
    addTearDown(container.dispose);
    container.listen(postsControllerProvider, (_, _) {});
    return container;
  }

  test('exposes the posts as AsyncData on success', () async {
    final container = containerWith(const Ok([post]));

    await pumpEventQueue();

    final state = container.read(postsControllerProvider);
    expect(state, isA<AsyncData<List<Post>>>());
    expect(state.value, [post]);
  });

  test('re-throws the Failure so it surfaces as AsyncError', () async {
    final container = containerWith(const Err(NetworkFailure()));

    await pumpEventQueue();

    final state = container.read(postsControllerProvider);
    expect(state, isA<AsyncError<List<Post>>>());
    expect((state as AsyncError).error, isA<NetworkFailure>());
  });
}
