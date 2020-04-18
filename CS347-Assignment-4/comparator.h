#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"


extern int yylinenumber;
int complement(int);
int getColumnIndex(char *, char *);
char *retval(char *, int);
char *getType(char *, int);
int selectComparator(struct AND_entry, char *, char *);
int selectComputeCondition(struct OR_list, char *, char *);
int equiComparator(struct AND_entry, char *, char *, char *, char *);
int equiComputeCondition(struct OR_list, char *, char *, char *, char *);
int associateTable(char *, char *, struct OR_list *);
int printEquiJoin(char *, char *, struct OR_list *);
