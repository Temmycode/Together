import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/error/result.dart';

void main() {
  group('Result', () {
    test('Ok carries its value and reports isOk', () {
      const result = Ok<int>(42);
      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
      expect(result.valueOrNull, 42);
      expect(result.failureOrNull, isNull);
    });

    test('Err carries its failure and reports isErr', () {
      const result = Err<int>(NetworkFailure());
      expect(result.isErr, isTrue);
      expect(result.valueOrNull, isNull);
      expect(result.failureOrNull, isA<NetworkFailure>());
    });

    test('when folds both branches', () {
      const Result<int> ok = Ok(10);
      const Result<int> err = Err(ServerFailure('boom', 500));

      expect(ok.when(ok: (v) => 'v$v', err: (f) => 'e'), 'v10');
      expect(err.when(ok: (v) => 'v$v', err: (f) => f.message), 'boom');
    });

    test('map transforms Ok and preserves Err', () {
      const Result<int> ok = Ok(2);
      const Result<int> err = Err(CacheFailure());
      expect(ok.map((v) => v * 5).valueOrNull, 10);
      expect(err.map((v) => v * 5).failureOrNull, isA<CacheFailure>());
    });

    test('getOrElse returns the fallback on Err', () {
      const Result<int> err = Err(UnknownFailure());
      expect(err.getOrElse((_) => -1), -1);
    });
  });
}
