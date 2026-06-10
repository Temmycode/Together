/// Coarse device classes, derived from `shortestSide` so they are
/// rotation-invariant (a phone stays a phone in landscape).
enum DeviceType { phone, tablet, largeTablet }

/// Posture of a foldable's hinge/fold, read from `MediaQuery.displayFeatures`.
///
/// [none] means no fold is present — a regular phone, or *any* iOS device
/// (display features are an Android-only API).
enum FoldPosture { none, flat, halfOpened }
