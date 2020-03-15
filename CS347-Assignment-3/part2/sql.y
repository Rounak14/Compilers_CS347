/* simplest version of calculator */
%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern int yylineno;
void yyerror(char* s);
%}

/* declare tokens */
%token SELECT PROJECT CARTESIAN_PRODUCT EQUI_JOIN
%token LP RP LESS_THAN GREATER_THAN EQUAL NOT_EQUAL LESS_EQUAL DOT COMMA AND OR NOT GREATER_EQUAL
%token INTEGER STRING_IN_QUOTES IDENTIFIER
%token NEWLINE

%%
Statement_list: Statement NEWLINE Statement_list
    | Statement
    | error NEWLINE {printf("error: INVALID SYNTAX, syntax error in line number %d\n\n",yylineno-1);} Statement_list
;



Statement: SELECT LESS_THAN Condition_1 GREATER_THAN LP table_name RP       {printf("\nVALID SYNTAX\n");}
    | PROJECT LESS_THAN Attribute_list GREATER_THAN LP table_name RP      {printf("\nVALID SYNTAX\n");}
    | LP table_name RP CARTESIAN_PRODUCT LP table_name RP       {printf("\nVALID SYNTAX\n");}
    | LP table_name RP EQUI_JOIN LESS_THAN Condition_1 GREATER_THAN LP table_name RP       {printf("\nVALID SYNTAX\n");}
    | %empty
;

Attribute_list: Attribute COMMA Attribute_list
    | Attribute

;

Condition_1: Condition_2 OR Condition_1
    | Condition_2

;

Condition_2: Expression AND Condition_2
    | Expression

;

Expression: Column op Column
    | Column op INTEGER
    | INTEGER op Column
    | Column op STRING_IN_QUOTES
    | STRING_IN_QUOTES op Column
    | LP Condition_1 RP
    | NOT LP Condition_1 RP

;

Column: table_name DOT column_name
    | column_name

;

op: LESS_THAN
    | GREATER_THAN
    | LESS_EQUAL
    | GREATER_EQUAL
    | EQUAL
    | NOT_EQUAL

;

table_name: IDENTIFIER
;

column_name: IDENTIFIER
;

Attribute: IDENTIFIER

%%
int main(int argc, char **argv)
{
  yyparse();
}

void yyerror(char *s)
{
    // printf( "error!!: %s at line %d\n", s, yylineno);
    // fflush(stdout);
}
