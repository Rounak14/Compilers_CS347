%{

#include<stdlib.h>
#include<stdio.h>
#include<string.h>
void comments_removal(FILE* source, FILE* destination);
int total_line_count = 0;
int blanklines_source_code=0;
int total_comment=0;
int total_macros=0;
int no_of_variables = 0;
int no_of_dec = 1;
int no_of_def = 1;


%}


%option noyywrap
%x S1 S2 S3 X1 X2 X3
%%

"/*"                  BEGIN(S2);
<S2>[^*\n]            ;
<S2>"*"               BEGIN(S3);
<S2>"\n"              {total_comment++; total_line_count++;}
<S3>"*"               ;
<S3>[^*/]             BEGIN(S2);
<S3>"/"               {BEGIN(INITIAL);total_comment++;}

^[ \t]*"//"[^\n]*\n   {total_comment++; total_line_count++;}
"//"[^\n]*            {total_comment++;}
"#define"[^\n]*\n     {total_macros++;total_line_count++;}


^[ \t]*[\nEOF]        {++blanklines_source_code; total_line_count++; printf(" blank lines %s",yytext);}
[\n]                  {total_line_count++; printf(" nonblank lines %s",yytext);}

%%


void main(int argc, char **argv){
    argv++;
    argc--;
    if(argc == 0){
        printf("Supply file name\n");
        exit(0);
    }
    FILE* file_ptr = fopen(argv[0], "r");
    if(file_ptr == NULL){
        printf("File not found!\n");
        exit(0);
    }
    /* fclose(file_ptr); */ no_of_variables++;
    /*FILE* file_inter = fopen("intermediate.txt", "w");*/
    //comments_removal(file_ptr, file_inter);
  /*  fclose(file_inter);*/ no_of_variables++;
  //  fclose(file_ptr);

  // file_ptr = fopen("intermediate.txt", "r");
    /* yyin = fopen(argv[0], "r" );*/ no_of_def++;
    yyin = file_ptr;
    yylex();
  //  increase_counts();
   printf("\nNumber of lines  : %d\n", total_line_count);
   printf("Number of blank lines : %d\n", blanklines_source_code);
   printf("Number of commented lines : %d\n", total_comment);
   printf("Number of Macro lines : %d\n", total_macros);
   printf("Number of function definations : %d\n", no_of_def);
   printf("Number of function declaration : %d\n", no_of_dec);
   printf("Number of variables : %d\n", no_of_variables);

}
