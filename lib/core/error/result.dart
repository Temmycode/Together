import 'package:flutter/foundation.dart';

/// The typed outcome of an operation that can fail in an *expected* way.
///
/// Repositories return `Future<Result<T>>` so that expected domain failures
/// (offline, 404, validation, …) are values you branch on — not exceptions
/// that escape to the UI. Pattern-match with a Dart 3 `switch`:
///
/// ```dart
/// switch (result) {
///   Ok(:final value) => use(value),
///   Err(:final failure) => show(failure.message),
/// }
/// ```
///
/// At the presentation edge a controller may instead unwrap an [Err] and
/// `throw` its [Failure] so it surfaces through Riverpod's `AsyncValue` — see
/// `PostsController` for that bridge.
@immutable
sealed class Result<T> {
  const Result();

  /// Whether this is an [Ok].
  bool get isOk => this is Ok<T>;

  /// Whether this is an [Err].
  bool get isErr => this is Err<T>;
}

/// A successful [Result] carrying [value].
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

/// A failed [Result] carrying a [Failure].
final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}

/// Ergonomic helpers for consuming a [Result] without an explicit `switch`.
extension ResultX<T> on Result<T> {
  /// Exhaustively fold both branches into a single value.
  R when<R>({
    required R Function(T value) ok,
    required R Function(Failure failure) err,
  }) => switch (this) {
    Ok(:final value) => ok(value),
    Err(:final failure) => err(failure),
  };

  /// The success value, or `null` when this is an [Err].
  T? get valueOrNull => switch (this) {
    Ok(:final value) => value,
    Err() => null,
  };

  /// The failure, or `null` when this is an [Ok].
  Failure? get failureOrNull => switch (this) {
    Ok() => null,
    Err(:final failure) => failure,
  };

  /// The success value, or [orElse] computed from the failure.
  T getOrElse(T Function(Failure failure) orElse) => switch (this) {
    Ok(:final value) => value,
    Err(:final failure) => orElse(failure),
  };

  /// Transform the success value, preserving any [Err] unchanged.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok(:final value) => Ok(transform(value)),
    Err(:final failure) => Err(failure),
  };
}

/// The closed set of failures the app knows how to present.
///
/// Adding a variant forces every exhaustive `switch` over [Failure] to handle
/// it — that compile-time pressure is the point of the sealed hierarchy.
/// Implements [Exception] so a controller can `throw` it across the
/// `AsyncValue` boundary (see `PostsController`).
@immutable
sealed class Failure implements Exception {
  const Failure(this.message);

  /// A human-readable, UI-safe description of what went wrong.
  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

/// No connectivity, the request never reached the server, or it timed out.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

/// The server was reached but responded with an error status.
final class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Server error. Please try again.',
    this.statusCode,
  ]);

  final int? statusCode;
}

/// Reading or writing local storage failed.
final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Could not read local data.']);
}

/// Client-side validation rejected the input before any request was made.
final class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Please check your input.']);
}

/// The session is missing or expired (HTTP 401/403).
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Your session has expired. Please sign in again.',
  ]);
}

/// A failure that does not fit any other variant.
final class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'Something went wrong. Please try again.',
  ]);
}
