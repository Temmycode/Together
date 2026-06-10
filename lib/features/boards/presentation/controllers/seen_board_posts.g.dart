// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seen_board_posts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The set of post ids the user has already swiped past this app session.
///
/// `keepAlive` is essential: an auto-dispose notifier would reset when the
/// viewer screen is popped, defeating the view-once rule. As a session-scoped
/// (in-memory) set, it resets on a full app restart — consistent with the
/// ephemeral product.

@ProviderFor(SeenBoardPosts)
final seenBoardPostsProvider = SeenBoardPostsProvider._();

/// The set of post ids the user has already swiped past this app session.
///
/// `keepAlive` is essential: an auto-dispose notifier would reset when the
/// viewer screen is popped, defeating the view-once rule. As a session-scoped
/// (in-memory) set, it resets on a full app restart — consistent with the
/// ephemeral product.
final class SeenBoardPostsProvider
    extends $NotifierProvider<SeenBoardPosts, Set<String>> {
  /// The set of post ids the user has already swiped past this app session.
  ///
  /// `keepAlive` is essential: an auto-dispose notifier would reset when the
  /// viewer screen is popped, defeating the view-once rule. As a session-scoped
  /// (in-memory) set, it resets on a full app restart — consistent with the
  /// ephemeral product.
  SeenBoardPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seenBoardPostsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seenBoardPostsHash();

  @$internal
  @override
  SeenBoardPosts create() => SeenBoardPosts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$seenBoardPostsHash() => r'ef348419ef04ca26cb7da7158afc605bce99f677';

/// The set of post ids the user has already swiped past this app session.
///
/// `keepAlive` is essential: an auto-dispose notifier would reset when the
/// viewer screen is popped, defeating the view-once rule. As a session-scoped
/// (in-memory) set, it resets on a full app restart — consistent with the
/// ephemeral product.

abstract class _$SeenBoardPosts extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The unseen posts for a board — what the viewer actually displays. Recomputes
/// whenever the board loads or a post is marked seen.

@ProviderFor(unseenBoardPosts)
final unseenBoardPostsProvider = UnseenBoardPostsFamily._();

/// The unseen posts for a board — what the viewer actually displays. Recomputes
/// whenever the board loads or a post is marked seen.

final class UnseenBoardPostsProvider
    extends
        $FunctionalProvider<List<BoardPost>, List<BoardPost>, List<BoardPost>>
    with $Provider<List<BoardPost>> {
  /// The unseen posts for a board — what the viewer actually displays. Recomputes
  /// whenever the board loads or a post is marked seen.
  UnseenBoardPostsProvider._({
    required UnseenBoardPostsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'unseenBoardPostsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$unseenBoardPostsHash();

  @override
  String toString() {
    return r'unseenBoardPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<BoardPost>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<BoardPost> create(Ref ref) {
    final argument = this.argument as String;
    return unseenBoardPosts(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<BoardPost> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<BoardPost>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UnseenBoardPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$unseenBoardPostsHash() => r'3db0034da715b2d822c15f24530cac1ff6225274';

/// The unseen posts for a board — what the viewer actually displays. Recomputes
/// whenever the board loads or a post is marked seen.

final class UnseenBoardPostsFamily extends $Family
    with $FunctionalFamilyOverride<List<BoardPost>, String> {
  UnseenBoardPostsFamily._()
    : super(
        retry: null,
        name: r'unseenBoardPostsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The unseen posts for a board — what the viewer actually displays. Recomputes
  /// whenever the board loads or a post is marked seen.

  UnseenBoardPostsProvider call(String boardId) =>
      UnseenBoardPostsProvider._(argument: boardId, from: this);

  @override
  String toString() => r'unseenBoardPostsProvider';
}
