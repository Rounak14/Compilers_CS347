#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct OR_list;

//defination of element of AND/OR list
typedef struct AND_entry{
    char *table1, *table2, *col1, *col2;
    int val1, val2;
    char *str1, *str2;
    int operation, int1_fnd, int2_fnd;
    struct AND_entry* next_ptr;
    int is_cond;
    struct OR_list* nest_condition;
    int not_var;
} AND_entry;

// struct defination of elements for the And list
typedef struct AND_list {
    AND_entry* head;
    AND_entry* end;
    struct AND_list* next_ptr;
} AND_list;

// struct defination of elements for the OR list
typedef struct OR_list {
    AND_list* head;
    AND_list* end;
} OR_list;


AND_list join_AND_list(struct AND_list, struct AND_entry);
OR_list join_OR_list(struct OR_list, struct AND_list);
void print_list(struct OR_list);
