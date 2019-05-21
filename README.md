# Markdown

<p>
    <img src="https://img.shields.io/badge/Swift-5.0-ff69b4.svg" />
    <img src="https://img.shields.io/badge/macOS-10.12+-brightgreen.svg" />
    <img src="https://img.shields.io/badge/Linux-Compatible-orange.svg" />   
    <a href="https://twitter.com/twostraws">
        <img src="https://img.shields.io/badge/Contact-@twostraws-lightgrey.svg?style=flat" alt="Twitter: @twostraws" />
    </a>
</p>

This provides fast and simple Markdown support for Swift, compatible with both macOS and Linux. It wraps the C Discount library, which does almost all the work.


## Installation

If you’re running macOS you should install the `discount` library like this:

    brew install discount

If you’re using Linux you should install the `libmarkdown2-dev` package like this:

    sudo apt-get install libmarkdown2-dev

Finally, add this package to your Package.swift file like this:

```swift
.package(url: "https://github.com/twostraws/Markdown.git", .upToNextMinor(from: "1.0.0"))
```

Depending on your system configuration you may need to specify a linker flag for the Markdown library. For example:

    swift build -Xlinker -L/usr/local/lib


## Parsing Markdown in a string

You can parse a document by creating a `Markdown` instance from a Swift string, like this:

```swift
if let md = Markdown(string: "# Headline Text") {
    print(md.html)
}
```

That will print the following HTML:

```html
<h1>Headline Text</h1>
```

When creating your Markdown instance you can pass in an option set of configuration options:

* `.none`: The standard set of Markdown-processing options; used by default.
* `.allowMarkdownInsideHTML`: Enables processing of Markdown tags even when inside HTML.
* `.automaticallyCreateLinks`: Enables detection of links even when they are outside angle brackets.
* `.cData`: Adds ![CDATA[...]] blocks as needed.
* `.createSafeLinks`: Enables a paranoid check for link protocols.
* `.disableAlphanumericLists`: Forbids alphanumeric lists.
* `.disableDefinitionList`: Forbids definition lists.
* `.disableHTML`: Forbids any sort of raw HTML at all.
* `.disableImages`: Blocks all image tags.
* `.disableLinks`: Blocks all anchor tags.
* `.disableSmartFormatting`: Disables converting smart quotes, em dashes, ellipses, and more.
* `.disableStrikethrough`: Forbids strikethrough using tildes.
* `.disableSuperscript`: Forbids using A^2 to get superscript.
* `.disableTables`: Disables support for PHP Markdown's table syntax
* `.enableFencedCode`: Enable support for Github-style fenced code blocks, e.g. ```swift.
* `.enableMarkdownExtraFootnotes`: Enables support for PHP Markdown Extra's footnotes
* `.expandSpacesToTabs`: Expands all tabs to four spaces
* `.generateTableOfContents`: Enables generation of table of contents. This is a required option if you intend to read the `tableOfContents` property of the processed Markdown document.

For example:

```swift
let md = Markdown(string: "# Heading 1", options: .enableFencedCode)
```


## Reading document metadata

If you created your document using the `.generateTableOfContents` option, then you can also extract a table of contents for your document like this:

```swift
if let md = Markdown(string: "# Heading 1\nHello, world!", options: .generateTableOfContents) {
    print(md.tableOfContents)
}
```

The output from that will be:

```
<ul>
 <li><a href=\"#Heading-1\">Heading 1</a></li>
</ul>
```

If your Markdown document includes inline `<style>` tags, you can read those through its `css` property, like this:

```swift
if let md = Markdown(string: "<style> body { margin: 0; } </style>\n# Hello, world!") {
    print(md.css)
}
```

The output from that will be:

```
<style> body { margin: 0; } </style>
```

If your document has Pandoc-style metadata at the start, you can read this using the `title`, `author`, and `date` properties of your Markdown document, all of which are optional strings. This means the first three lines of your document start like this:

    % Your Document Title
    % Author Name(s)
    % Whatever Date You Want

For example:

```swift
let metadataExample = """
% Pride and Prejudice
% Jane Austen
% 28th January 1813
    
It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.
"""

let md = Markdown(string: metadataExample)
            
print("Title: ", md?.title ?? "Unknown title")
print("Author: ", md?.author ?? "Unknown author")
print("Date: ", md?.date ?? "Unknown author")
```

The output from that will be:

    Title: Pride and Prejudice
    Author: Jane Austen
    Date: 28th January 1813


## License

This package is released under the MIT License, which is copied below.

Copyright (c) 2019 Paul Hudson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
