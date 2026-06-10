// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Binds the [PostsRepository] interface to its implementation. Controllers
/// watch this and receive the interface type.

@ProviderFor(postsRepository)
final postsRepositoryProvider = PostsRepositoryProvider._();

/// Binds the [PostsRepository] interface to its implementation. Controllers
/// watch this and receive the interface type.

final class PostsRepositoryProvider
    extends
        $FunctionalProvider<PostsRepository, PostsRepository, PostsRepository>
    with $Provider<PostsRepository> {
  /// Binds the [PostsRepository] interface to its implementation. Controllers
  /// watch this and receive the interface type.
  PostsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PostsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostsRepository create(Ref ref) {
    return postsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostsRepository>(value),
    );
  }
}

String _$postsRepositoryHash() => r'4810bb8a4ce70d829d089e3a23fc4f8cbe84aa18';
