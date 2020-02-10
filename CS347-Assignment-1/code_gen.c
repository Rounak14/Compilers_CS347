#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include "name.c"
#include "lex.c"

int count=0;

struct identifier
{
    int id;
    char* id_name;
};

char *arr[1000];


void print_id(char * idname )   // Utility funciton to print tokens
{
  int i=0;
  for( i=0; i<count; i++){
    if(!strcmp(idname,arr[i]))
    {
  			printf("<ID, %d>", i+1);

  			return;
  	}
  }
  arr[i]=malloc(sizeof(char)*yyleng);
  strncpy(arr[i],idname,yyleng);
  printf("<ID, %d>", i+1);
  count++;
  return;


}

char *factor(void);
char *term(void);
char *expression(void);
void stmt(void);
char *expr(int);
void stmt_list(void);

extern char *newname(void);
//extern void //freename(char *name);
int assignment_found;

void statements(void)
{
    // statements -> stmt statements | stmt
    while(!match(EOI)){
        // char* tempvar = stmt();
        stmt();
        // //freename(tempvar);
    }
	printf ("\n <EOI> ");
}

void stmt(void)
{
    /* stmt -> id := expr
            | if expr then stmt
            | while expr do stmt
            | begin opt_stmts end */
    char *tempvar, *tempvar2;
    if (match(NUM_OR_ID)|| match(CONST))
    {
	//printf ("<ID,%d> ",ID);
      if(match (CONST)) //printf("<CONST, %0.*s> ", yyleng, yytext);
        printf("<CONST, %s>", idname);
      else
       print_id(idname);

	advance();
        if (match(ASSIGN))
        {
	    printf ("<:=> ");
            char *var = malloc(yyleng + 1);
            strncpy(var, idname, yyleng);
            advance();
            assignment_found = 1;
            tempvar = expr(0);
            /*if(!match(SEMI)){
                fprintf( stderr, "%d: Inserting missing semicolon\n", yylineno );
            }*/

	    if(match(SEMI))
                printf("<;>" );

            advance();
            //printf("%s := %s\n", var, tempvar);
            //freename(tempvar);
        }
    }
    else if (match(IF))
    {
	printf ("<IF> ");
        advance();
        tempvar = expr(1);
        //freename(tempvar);
        if (match(THEN))
        {
             printf("<THEN> ");
            advance();
            stmt();
            // tempvar2 = stmt();
            //printf("}\n");
        }
       /* else
        {
            fprintf(stderr, "error!!");
        }*/
    }
    else if (match(WHILE))
    {
	printf ("<WHILE> ");
        advance();
        tempvar = expr(2);
        //freename(tempvar);
        if (match(DO))
        {
	    printf ("<DO> ");
            advance();
            // tempvar2 = stmt();
            stmt();
           // printf("}\n");
        }
        /*else
        {
            fprintf(stderr, "error!!");
        }*/

        // tempvar2 = stmt();
    }
    else if (match(BEGIN))
    {
	printf ("<BEGIN> ");
        advance();
        stmt_list();
    }
    // return tempvar;
    // //freename(tempvar);

}

void stmt_list(void)
{
    /* stmt_list -> stmt stmt_list'
       stmt_list' -> stmt stmt_list' |  epsilon */

    char *tempvar, *tempvar2;
    // tempvar = stmt();
    while (!match(END))
    {
        // printf("stmt caught\n");
        stmt();
        // tempvar = stmt();
        // //freename(tempvar);
    }
    printf ("<END> ");
    advance();
    // assert(match(END));
    // //freename(tempvar);
    return;
}

char *expr(int flag)
{
    /*expr -> expression GREAT expression
            | expression LESS expression
            | expression EQUAL expression
            | expression */

    // printf("aaya\n");
    char *tempvar, *tempvar2;
    tempvar = expression();
    // printf("comparing\n");
    if (match(GREAT))
    {
	printf ("<>> ");
        advance();
        tempvar2 = expression();
        // printf("    %s -= %s\n", tempvar, tempvar2);

	/* if (flag == 1)  printf("if (%s > %s) {\n", tempvar, tempvar2);
        else if (flag == 2) printf("while (%s > %s) {\n", tempvar, tempvar2);
        else if (flag == 0) printf("%s > %s\n", tempvar, tempvar2);
	*/

        if(assignment_found){
            assignment_found = 0;
        }
        //freename(tempvar2);
    }
    else if (match(LESS))
    {
	printf ("<<> ");
        advance();
        tempvar2 = expression();
        // printf("    %s -= %s\n", tempvar, tempvar2);
        /*
	if (flag == 1)  printf("if (%s < %s) {\n", tempvar, tempvar2);
        else if (flag == 2) printf("while (%s < %s) {\n", tempvar, tempvar2);
        else if (flag == 0) printf("%s < %s\n", tempvar, tempvar2);
	*/
        if(assignment_found){
            assignment_found = 0;
        }
        //freename(tempvar2);
    }
    else if (match(EQUAL))
    {
	printf ("<=> ");
        advance();
        tempvar2 = expression();
        // printf("    %s -= %s\n", tempvar, tempvar2);

	/*
	 if (flag == 1)  printf("if (%s == %s) {\n", tempvar, tempvar2);
        else if (flag == 2) printf("while (%s == %s) {\n", tempvar, tempvar2);
        else if (flag == 0) printf("%s == %s\n", tempvar, tempvar2);
	*/

        if(assignment_found){
            assignment_found = 0;
        }
        //freename(tempvar2);
    }
   /* else {
        if (flag == 1)  printf("if (%s) {\n", tempvar);
        else if (flag == 2) printf("while (%s) {\n", tempvar);
        // else if (flag == 0) printf("%s > %s\n", tempvar, tempvar2);
        // printf("(%s)\n", tempvar);
    }
	*/
    return tempvar;
}

char *expression()
{
    /* expression -> term expression'
     * expression' -> PLUS term expression' |  epsilon
     */

    char *tempvar, *tempvar2;

    tempvar = term();

    while (match(PLUS) || match(MINUS))
    {

        int type;
        if(match(PLUS)) {
	printf("<+> ");
            type = PLUS;
        }
        else {
	printf("<-> ");
            type = MINUS;
        }
        advance();
        tempvar2 = term();
       /*
	 if(type == PLUS) {
            printf("%s += %s\n", tempvar, tempvar2);
        }
        else{
            printf("    %s -= %s\n", tempvar, tempvar2);
        }
	*/

        //freename(tempvar2);
    }
    // while( match(PLUS)){
    //     advance();
    //     tempvar2 =term();
    //     printf("   %s += %s\n", tempvar, tempvar2 );
    //     //freename( tempvar2 );
    // }

    return tempvar;
}

char *term()
{
    char *tempvar, *tempvar2;

    tempvar = factor();
    while (match(TIMES) || match(DIVIDE))
    {
        int type;
        if(match(TIMES)) {
	printf("<*> ");
            type = TIMES;
        }
        else {
	printf("</> ");
            type = DIVIDE;
        }
        advance();
        tempvar2 = factor();
	/*
        if(type == TIMES){
            printf("%s *= %s\n", tempvar, tempvar2);
        }
        else{
            printf("%s /= %s\n", tempvar, tempvar2);
        }
	*/
        //freename(tempvar2);
    }

    return tempvar;
}

char *factor()
{
    char *tempvar;

    if (match(NUM_OR_ID)||match(CONST))
    {
      if(match (CONST)) printf("<CONST, %s>", idname);
      else
	     print_id(idname);


        /* Print the assignment instruction. The %0.*s conversion is a form of
	 * %X.Ys, where X is the field width and Y is the maximum number of
	 * characters that will be printed (even if the string is longer). I'm
	 * using the %0.*s to print the string because it's not \0 terminated.
	 * The field has a default width of 0, but it will grow the size needed
	 * to print the string. The ".*" tells printf() to take the maximum-
	 * number-of-characters count from the next argument (yyleng).
	 */


	// printf("%s = %0.*s\n", tempvar = newname(), yyleng, yytext);
        advance();
    }
    else if (match(LP))
    {
      printf("<(> ");
        advance();
        tempvar = expression();
        if (match(RP)){
		printf("<)> ");
		advance();
	}

       /* else
            fprintf(stderr, "%d: Mismatched parenthesis\n", yylineno);
    }
    else{

        fprintf(stderr, "%d: Number or identifier expected\n", yylineno);
   */
   }
    return tempvar;
}
