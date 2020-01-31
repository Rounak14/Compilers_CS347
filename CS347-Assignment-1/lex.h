#define EOI		       0	/* End of input			*/
#define SEMI		     1	/* ; 				*/
#define PLUS 	       2	/* + 				*/
#define TIMES		     3	/* * 				*/
#define LP		       4	/* (				*/
#define RP		       5	/* )				*/
#define NUM_OR_ID	   6	/* Decimal Number or Identifier */
#define DIV          7
#define MINUS        8
#define IF           9
#define THEN        10
#define ELSE        11
#define WHILE       12
#define DO          13
#define FOR         14
#define LT 		      15   /* less than  */
#define GT 		      16   /* greater than */
#define EQUAL 			17   /* equal  */
#define BEGIN 		  18   /* begin */
#define END			    19   /* end		*/
#define ID 			    20   /* Identifier	*/
#define COL         21   /*   ; 	*/


extern char *yytext;		/* in lex.c			*/
extern int yyleng;
extern yylineno;
