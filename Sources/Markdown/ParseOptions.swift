import Foundation
import Discount

/// An OptionSet of configuration options that can be used to parse a document.
public struct ParseOptions: OptionSet {
    public let rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// The standard set of Markdown-processing options; used by default.
    public static let none = ParseOptions(rawValue: 0)

    /// Enables processing of Markdown tags even when inside HTML.
    public static let allowMarkdownInsideHTML = ParseOptions(rawValue: UInt32(MKD_TAGTEXT))

    /// Enables detection of links even when they are outside angle brackets.
    public static let automaticallyCreateLinks = ParseOptions(rawValue: UInt32(MKD_AUTOLINK))

    /// Adds ![CDATA[...]] blocks as needed.
    public static let cData = ParseOptions(rawValue: UInt32(MKD_CDATA))

    /// Enables a paranoid check for link protocols.
    public static let createSafeLinks = ParseOptions(rawValue: UInt32(MKD_SAFELINK))

    /// Forbids alphanumeric lists.
    public static let disableAlphanumericLists = ParseOptions(rawValue: UInt32(MKD_NOALPHALIST))

    /// Forbids definition lists.
    public static let disableDefinitionList = ParseOptions(rawValue: UInt32(MKD_NODLIST))

    /// Forbids any sort of raw HTML at all.
    public static let disableHTML = ParseOptions(rawValue: UInt32(MKD_NOHTML))

    /// Blocks all <img> tags.
    public static let disableImages = ParseOptions(rawValue: UInt32(MKD_NOIMAGE))

    /// Blocks all <a> tags.
    public static let disableLinks = ParseOptions(rawValue: UInt32(MKD_NOLINKS))

    /// Disables converting smart quotes, em dashes, ellipses, and more.
    public static let disableSmartFormatting = ParseOptions(rawValue: UInt32(MKD_NOPANTS))

    /// Forbids ~~strikethrough~~.
    public static let disableStrikethrough = ParseOptions(rawValue: UInt32(MKD_NOSTRIKETHROUGH))

    /// Forbids using A^2 to get superscript.
    public static let disableSuperscript = ParseOptions(rawValue: UInt32(MKD_NOSUPERSCRIPT))

    /// Disables support for PHP Markdown's table syntax.
    public static let disableTables = ParseOptions(rawValue: UInt32(MKD_NOTABLES))

    /// Enable support for Github-style fenced code blocks, e.g. ```swift.
    public static let enableFencedCode = ParseOptions(rawValue: UInt32(MKD_FENCEDCODE))

    /// Enables support for PHP Markdown Extra's footnotes.
    public static let enableMarkdownExtraFootnotes = ParseOptions(rawValue: UInt32(MKD_EXTRA_FOOTNOTE))

    /// Expands all tabs to four spaces.
    public static let expandSpacesToTabs = ParseOptions(rawValue: UInt32(MKD_TABSTOP))

    /// Enables generation of table of contents. This is a required option if you intend to read the `tableOfContents` property of the processed Markdown document.
    public static let generateTableOfContents = ParseOptions(rawValue: UInt32(MKD_TOC))
}
