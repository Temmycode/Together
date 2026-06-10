// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postsRemoteDataSource)
final postsRemoteDataSourceProvider = PostsRemoteDataSourceProvider._();

final class PostsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PostsRemoteDataSource,
          PostsRemoteDataSource,
          PostsRemoteDataSource
        >
    with $Provider<PostsRemoteDataSource> {
  PostsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PostsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PostsRemoteDataSource create(Ref ref) {
    return postsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostsRemoteDataSource>(value),
    );
  }
}

String _$postsRemoteDataSourceHash() =>
    r'33b0469f11bf3b85b0453faaa4cf86c1635ab52c';
