/// A type for accessing and managing dependencies.
///
/// All dependencies are isolated per instance of this type
/// and this type can be extended adding new dependencies.
///
/// ``ContextKey(_:)`` macro can be used to add new dependencies
///  with default value:
///
/// ```swift
/// extension Context {
///   @ContextKey(Client.shared)
///   var apiClient: Client
///   @ContextKey(Clock.continuous)
///   var clock: Clock
///   @ContextKey(UUID())
///   var uuid: UUID
///
///   // ...
/// }
/// ```
///
/// Or, dependency implementation can be provided manually:
///
/// ```swift
/// extension Context {
///   var apiClient: Client {
///     get { self[\.apiClient] ?? .shared }
///     set { self[\.apiClient] = newValue }
///.  }
///
///   // ...
/// }
/// ```
///
/// In the above examples, default value of dependencies are
/// provided statically.Additionally, this type accepts input
/// that can be used to set dependencies default value dynamically:
///
/// ```swift
/// let context = Context(input: apiClient)
/// // access by context.input
/// ```
///
/// Dependencies can also be overridden in a new context with DSL
/// provided by this library:
///
/// ```swift
/// let newContext = context.with
///                      .apiClient(newClient)
///                      .clock(.suspending)
/// // use newContext as overridden context
/// ```
public struct Context<Input> {
    /// The updater that can be used to update dependency.
    ///
    /// The updater creates new ``Context`` from the current
    /// instance's and provided dependencies.
    public var with: Updater { .init(context: self) }
    /// The dependencies storage.
    ///
    /// Dependencies associated with this instance
    /// are stored in this.
    private var storage: [PartialKeyPath<Self>: Any] = [:]

    /// The input provided during initialization.
    ///
    /// Uses as default value of `Input` dependency.
    private let _input: Input
    /// The current input value.
    ///
    /// Provides the updated input value or the default
    /// input value provided during initialization if
    /// not updated.
    public var input: Input {
        get { storage[\Self.input] as? Input ?? _input }
        set { storage[\Self.input] = newValue }
    }

    /// Creates a new context with provided input.
    ///
    /// All the dependencies are reset to default value
    /// and input reset to provided value.
    ///
    /// - Parameter input: Default input value.
    /// - Returns: Created context.
    public init(input: Input) {
        self._input = input
    }

    /// Manages dependency for provided property key path.
    ///
    /// When trying to set dependency value to `nil`,
    /// dependency value is reset to default.
    ///
    /// - Parameter contextKey: Dependency property key path.
    /// - Returns: Dependency value.
    public subscript<T>(contextKey: KeyPath<Self, T>) -> T? {
        get { storage[contextKey] as? T }
        set {
            guard let newValue = newValue else {
                storage.removeValue(forKey: contextKey)
                return
            }
            storage[contextKey] = newValue
        }
    }
}

extension Context where Input == Void {
    /// Creates a new context with empty input.
    ///
    /// All the dependencies are reset to default value.
    ///
    /// - Returns: Created context.
    public init() {
        self.input = ()
    }
}
