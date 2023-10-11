import SwiftSyntax
import SwiftSyntaxMacros

/// Describes a macro that adds accessors
/// to dependency property declaration.
///
/// This macro performs accessors macro expansion
/// to add the dependency property declaration
/// to `Context` storage.
struct ContextKey: AccessorMacro {
    /// Expand a macro that's expressed as a custom attribute attached to
    /// the given declaration. The result is a set of accessors for the
    /// declaration.
    ///
    /// - Parameters:
    ///   - node: The custom attribute describing this attached macro.
    ///   - declaration: The declaration this macro attribute is attached to.
    ///   - context: The context in which to perform the macro expansion.
    ///
    /// - Returns: `get` and `set` accessor declarations
    ///   for storing dependency.
    static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        guard
            let varDecl = declaration.as(VariableDeclSyntax.self),
            let binding = varDecl.bindings.first,
            let pattern = binding.pattern.as(IdentifierPatternSyntax.self),
            binding.accessorBlock == nil
        else { return [] }

        let `default` =
            node.arguments?.as(LabeledExprListSyntax.self)?.first?.expression
            ?? "nil"
        return [
            """
            get { self[\\.\(pattern.identifier)] ?? \(`default`) }
            """,
            """
            set { self[\\.\(pattern.identifier)] = newValue }
            """,
        ]
    }
}
