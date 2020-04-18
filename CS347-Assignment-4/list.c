#include "list.h"

AND_list join_AND_list(struct AND_list cond2, struct AND_entry expr){
    AND_entry* new_elem = malloc(sizeof(AND_entry));
    memcpy(new_elem, &expr, sizeof (AND_entry));
    cond2.end->next_ptr = new_elem;
    cond2.end = new_elem;
    return cond2;
}

OR_list join_OR_list(struct OR_list condition, struct AND_list cond2){
    AND_list* new_elem = malloc(sizeof(AND_list));
    memcpy(new_elem, &cond2, sizeof (AND_list));
    condition.end->next_ptr = new_elem;
    condition.end = new_elem;
    return condition;
}

void print_list(struct OR_list condition){
    AND_list* temp = condition.head;
    while(temp!=NULL){
        AND_entry* temp2 = temp->head;
        while(temp2!=NULL){
            if(temp2->col1!=NULL){
                printf("%s ; ", temp2->col1);
            } else {
                printf("%s ; ", temp2->col2);
            }
            temp2 = temp2->next_ptr;

        }
        printf("\n");
        temp = temp->next_ptr;
    }
}
