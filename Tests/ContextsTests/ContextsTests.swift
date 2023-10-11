import Contexts
import XCTest

final class ContextsTests: XCTestCase {
    func testContextCreation() throws {
        let context = Context()
        XCTAssertEqual(context.width, 20)
        XCTAssertEqual(context.title, "title")
    }

    func testContextUpdate() throws {
        let context = Context()
        let newContext = context.with.width(40).title("new title")
        XCTAssertEqual(newContext.width, 40)
        XCTAssertEqual(newContext.title, "new title")
    }

    func testContextReset() throws {
        let context = Context().with.width(40).title("new title")
        let newContext = context.with.width().title()
        XCTAssertEqual(newContext.width, 20)
        XCTAssertEqual(newContext.title, "title")
    }

    func testContextInput() throws {
        let context = Context(input: 5)
        XCTAssertEqual(context.input, 5)
        XCTAssertEqual(context.width, 20)
        XCTAssertEqual(context.title, "title")
        let newContext = context.with
            .input(10)
            .width(40)
            .title("new title")
        XCTAssertEqual(newContext.input, 10)
        XCTAssertEqual(newContext.width, 40)
        XCTAssertEqual(newContext.title, "new title")
    }

    func testContextInputReset() throws {
        let context = Context(input: 5).with
            .input(10)
            .width(40)
            .title("new title")
        XCTAssertEqual(context.input, 10)
        XCTAssertEqual(context.width, 40)
        XCTAssertEqual(context.title, "new title")
        let newContext = context.with.input()
        XCTAssertEqual(newContext.input, 5)
        XCTAssertEqual(newContext.width, 40)
        XCTAssertEqual(newContext.title, "new title")
    }

    func testContextResetAndInputReset() throws {
        let context = Context(input: 5).with
            .input(10)
            .width(40)
            .title("new title")
        XCTAssertEqual(context.input, 10)
        XCTAssertEqual(context.width, 40)
        XCTAssertEqual(context.title, "new title")
        let newContext = context.with.input().width().title()
        XCTAssertEqual(newContext.input, 5)
        XCTAssertEqual(newContext.width, 20)
        XCTAssertEqual(newContext.title, "title")
    }

    func testContextInputTransform() throws {
        let context = Context(input: (5, "some"))
        XCTAssertEqual(context.input.0, 5)
        XCTAssertEqual(context.input.1, "some")
        XCTAssertEqual(context.width, 20)
        XCTAssertEqual(context.title, "title")
        let newContext = context.with
            .transformInput({ return (10, $0.input.1) })
        XCTAssertEqual(newContext.input.0, 10)
        XCTAssertEqual(newContext.input.1, "some")
        XCTAssertEqual(newContext.width, 20)
        XCTAssertEqual(newContext.title, "title")
    }

    func testContextInputTransformAndUpdate() throws {
        let context = Context(input: (5, "some"))
        XCTAssertEqual(context.input.0, 5)
        XCTAssertEqual(context.input.1, "some")
        XCTAssertEqual(context.width, 20)
        XCTAssertEqual(context.title, "title")
        let newContext = context.with
            .transformInput({ return (10, $0.input.1) })
            .width(40)
            .title("new title")
        XCTAssertEqual(newContext.input.0, 10)
        XCTAssertEqual(newContext.input.1, "some")
        XCTAssertEqual(newContext.width, 40)
        XCTAssertEqual(newContext.title, "new title")
    }
}

#if swift(>=5.9) && canImport(ContextsMacroPlugin)
extension Context {
    @ContextKey(20)
    var width: Int

    @ContextKey("title")
    var title: String
}
#else
extension Context {
    var width: Int {
        get { self[\.width] ?? 20 }
        set { self[\.width] = newValue }
    }

    var title: String {
        get { self[\.title] ?? "title" }
        set { self[\.title] = newValue }
    }
}
#endif
