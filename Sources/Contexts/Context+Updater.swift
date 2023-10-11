extension Context {
    /// A type for updating dependencies in ``Context``.
    ///
    /// Dependencies are updated with value provided to
    /// ``Update`` action at the property key path
    /// provided to this type.
    ///
    /// Additionally, this type also allows input
    /// transformation of base context to an updated
    /// context.
    ///
    /// This type also allows chaining dependencies
    /// updates.
    @dynamicMemberLookup
    public struct Updater {
        /// The base context containing
        /// custom dependencies.
        ///
        /// Creates updated context from
        /// this base context with updated
        /// dependencies.
        fileprivate var context: Context

        /// Creates a new context updater with
        /// provided base context.
        ///
        /// All the dependencies update are done
        /// on top of provided context.
        ///
        /// - Parameter context: The base context.
        /// - Returns: Created context updater.
        internal init(context: Context) {
            self.context = context
        }

        /// Creates a new updated context with the transformed input.
        ///
        /// The `transform` action is used to create the transformed
        /// input for updated context.
        ///
        /// - Parameter transform: A closure accepting base context
        ///   as its parameter and returns a transformed input value
        ///   for the updated context.
        /// - Returns: Updated context.
        public func transformInput(_ transform: (Context) -> Input) -> Context {
            return self.input(transform(self.context))
        }

        /// Creates context updater with a new updated context as
        /// base context with the transformed input.
        ///
        /// The `transform` action is used to create the transformed
        /// input for updated context.
        ///
        /// - Parameter transform: A closure accepting base context
        ///   as its parameter and returns a transformed input value
        ///   for the updated context.
        /// - Returns: Context updater with updated base context.
        @_disfavoredOverload
        public func transformInput(_ transform: (Context) -> Input) -> Self {
            return self.input(transform(self.context))
        }

        /// Manages dependency update for provided property
        /// key path.
        ///
        /// The update action returned can be used to update
        /// dependency value for the provided key path.
        ///
        /// - Parameter keyPath: Dependency property key path.
        /// - Returns: Dependency update action.
        public subscript<T>(
            dynamicMember keyPath: KeyPath<Context, T>
        ) -> Update<T> {
            return .init(context: context, keyPath: keyPath)
        }
    }

    /// A type for updating dependency at specific
    /// key path in ``Context``.
    ///
    /// Dependencies are updated with value provided
    /// to this type at the property key path provided
    /// to the ``Updater``.
    ///
    /// This type also allows chaining dependency
    /// updates.
    public struct Update<T> {
        /// The base context containing
        /// custom dependencies.
        ///
        /// Creates updated context from
        /// this base context with updated
        /// dependency.
        private let context: Context
        /// The dependency property key path.
        ///
        /// The dependency value at this path is
        /// updated in the updated context.
        private let keyPath: KeyPath<Context, T>

        /// Creates a new context update action with provided
        /// base context and dependency property key path.
        ///
        /// The value at property key path is updated for the
        /// provided context.
        ///
        /// - Parameters:
        ///   - context: The base context.
        ///   - keyPath: The dependency property key path.
        ///
        /// - Returns: Created context update action.
        fileprivate init(
            context: Context,
            keyPath: KeyPath<Context, T>
        ) {
            self.context = context
            self.keyPath = keyPath
        }

        /// Creates a new updated context with the provided
        /// dependency value.
        ///
        /// The dependency value is updated at current
        /// dependency property key path.
        ///
        /// - Parameter value: The updated dependency value.
        /// - Returns: Updated context.
        public func callAsFunction(_ value: T? = nil) -> Context {
            var context = self.context
            context[keyPath] = value
            return context
        }

        /// Creates context updater with a new updated context
        /// as base context with the provided dependency value.
        ///
        /// The dependency value is updated at current
        /// dependency property key path.
        ///
        /// - Parameter value: The updated dependency value.
        /// - Returns: Context updater with updated base context.
        @_disfavoredOverload
        public func callAsFunction(_ value: T? = nil) -> Updater {
            var context = self.context
            context[keyPath] = value
            return .init(context: context)
        }
    }
}
