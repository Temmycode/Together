import 'package:flutter/material.dart';

/// A neutral fill shown while a network image loads or when it fails.
///
/// Keeps tile/card geometry stable regardless of image state, and (crucially)
/// gives every `Image.network` an `errorBuilder` so widget tests don't fail on
/// the stubbed test HTTP client.
class NetworkImagePlaceholder extends StatelessWidget {
  const NetworkImagePlaceholder({super.key, this.broken = false});

  final bool broken;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          broken ? Icons.image_not_supported_outlined : Icons.image_outlined,
          color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

/// `Image.network` with the loading/error placeholders wired in. Single seam so
/// every image in the feature behaves (and tests) the same way.
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({super.key, required this.url, this.fit = BoxFit.cover});

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : const NetworkImagePlaceholder(),
      errorBuilder: (context, error, stackTrace) =>
          const NetworkImagePlaceholder(broken: true),
    );
  }
}
