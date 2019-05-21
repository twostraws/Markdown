import XCTest
@testable import Markdown

final class MarkdownTests: XCTestCase {
    func testHTML() {
        guard let md = Markdown(string:"# Hello, world!") else {
            XCTFail("Failed to create Markdown document.")
            return
        }

        XCTAssertEqual(md.html, "<h1>Hello, world!</h1>")
    }

    func testMetadata() {
        guard let md = Markdown(string:"% Pride and Prejudice\n% Jane Austen\n% 28th January 1813\n") else {
            XCTFail("Failed to create Markdown document.")
            return
        }

        XCTAssertEqual(md.title, "Pride and Prejudice")
        XCTAssertEqual(md.author, "Jane Austen")
        XCTAssertEqual(md.date, "28th January 1813")
    }

    func testTableOfContents() {
        guard let md = Markdown(string:"# Introduction", options: .generateTableOfContents) else {
            XCTFail("Failed to create Markdown document.")
            return
        }

        XCTAssertEqual(md.html, "<a name=\"Introduction\"></a>\n<h1>Introduction</h1>")
        XCTAssertEqual(md.tableOfContents, "<ul>\n <li><a href=\"#Introduction\">Introduction</a></li>\n</ul>\n")
    }

    func testStyle() {
        guard let md = Markdown(string:"<style> body { margin: 0; }</style>\n# Hello, world!") else {
            XCTFail("Failed to create Markdown document.")
            return
        }

        XCTAssertEqual(md.html, "\n\n<h1>Hello, world!</h1>")
        XCTAssertEqual(md.css, "<style> body { margin: 0; }</style>\n")
    }

    static var allTests = [
        ("testHTML", testHTML),
        ("testMetadata", testMetadata),
        ("testTableOfContents", testTableOfContents),
        ("testStyle", testStyle)
    ]
}
