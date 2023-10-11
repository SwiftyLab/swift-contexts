#if swift(>=5.9) && canImport(ContextsMacroPlugin)
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacrosTestSupport
import XCTest

@testable import ContextsMacroPlugin

final class ContextKeyMacroTests: XCTestCase {
    func testNonOptionalPropertyExpansion() {
        assertMacroExpansion(
            """
            extension Context {
                @ContextKey(20)
                var width: Int
            }
            """,
            expandedSource:
                """
                extension Context {
                    var width: Int {
                        get {
                            self [\\.width] ?? 20
                        }
                        set {
                            self [\\.width] = newValue
                        }
                    }
                }
                """
        )
    }

    func testOptionalPropertyExpansion() {
        assertMacroExpansion(
            """
            extension Context {
                @ContextKey
                var width: Int?
            }
            """,
            expandedSource:
                """
                extension Context {
                    var width: Int? {
                        get {
                            self [\\.width] ?? nil
                        }
                        set {
                            self [\\.width] = newValue
                        }
                    }
                }
                """
        )
    }
}

func assertMacroExpansion(
    _ originalSource: String,
    expandedSource: String,
    diagnostics: [DiagnosticSpec] = [],
    testModuleName: String = "TestModule",
    testFileName: String = "test.swift",
    indentationWidth: Trivia = .spaces(4),
    file: StaticString = #file,
    line: UInt = #line
) {
    assertMacroExpansion(
        originalSource, expandedSource: expandedSource,
        diagnostics: diagnostics,
        macros: ["ContextKey": ContextKey.self],
        testModuleName: testModuleName, testFileName: testFileName,
        indentationWidth: indentationWidth,
        file: file, line: line
    )
}
#endif
