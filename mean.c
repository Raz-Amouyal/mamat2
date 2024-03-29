#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXGRADE 100
#define MINGRADE 0

void operate(FILE *f);

int main(int argc, char *argv[]) {
    FILE *f;

    if (argc == 1 || !strcmp("-", argv[1])) {
        f = stdin;
    } else {
        f = fopen(argv[1], "r");
    }
    if (!f) {
        fprintf(stderr, "File not found: \"%s\"\n", argv[1]);
        return 1;
    }

    operate(f);
}

void operate(FILE *f){
    int grade;
    int retval;
    double avg = 0;
    int line_n = 0;


    while (1){
        retval = fscanf(f, "%d", &grade);
        if (retval == EOF) {
            break;
        } else if (retval != 1) {
            fprintf(stderr, "Error not a number");
            exit(1);
        }
        line_n++;
        if (grade<MINGRADE || grade>MAXGRADE) {
            fprintf(stderr, "Error at line %d: grade %d invalid", line_n, grade);
            exit (1);
        }
        avg += grade;
    }
    printf("%.2f", avg / line_n);
}


