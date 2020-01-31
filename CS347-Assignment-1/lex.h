#define EOI		   0	/* End of input			*/
#define SEMI		 1	/* ;				*/
#define COL		   2	/* : 				*/
#define PLUS 	 	 3	/* + 				*/
#define MINUS		 4	/* - 				*/
#define TIMES		 5	/* * 				*/
#define DIV		   6	/* / 				*/
#define EQUAL		 7	/* = 				*/
#define LT		   8	/* < 				*/
#define GT		   9	/* > 				*/
#define LP		  10	/* (				*/
#define RP		  11	/* )				*/
#define IF		  12	/* if 				*/
#define THEN		13	/* then 				*/
#define WHILE		14	/* while 				*/
#define DO		  15	/* do 				*/
#define BEGIN		16	/* begin 				*/
#define END		  17	/* end 				*/
#define ID		  18	/* id 				*/
#define NUM_OR_ID	19	/* Decimal Number or Identifier */

extern char *yytext;		/* in lex.c			*/
extern int yyleng;
extern yylineno;
