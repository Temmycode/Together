// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boards_mock_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(boardsMockDataSource)
final boardsMockDataSourceProvider = BoardsMockDataSourceProvider._();

final class BoardsMockDataSourceProvider
    extends
        $FunctionalProvider<
          BoardsMockDataSource,
          BoardsMockDataSource,
          BoardsMockDataSource
        >
    with $Provider<BoardsMockDataSource> {
  BoardsMockDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardsMockDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardsMockDataSourceHash();

  @$internal
  @override
  $ProviderElement<BoardsMockDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BoardsMockDataSource create(Ref ref) {
    return boardsMockDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardsMockDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardsMockDataSource>(value),
    );
  }
}

String _$boardsMockDataSourceHash() =>
    r'e5bd2906d3cbabe6a52b1c0e75abd01eddbcab5d';
