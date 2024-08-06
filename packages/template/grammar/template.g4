// Grammar for template engine
//
// Copyright (c) 2024 Lasan Nishshanka
// All rights reserved
//
// Use of this source code is governed by certain licenses that can
// be found in the license file at the project root

// Note:
//
// This grammar is intended solely for validation purposes and is not designed for use in a real parser. It is meant
// to validate the structure of the template engine. Additionally, this grammar includes only the template engine; any
// code outside the template engine should be manually ignored.
//
// Templates can be defined using the "{{" and "}}" symbol sets within HTML, CSS, or JavaScript code.

grammar template;

// Syntactical grammar

htmlDocument: documentContent? EOF;
documentContent: ( htmlElement | templateBlock )* ;
htmlElement: '<!-- -->' ;
templateBlock: preprocessor | topStatement ;
preprocessor: SYMBOL_AT preprocessorType ;
preprocessorType: importPreprocessor | componentPreprocessor ;
importPreprocessor: KEYWORD_IMPORT idList ;
componentPreprocessor: KEYWORD_COMPONENT idList ;
topStatement: printStatement | ifStatement | loopStatement ;
printStatement: KEYWORD_PRINT idList ;
ifStatement: ifPart elseIfPart* elsePart? ;
ifPart: KEYWORD_IF conditionalExpression block ;
elseIfPart: KEYWORD_ELSE ifPart ;
elsePart: KEYWORD_ELSE block ;
loopStatement: KEYWORD_LOOP block ;
block: SYMBOL_OPEN_BRACE documentContent SYMBOL_CLOSE_BRACE ;
conditionalExpression: IDENTIFIER ( '==' | '!=' | '<' | '<=' | '>' | '>=' ) expressionValue ;
expressionValue: IDENTIFIER | NUMBER | STRING | KEYWORD_TRUE | KEYWORD_FALSE | KEYWORD_NULL | KEYWORD_UNDEFINED ;
idList: IDENTIFIER ( SYMBOL_DOT IDENTIFIER )* ;

// Lexical grammar

KEYWORD_COMPONENT: 'component' ;
KEYWORD_ELSE: 'else' ;
KEYWORD_FALSE: 'false' ;
KEYWORD_IF: 'if' ;
KEYWORD_IMPORT: 'import' ;
KEYWORD_LOOP: 'loop' ;
KEYWORD_NULL: 'null' ;
KEYWORD_PRINT: 'print' ;
KEYWORD_TRUE: 'true' ;
KEYWORD_UNDEFINED: 'undefined' ;

SYMBOL_OPEN_BRACE: '{' ;
SYMBOL_CLOSE_BRACE: '}' ;
SYMBOL_DOT: '.' ;
SYMBOL_AT: '@' ;

IDENTIFIER: IDENTIFIER_START IDENTIFIER_END* ;
fragment IDENTIFIER_START: [a-zA-Z_] ;
fragment IDENTIFIER_END: [a-zA-Z_0-9] ;

WHITESPACE: WHITESPACE_CHARACTER -> channel(HIDDEN) ;
fragment WHITESPACE_CHARACTER: ' ' | '\t' ;

NEW_LINE: NEW_LINE_CHARACTER -> channel(HIDDEN) ;
fragment NEW_LINE_CHARACTER: '\r\n' | '\r' | '\n' ;

NUMBER: DIGIT+ ;
fragment DIGIT: [0-9] ;

STRING: '"' ( ~['"'] )* '"' ;
