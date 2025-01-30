%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "final.tab.h"

    extern int line_number;  // Use the line counter from the lexer
    extern int yylex();
    
    void yyerror(const char *s);
%}

%left '<' '>'
%left T_EQ
%nonassoc T_IF
%nonassoc T_ELSE

%token T_INT T_ID T_NUM T_IF T_ELSE T_FOR T_WHILE T_DO T_CONTINUE T_BREAK T_RETURN T_SWITCH T_CASE T_EQ T_NL

%%

program:
    statements { printf("Valid Syntax\n"); }
    ;

statements:
    statements statement
    | statement
    ;

statement:
    declaration ';'
    | assignment ';'
    | array_declaration ';'
    | array_assignment ';'
    | if_statement
    | loop_statement
    | return_statement ';'
    | switch_statement
    | ';'   /* empty statement */
    ;

declaration:
    T_INT T_ID
    | T_INT T_ID '=' expression
    ;

array_declaration:
    T_INT T_ID '[' T_NUM ']'
    | T_INT T_ID '[' T_NUM ']' '=' '{' array_elements '}'
    ;

array_elements:
    array_elements ',' T_NUM
    | T_NUM
    ;

assignment:
    T_ID '=' expression
    ;

array_assignment:
    T_ID '[' T_NUM ']' '=' expression
    ;

expression:
    T_NUM
    | T_ID
    | T_ID '[' T_NUM ']'
    | expression '>' expression
    | expression '<' expression
    | expression T_EQ expression
    | '(' expression ')'
    ;

if_statement:
    T_IF '(' expression ')' '{' statements '}'
    | T_IF '(' expression ')' '{' statements '}' T_ELSE '{' statements '}' %prec T_ELSE
    ;

loop_statement:
    T_FOR '(' assignment ';' expression ';' assignment ')' '{' statements '}'
    | T_WHILE '(' expression ')' '{' statements '}'
    | T_DO '{' statements '}' T_WHILE '(' expression ')' ';'
    ;

return_statement:
    T_RETURN expression
    ;

switch_statement:
    T_SWITCH '(' expression ')' '{' case_statements '}'
    ;

case_statements:
    case_statements case_statement
    | case_statement
    ;

case_statement:
    T_CASE T_NUM ':' statements T_BREAK ';'
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error at line %d: %s\n", line_number, s);
}

int main() {
    printf("Enter your code (Ctrl+D to stop):\n");
    yyparse();
    return 0;
}
