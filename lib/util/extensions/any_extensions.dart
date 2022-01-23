extension AnyExtensions<T> on T {
  T? takeIf(bool Function(T it) block) => block(this) ? this : null;
}
