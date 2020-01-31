#include "lex.h"
#include <stdio.h>
#include <ctype.h>


char* yytext = ""; /* Lexeme (not '\0'
                      terminated)              */
int yyleng   = 0;  /* Lexeme length.           */
int yylineno = 0;  /* Input line number        */

int lex(void){

   static char input_buffer[1024]= "a+b*c+d";
   char        *current;

   current = yytext + yyleng; /* Skip current
                                 lexeme        */

   while(1){       /* Get the next one         */
      while(!*current ){
         /* Get new lines, skipping any leading
         * white space on the line,
         * until a nonblank line is found.
         */

         current = input_buffer;
         if(!gets(input_buffer)){
            *current = '\0' ;

            return EOI;
         }
         ++yylineno;
         while(isspace(*current))
            ++current;
      }
      for(; *current; ++current){
         /* Get the next token */
         yytext = current;
         yyleng = 1;
         switch( *current ){
           case ';':
            return SEMI;
           case ':':
            return COL;
           case '+':
            return PLUS;
           case '-':
            return MINUS;
           case '*':
            return TIMES;
           case '/':
            return DIV;
           case '=':
            return EQUAL;
           case '<':
            return LT;
           case '>':
            return GT;
           case '(':
            return LP;
           case ')':
            return RP;
           case '\n':
           case '\t':
           case ' ' :
            break;
           default:
            if(!isalnum(*current))
               fprintf(stderr, "Not alphanumeric <%c>\n", *current);
            else{
               char str[10];
               int i = 0;
               while(isalnum(*current)){
                  if(i < 9){
                    str[i] = *current;
                    i++;
                  }
                  else str[0] = '\0';
                  ++current;
               }
               str[i] = '\0';
               yyleng = current - yytext;

               if(strcmp(str,"if") == 0){
                  return IF;
               }
               else if(strcmp(str,"then") == 0){
                  return THEN;
               }
               else if(strcmp(str,"while") == 0){
                  return WHILE;
               }
               else if(strcmp(str,"do") == 0){
                  return DO;
               }
               else if(strcmp(str,"begin") == 0){
                  return BEGIN;
               }
               else if(strcmp(str,"end") == 0){
                  return END;
               }
               else if(str[0]>='a' && str[0]<='z' || str[0]>='A' && str[0]<='Z')
                {
                  return ID;
                }
              else
               return NUM_OR_ID;
            }
            break;
         }
      }
   }
}


static int Lookahead = -1; /* Lookahead token  */

int match(int token){
   /* Return true if "token" matches the
      current lookahead symbol.                */

   if(Lookahead == -1)
      Lookahead = lex();

   return token == Lookahead;
}

void advance(void){
/* Advance the lookahead to the next
   input symbol.                               */

    Lookahead = lex();
}
