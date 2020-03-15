sql:	sql.l sql.y
		bison -d sql.y
		flex sql.l
		gcc -o $@ sql.tab.c lex.yy.c -lfl
		
clean:	sql sql.tab.c sql.tab.h lex.yy.c
		rm sql sql.tab.c sql.tab.h lex.yy.c
