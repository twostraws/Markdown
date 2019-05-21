import Discount

/// Stores the compiled Markdown for a string. This must be a class because it has a custom deinitializer to release the underlying memory.
public class Markdown {
    /// The internal Discount memory for this Markdown string.
    private let internalData: UnsafeMutableRawPointer

    /// Tracks whether the document was created with a table of contents.
    private let includesTableOfContents: Bool

    /// Creates a new instance from a raw Swift string, backed up by any Markdown options you want to provide.
    public init?(string: String, options: ParseOptions = .none) {
        internalData = mkd_string(string, Int32(string.count), 0)
        let result = mkd_compile(internalData, options.rawValue)

        // mkd_compile() returns zero or a negative number if something went wrong; we map that to a failed initialization
        if result <= 0 {
            return nil
        }

        if options.contains(.generateTableOfContents) {
            includesTableOfContents = true
        } else {
            includesTableOfContents = false
        }
    }

    /// Automatically frees the underlying Markdown memory when this object is destroyed.
    deinit {
        mkd_cleanup(internalData)
    }

    /// Designed to call one of Discount's Markdown functions, then map the resulting memory to a Swift string.
    private func string(from markdownFunction: (UnsafeMutableRawPointer, UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>) -> Int32) -> String {
        var output: [UnsafeMutablePointer<Int8>?] = [nil]
        let result = markdownFunction(internalData, &output)

        // If this operation failed for some reason, send back an empty string
        guard result >= 0 else { return "" }
        guard let data = output[0] else { return "" }

        return String(cString: data)
    }

    /// Returns the document author if set. To set the document author, the first three lines of your document must start with %, with line one being "% Your Document Title", line two being "% Author Name(s)", and line three must be "% Whatever Date You Want".
    public var author: String? {
        if let author = mkd_doc_author(internalData) {
            return String(cString: author)
        } else {
            return nil
        }
    }

    /// Returns any <style> blocks that were found in the document.
    public var css: String {
        return string(from: mkd_css)
    }

    /// Returns the document date if set. To set the document date, the first three lines of your document must start with %, with line one being "% Your Document Title", line two being "% Author Name(s)", and line three must be "% Whatever Date You Want".
    public var date: String? {
        if let date = mkd_doc_date(internalData) {
            return String(cString: date)
        } else {
            return nil
        }
    }

    /// Returns the converted HTML for this Markdown.
    public var html: String {
        return string(from: mkd_document)
    }

    /// Returns the table of contents for this document. It is a programmer error to read the table of contents without creating the document using the `.generateTableOfContents` option; attempting to do so will print an error and return an empty string.
    public var tableOfContents: String {
        guard includesTableOfContents else {
            print("To read the table of contents you must have provided the .generateTableOfContents option when creating the document.")
            return ""
        }

        return string(from: mkd_toc)
    }

    /// Returns the document title if set. To set the document title, the first three lines of your document must start with %, with line one being "% Your Document Title", line two being "% Author Name(s)", and line three must be "% Whatever Date You Want".
    public var title: String? {
        if let title = mkd_doc_title(internalData) {
            return String(cString: title)
        } else {
            return nil
        }
    }
}
