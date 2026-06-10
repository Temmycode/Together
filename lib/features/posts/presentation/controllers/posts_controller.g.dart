// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads and exposes the list of posts as an `AsyncValue`.
///
/// The repository returns a [Result]; here we unwrap it and re-throw the
/// [Failure] so it surfaces as `AsyncError`. That lets the UI use a single
/// `.when(data/loading/error)` rather than pattern-matching a `Result` nested
/// inside an `AsyncValue` — this is the Result↔AsyncValue bridge.

@ProviderFor(PostsController)
final postsControllerProvider = PostsControllerProvider._();

/// Loads and exposes the list of posts as an `AsyncValue`.
///
/// The repository returns a [Result]; here we unwrap it and re-throw the
/// [Failure] so it surfaces as `AsyncError`. That lets the UI use a single
/// `.when(data/loading/error)` rather than pattern-matching a `Result` nested
/// inside an `AsyncValue` — this is the Result↔AsyncValue bridge.
final class PostsControllerProvider
    extends $AsyncNotifierProvider<PostsController, List<Post>> {
  /// Loads and exposes the list of posts as an `AsyncValue`.
  ///
  /// The repository returns a [Result]; here we unwrap it and re-throw the
  /// [Failure] so it surfaces as `AsyncError`. That lets the UI use a single
  /// `.when(data/loading/error)` rather than pattern-matching a `Result` nested
  /// inside an `AsyncValue` — this is the Result↔AsyncValue bridge.
  PostsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsControllerHash();

  @$internal
  @override
  PostsController create() => PostsController();
}

String _$postsControllerHash() => r'a1466ac494c951800af14715bf2d7c576f379de3';

/// Loads and exposes the list of posts as an `AsyncValue`.
///
/// The repository returns a [Result]; here we unwrap it and re-throw the
/// [Failure] so it surfaces as `AsyncError`. That lets the UI use a single
/// `.when(data/loading/error)` rather than pattern-matching a `Result` nested
/// inside an `AsyncValue` — this is the Result↔AsyncValue bridge.

abstract class _$PostsController extends $AsyncNotifier<List<Post>> {
  FutureOr<List<Post>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Post>>, List<Post>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Post>>, List<Post>>,
              AsyncValue<List<Post>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The post selected in the two-pane (tablet/foldable) layout. `null` until the
/// user taps one, where the UI falls back to the first post.

@ProviderFor(SelectedPostId)
final selectedPostIdProvider = SelectedPostIdProvider._();

/// The post selected in the two-pane (tablet/foldable) layout. `null` until the
/// user taps one, where the UI falls back to the first post.
final class SelectedPostIdProvider
    extends $NotifierProvider<SelectedPostId, int?> {
  /// The post selected in the two-pane (tablet/foldable) layout. `null` until the
  /// user taps one, where the UI falls back to the first post.
  SelectedPostIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPostIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPostIdHash();

  @$internal
  @override
  SelectedPostId create() => SelectedPostId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$selectedPostIdHash() => r'e7c25a3bd9cc22a1f3a2ac3ba7e544bfb30aa0a6';

/// The post selected in the two-pane (tablet/foldable) layout. `null` until the
/// user taps one, where the UI falls back to the first post.

abstract class _$SelectedPostId extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
