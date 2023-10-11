import SwiftCompilerPlugin
import SwiftSyntaxMacros

/// The compiler plugin that exposes all the macro type defined.
///
/// New macro types should be added to `providingMacros`
/// array.
@main
struct ContextsPlugin: CompilerPlugin {
    /// All the macros provided by this macro plugin.
    ///
    /// New macro types should be added here.
    let providingMacros: [Macro.Type] = [ContextKey.self]
}
