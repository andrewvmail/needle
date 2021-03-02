import SwiftSyntax
import Foundation

// I want to inject some code after the func decl
class Needle: SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> Syntax {
    print(token)
    return Syntax(token)
  }
}

let file = "/Users/momo/Desktop/momo.swift"
let url = URL(fileURLWithPath: file)
let sourceFile = try SyntaxParser.parse(url)
let incremented = Needle().visit(sourceFile)

print("hi")
