import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:together/features/posts/domain/entities/post.dart';

part 'posts_controller.g.dart';

/// Loads and exposes the list of posts as an `AsyncValue`.
///
/// The repository returns a [Result]; here we unwrap it and re-throw the
/// [Failure] so it surfaces as `AsyncError`. That lets the UI use a single
/// `.when(data/loading/error)` rather than pattern-matching a `Result` nested
/// inside an `AsyncValue` — this is the Result↔AsyncValue bridge.
@riverpod
class PostsController extends _$PostsController {
  @override
  Future<List<Post>> build() => _load();

  Future<List<Post>> _load() async {
    final result = await ref.read(postsRepositoryProvider).getPosts();
    return switch (result) {
      Ok(:final value) => value,
      Err(:final failure) => throw failure,
    };
  }

  /// Re-fetch, surfacing the outcome through `state` (used by pull-to-refresh).
  /// Previous data stays visible until the new result arrives.
  Future<void> refresh() async {
    state = await AsyncValue.guard(_load);
  }
}

/// The post selected in the two-pane (tablet/foldable) layout. `null` until the
/// user taps one, where the UI falls back to the first post.
@riverpod
class SelectedPostId extends _$SelectedPostId {
  @override
  int? build() => null;

  void select(int id) => state = id;
}
