#if swift(>=5.9) && canImport(ContextsMacroPlugin)
/// Indicates the property is a dependency in ``Context``.
///
/// Can be used to extend ``Context`` with new dependencies:
///
/// ```swift
/// extension Context {
///   @ContextKey
///   var clock: Clock?
///
///   // ...
/// }
/// ```
///
/// will expand to:
///
/// ```swift
/// extension Context {
///   var clock: Clock? {
///     get { self[\.clock] ?? nil }
///     set { self[\.clock] = newValue }
///.  }
///
///   // ...
/// }
/// ```
///
/// - Important: The property type must be an optional type.
@attached(accessor)
@available(swift 5.9)
public macro ContextKey() =
    #externalMacro(module: "ContextsMacroPlugin", type: "ContextKey")

/// Indicates the property is a dependency in ``Context``
/// with provided default value.
///
/// Can be used to extend ``Context`` with new dependencies:
///
/// ```swift
/// extension Context {
///   @ContextKey(Clock.continuous)
///   var clock: Clock
///
///   // ...
/// }
/// ```
///
/// will expand to:
///
/// ```swift
/// extension Context {
///   var clock: Clock {
///     get { self[\.clock] ?? .continuous }
///     set { self[\.clock] = newValue }
///.  }
///
///   // ...
/// }
/// ```
///
/// - Parameter defaultValue: The default value for the dependency.
///
/// - Important: The `defaultValue` type `T` must be the same
///   as property type.
@attached(accessor)
@available(swift 5.9)
public macro ContextKey<T>(_ defaultValue: T) =
    #externalMacro(module: "ContextsMacroPlugin", type: "ContextKey")
#endif
