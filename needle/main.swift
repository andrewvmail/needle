import SwiftSyntax
import Foundation

// I want to inject some code after the func decl
class Needle: SyntaxRewriter {
    override func visit(_ token: TokenSyntax) -> Syntax {
        return Syntax(token)
    }
    
    override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        print("***************FunctionDeclSyntax*********** VVVVV")
        print(node)
        print("***************FunctionDeclSyntax*********** ^^^^^^")
        return DeclSyntax(node)
    }
}

let file = "/Users/momo/Desktop/momo.swift"
let url = URL(fileURLWithPath: file)
let sourceFile = try SyntaxParser.parse(url)
let incremented = Needle().visit(sourceFile)
