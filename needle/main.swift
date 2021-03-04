import SwiftSyntax
import Foundation

// I want to inject some code after the func decl
class Needle: SyntaxRewriter {
    override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        var modified = node
        let newCall = SyntaxFactory.makeFunctionCallExpr(
            calledExpression: ExprSyntax(SyntaxFactory.makeIdentifierExpr(
                                            identifier:
                                                SyntaxFactory.makeIdentifier("Debug.debug")
                                                .withLeadingTrivia([ .newlines(1), .spaces(2)]),
                                            declNameArguments: nil)),
            leftParen: SyntaxFactory.makeLeftParenToken(),
            argumentList: SyntaxFactory.makeTupleExprElementList([]),
            rightParen: SyntaxFactory.makeRightParenToken().withTrailingTrivia([.newlines(1), .spaces(0)]),
            trailingClosure: nil,
            additionalTrailingClosures: nil)
        
        let newStatement = SyntaxFactory.makeCodeBlockItem(
            item: Syntax(newCall),
            semicolon: nil,
            errorTokens: nil)
        
        
        modified.body?.statements = node.body!.statements.prepending(newStatement)
        return DeclSyntax(modified)
    }
}

let file = "/Users/momo/projects/needle/test/momo.swift"
let url = URL(fileURLWithPath: file)
let sourceFile = try SyntaxParser.parse(url)
let injected = Needle().visit(sourceFile)

print(injected)
