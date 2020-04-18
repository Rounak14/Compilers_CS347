sql:	sql.l sql.y list.c comparator.c
		bison -d sql.y
		flex sql.l
		gcc -o $@ sql.tab.c lex.yy.c list.c comparator.c -lfl -g

clean:	sql sql.tab.c sql.tab.h lex.yy.c
		rm sql sql.tab.c sql.tab.h lex.yy.c
