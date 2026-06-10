# together

A Flutter application scaffold built on **Riverpod (code-generated)**, a **neat take on clean architecture**, and a **custom responsive layer** that adapts across phone, tablet/iPad, and foldables — no responsive package required.

---

## Philosophy — the "neat" clean architecture

This avoids the boilerplate-heavy clean-architecture template most projects use. The deliberate cuts:

- **No use-case classes.** Riverpod controllers call repository *interfaces* directly. Add a use-case only when real business logic warrants it.
- **DI is just providers** (`riverpod_generator`). No service locator, no `get_it`, no manual wiring.
- **`AsyncValue` is the only UI state channel.** Repositories return `Future<Result<T>>` (typed failures as values); controllers unwrap and re-throw the `Failure` so it lands in `AsyncError`. The UI does one `.when(data / loading / error)` — never a `Result` nested inside an `AsyncValue`.
- **`freezed` + `json_serializable`** remove model boilerplate (`copyWith` / `==` / `fromJson`).
- **Custom sealed `Result` / `Failure`** — Dart 3 sealed classes + pattern matching, zero dependency.
- **Reactive `SizeConfig`** computed from `MediaQuery` each build (correct after rotate / fold / resize) — not a stale `init(context)` singleton.

## Project structure (feature-first)

```
lib/
├── app/              # bootstrap() + root TogetherApp widget
├── core/
│   ├── config/       # AppConfig + flavor + provider
│   ├── error/        # sealed Result<T> / Failure + exception → Failure mapper
│   ├── network/      # Dio provider + interceptors (logging, auth)
│   ├── storage/      # KeyValueStore interface + SharedPreferences impl
│   ├── logging/      # custom AppLogger
│   ├── responsive/   # SizeConfig, ResponsiveLayout, TwoPane, context extensions
│   ├── router/       # go_router provider + route constants
│   ├── theme/        # Material 3 light/dark + persisted theme mode
│   └── widgets/      # shared widgets (AppLoader, AppErrorView)
└── features/
    └── posts/        # sample feature, wired end-to-end
        ├── data/         # dtos, datasources, repository impls
        ├── domain/       # entities, repository interfaces
        └── presentation/ # controllers, screens, widgets
```

## Tech stack

| Concern | Package | Notes |
|---|---|---|
| State management | `flutter_riverpod` + `riverpod_generator` | Versions are pinned together — see the note in `pubspec.yaml`. |
| Navigation | `go_router` | Provider in `core/router/app_router.dart`. |
| Networking | `dio` | Single client built from the active flavor's base URL. |
| Local storage | `shared_preferences` | Behind the `KeyValueStore` interface. |
| Models | `freezed` + `json_serializable` | Code-generated. |
| Responsive | **custom** | `core/responsive/` — no package. |

## Running (flavors)

The flavor is chosen by the entrypoint (Dart-level flavors via `AppConfig`):

```bash
flutter run                          # defaults to dev (lib/main.dart)
flutter run -t lib/main_dev.dart     # dev
flutter run -t lib/main_staging.dart # staging
flutter run -t lib/main_prod.dart    # prod
```

VS Code launch configs for all three are in `.vscode/launch.json`. The dev flavor points at `https://jsonplaceholder.typicode.com`, so the sample Posts feature works out of the box.

## Code generation

Providers, freezed models, and JSON live in `*.g.dart` / `*.freezed.dart`. Regenerate after editing any `@riverpod` / `@freezed` file:

```bash
dart run build_runner build       # one-off
dart run build_runner watch       # during development
```

## Responsive layer (`SizeConfig`)

Use the `BuildContext` extensions for proportional sizing, and `ResponsiveLayout` / `TwoPane` for structure:

```dart
Padding(padding: EdgeInsets.all(context.w(16)))   // proportional width
SizedBox(height: context.h(12))                    // proportional height
Text('Hi', style: TextStyle(fontSize: context.sp(16)))

ResponsiveLayout(
  phone: (_) => const _SingleColumn(),
  tablet: (_) => const _TwoPane(),   // falls back to phone if omitted
);
```

- Device class is decided by `shortestSide` (rotation-invariant): phone `< 600`, tablet `600–900`, largeTablet `≥ 900`.
- `context.sizeConfig` exposes fold posture / hinge bounds (Android foldables); `TwoPane` lays panes around the crease.
- Global user text-scaling is clamped (0.85–1.3) in `app/app.dart` so accessibility settings never break layouts.

## Adding a feature

Copy the shape of `features/posts/`:

1. **domain/entities/** — a `freezed` entity (pure).
2. **domain/repositories/** — an `abstract interface class` returning `Future<Result<T>>`.
3. **data/dtos/** — a `freezed` + `json_serializable` DTO with a `toDomain()` mapper.
4. **data/datasources/** — a class taking `Dio`, plus a `@riverpod` provider.
5. **data/repositories/** — the impl (maps exceptions via `mapErrorToFailure`), plus a `@riverpod` provider returning the interface.
6. **presentation/controllers/** — a `@riverpod` (Async)Notifier; unwrap the `Result`, re-throw the `Failure`.
7. **presentation/screens & widgets/** — `ConsumerWidget`s that `.when(...)` over the controller and lay out with `ResponsiveLayout`.

Run `build_runner`, add a route in `core/router/`, and you're done — no use-case or DI boilerplate.

## Testing

```bash
flutter analyze
flutter test
```

Included tests cover the `Result` type, the `SizeConfig` math/breakpoints, the controller's Result→AsyncValue bridge, and phone/tablet rendering of `PostsScreen`.
# Together
