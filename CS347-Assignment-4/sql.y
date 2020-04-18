%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "csvread.c"

extern int yylex();
extern int yyparse();
extern int yylineno;
int yylinenumber;
extern char* yytext;
extern int yyleng;
void yyerror(char* s);
char list[100][100];
int vals;
%}

%code requires {
    #include "comparator.h"
}

%union {
    int intValue;
    char text[100];
    struct {
        char *name;
    } name;
    struct AND_entry AND_ent;
    struct AND_list list_of_AND;
    struct OR_list list_of_OR;
    struct {
        char* table;
        char* col;
    } colAttribute;

    struct {
        int type;
    } op;
}

/* declare tokens */
%token SELECT PROJECT CARTESIAN_PRODUCT EQUI_JOIN
%token AND OR NOT
%token LP RP LT GT EQUAL NOT_EQUAL LE GE
%token INT QUOTED_STRING ID
%token DOT COMMA NEWLINE

%type <list_of_OR> condition
%type <list_of_AND> cond2
%type <AND_ent> expr
%type <name> attribute
%type <op> op
%type <colAttribute> col
%type <intValue> INT;
%type <text> ID;
%type <text> QUOTED_STRING;


%%
stmt_list: stmt NEWLINE stmt_list
    | stmt
    | error NEWLINE {printf("error: syntax error in line number %d\n",yylineno-1);
        printf("================================\n\n");
    } stmt_list
;

stmt:  SELECT LT  GT LP ID RP
    {
        yylinenumber = yylineno;
        char fname[200];
        memset(fname,0,200);
        sprintf(fname,"input/%s.csv",$5);
        if(checkTableName($5)==0){
            printf("Table %s not found!\n",$5);
        }
        else{
            FILE* file = fopen(fname,"r");
            char str[1000];
            fgets(str, 1000, file);
            printf("%s", str);
            fgets(str, 1000, file);
            OR_list condition;
            condition.head = condition.end = NULL;
            int numOfRecords = 0;
            while (fgets(str, 1000, file)) {
                sscanf(str, "%[^\n]", str);
                int returnResult = selectComputeCondition(condition, str, $5);
                if (returnResult == -1){
                    break;
                }
                else if (returnResult)  {
                    printf("%s\n", str);
                    numOfRecords++;
                }
            }
            printf("Number of Records found : %d\n", numOfRecords);
            fclose(file);
        }
        printf("================================\n\n");
    }
    |SELECT LT condition GT LP ID RP
    {
        yylinenumber = yylineno;
        // print_list($3);
        // populate($6);
        char fname[200];
        memset(fname,0,200);
        sprintf(fname,"input/%s.csv",$6);
        if(checkTableName($6)==0){
            printf("Table %s not found!\n",$6);
        }
        else{
            FILE* file = fopen(fname,"r");
            char str[1000];
            fgets(str, 1000, file);
            printf("%s", str);
            fgets(str, 1000, file);
            // printf("%s", str);
            int numOfRecords = 0;
            while (fgets(str, 1000, file)) {
                sscanf(str, "%[^\n]", str);
                int returnResult = selectComputeCondition($3, str, $6);
                if (returnResult == -1){
                    break;
                }
                else if (returnResult)  {
                    numOfRecords++;
                    printf("%s\n", str);
                }
            }

            printf("Number of Records found : %d\n", numOfRecords);
            fclose(file);
        }
        printf("================================\n\n");
    }
    | PROJECT LT attr_list GT LP ID RP
    {
        yylinenumber = yylineno;
        if (!checkTableName($6)) {
            fprintf(stdout, "Table %s not found\n", $6);
        }
        else {
            printColumns(list, vals, $6);
        }
        printf("================================\n\n");
    }
    | LP ID RP CARTESIAN_PRODUCT LP ID RP
    {
        yylinenumber = yylineno;
        // printf("hello %s %s\n", $2, $6);
        printCartesianProducts($2, $6);
        printf("================================\n\n");
    }
    | LP ID RP EQUI_JOIN LT condition GT LP ID RP
    {
        yylinenumber = yylineno;
        int numOfRecords=0;
         // check if the two table id's exist
        if (!checkTableName($2)) {
            fprintf(stdout, "Table %s not present\n", $2);
        }
        else if (!checkTableName($9)) {
            fprintf(stdout, "Table %s not present\n", $9);
        }
        else {
            // check for each condition unit.table1/2 is set and same as above id's, datatype
            int x = associateTable($2, $9, &($6));
            if (x == 1) {
                numOfRecords = printEquiJoin($2, $9, &($6));
            }
            printf("Number of Records found : %d\n", numOfRecords);
        }
        printf("================================\n\n");
    }
    | %empty
;

attr_list: attribute COMMA attr_list
    {
        sprintf(list[vals], "%s", $1.name);
        vals++;
    }
    | attribute
    {
        memset(list, 0, 10000);
        vals = 0;
        sprintf(list[0], "%s", $1.name);
        // printf("added column name 1 - : %s\n", list[0]);
        vals++;
    }
;


condition: cond2 OR condition
    {
        $$ = join_OR_list($3, $1);
    }
    | cond2
    {
        $$.end = malloc(sizeof(AND_list));
        $$.head = $$.end;
        memcpy($$.head, &$1, sizeof (AND_list));
        // printf("col name ---- 2 --- : %s\n", $1.head->col1);
        // printf("col name ---- 2 --- : %s\n", $1.head->col2);
    }
;

cond2: expr AND cond2
    {
        $$ = join_AND_list($3, $1);
    }
    | expr
    {

        $$.end = malloc(sizeof(AND_entry));
        $$.head = $$.end;
        $$.next_ptr = NULL;
        memcpy($$.head, &$1, sizeof (AND_entry));
        // printf("col name ---- 1 --- : %s\n", $$.head->col1);
        // printf("col name ---- 1 --- : %s\n", $$.head->col2);
    }
;

expr: col op col
    {
        if($1.table==NULL){ $$.table1 = $1.table; }
        else { $$.table1 = malloc(100); memset($$.table1, 0, 100); sprintf($$.table1, "%s", $1.table);}
        if($3.table==NULL){ $$.table2 = $3.table; }
        else { $$.table2 = malloc(100); memset($$.table2, 0, 100); sprintf($$.table2, "%s", $3.table);}
        $$.col1 = malloc(100);  memset($$.col1, 0, 100);
        $$.col2 = malloc(100);  memset($$.col2, 0, 100);
        sprintf($$.col1, "%s", $1.col);
        sprintf($$.col2, "%s", $3.col);
        $$.operation = $2.type;
        $$.int1_fnd = 0;
        $$.int2_fnd = 0;
        $$.str1 = NULL;
        $$.str2 = NULL;
        $$.next_ptr = NULL;
        $$.not_var = 0;
        $$.is_cond = 0;
        $$.nest_condition = NULL;
    }
    | col op INT
    {
        // printf("int val : %d\n", $3);
        if($1.table==NULL){ $$.table1 = $1.table; }
        else { $$.table1 = malloc(100); memset($$.table1, 0, 100); sprintf($$.table1, "%s", $1.table);}
        $$.table2 = NULL;
        $$.col1 = malloc(100);  memset($$.col1, 0, 100);
        $$.col2 = NULL;
        sprintf($$.col1, "%s", $1.col);
        $$.operation = $2.type;
        $$.int1_fnd = 0;
        $$.int2_fnd = 1;
        $$.val2 = $3;
        $$.str1 = NULL;
        $$.str2 = NULL;
        $$.next_ptr = NULL;
        $$.not_var = 0;
        $$.is_cond = 0;
        $$.nest_condition = NULL;
    }
    | INT op col
    {
        if($3.table==NULL){ $$.table1 = $3.table; }
        else { $$.table1 = malloc(100); memset($$.table1, 0, 100); sprintf($$.table1, "%s", $3.table);}
        $$.table2 = NULL;
        $$.col1 = malloc(100);  memset($$.col1, 0, 100);
        $$.col2 = NULL;
        sprintf($$.col1, "%s", $3.col);
        $$.operation = complement($2.type);
        $$.int1_fnd = 0;
        $$.int2_fnd = 1;
        $$.val2 = $1;
        $$.str1 = NULL;
        $$.str2 = NULL;
        $$.next_ptr = NULL;
        $$.not_var = 0;
        $$.is_cond = 0;
        $$.nest_condition = NULL;
    }
    | col op QUOTED_STRING
    {
        if($1.table==NULL){ $$.table1 = $1.table; }
        else { $$.table1 = malloc(100); memset($$.table1, 0, 100); sprintf($$.table1, "%s", $1.table);}
        $$.table2 = NULL;
        $$.col1 = malloc(100);  memset($$.col1, 0, 100);
        $$.col2 = NULL;
        sprintf($$.col1, "%s", $1.col);
        $$.operation = $2.type;
        $$.int1_fnd = 0;
        $$.int2_fnd = 0;
        $$.str1 = NULL;
        $$.str2 = malloc(100); memset($$.str2, 0, 100);
        sprintf($$.str2, "%s", $3);
        $$.next_ptr = NULL;
        $$.is_cond = 0;
        $$.not_var = 0;
        $$.nest_condition = NULL;
        // printf("%s %s\n", $$.col1, $$.str1);
    }
    | QUOTED_STRING op col
    {
        if($3.table==NULL){ $$.table1 = $3.table; }
        else { $$.table1 = malloc(100); memset($$.table1, 0, 100); sprintf($$.table1, "%s", $3.table);}
        $$.table2 = NULL;
        $$.col1 = malloc(100);  memset($$.col1, 0, 100);
        $$.col2 = NULL;
        sprintf($$.col1, "%s", $3.col);
        $$.operation = complement($2.type);
        $$.int1_fnd = 0;
        $$.int2_fnd = 0;
        $$.str1 = NULL;
        $$.str2 = malloc(100); memset($$.str2, 0, 100);
        sprintf($$.str2, "%s", $1);
        $$.next_ptr = NULL;
        $$.is_cond = 0;
        $$.not_var = 0;
        $$.nest_condition = NULL;
    }
    | LP condition RP
    {
        $$.table1 = NULL;
        $$.table2 = NULL;
        $$.col1 = NULL;
        $$.col2 = NULL;
        $$.operation = 0;
        $$.int1_fnd = 0;
        $$.int2_fnd = 0;
        $$.str1 = NULL;
        $$.str2 = NULL;
        $$.next_ptr = NULL;
        $$.is_cond = 1;
        $$.not_var = 0;
        $$.nest_condition = malloc(sizeof(OR_list));
        memcpy($$.nest_condition, &$2, sizeof (OR_list));
    }
    | NOT LP condition RP
    {
        $$.table1 = NULL;
        $$.table2 = NULL;
        $$.col1 = NULL;
        $$.col2 = NULL;
        $$.operation = 0;
        $$.int1_fnd = 0;
        $$.int2_fnd = 0;
        $$.str1 = NULL;
        $$.str2 = NULL;
        $$.next_ptr = NULL;
        $$.is_cond = 1;
        $$.not_var = 1;
        $$.nest_condition = malloc(sizeof(OR_list));
        memcpy($$.nest_condition, &$3, sizeof (OR_list));
    }
;

col: ID DOT ID {
        $$.table = malloc(100);
        $$.col = malloc(100);
        memset($$.col, 0, 100);
        memset($$.table, 0, 100);
        sprintf($$.table, "%s", $1);
        sprintf($$.col, "%s", $3);
    }
    | ID  {
        $$.table = NULL;
        $$.col = malloc(100);
        memset($$.col, 0, 100);
        sprintf($$.col, "%s", $1);
    }
;

op: LT {$$.type = 1;}
    | GT {$$.type = 2;}
    | LE {$$.type = 3;}
    | GE {$$.type = 4;}
    | EQUAL {$$.type = 5;}
    | NOT_EQUAL {$$.type = 6;}
;

attribute: ID   {
    $$.name = malloc(100);
    memset($$.name, 0, 100);
    sprintf($$.name, "%s", yytext);
    // printf("column name : %s\n", $$.name);
};

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
