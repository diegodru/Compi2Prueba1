%{
#include <stdio.h>
#include <stdlib.h>


extern FILE *yyin;
extern int yylex();
extern char *yytext;
extern int yyerror(char *s){

}
%}

%union{
bool boolean_t;
int int_t;
}

%token<int_t> NUM
%token<boolean_t> BOOL

%token EOL
%token ADD SUB MUL DIV
%token LT GT LTE GTE EQ

%%

prog: 
    | prog exp EOL
    ;

exp: relational_exp
   | arithmetic_exp
   | err 
   ;

arithmetic_exp: NUM
              | NUM ADD NUM
              | NUM SUB NUM
              | NUM MUL NUM
              | NUM DIV NUM
              ;

relational_exp: BOOL
              | BOOL EQ relational_exp
              | arithmetic_exp EQ arithmetic_exp
              | arithmetic_exp GT arithmetic_exp
              | arithmetic_exp GTE arithmetic_exp
              | arithmetic_exp LT arithmetic_exp
              | arithmetic_exp LTE arithmetic_exp
              ;

err: BOOL EQ arithmetic_exp { fprintf(stderr, "No se puede comparar un bool con una expresion numerica\n"); }
     | BOOL ADD exp { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | BOOL SUB exp { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | BOOL MUL exp { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | BOOL DIV exp { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | BOOL GT exp { fprintf(stderr, "No se puede comparar con un > utilizando un booleano\n"); }
     | BOOL GTE exp { fprintf(stderr, "No se puede comparar con un >= utilizando un booleano\n"); }
     | BOOL LT exp { fprintf(stderr, "No se puede comparar con un > utilizando un booleano\n"); }
     | BOOL LTE exp { fprintf(stderr, "No se puede comparar con un >= utilizando un booleano\n"); }
     | arithmetic_exp EQ BOOL { fprintf(stderr, "No se puede comparar un bool con una expresion numerica\n"); }
     | NUM ADD BOOL { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | NUM SUB BOOL { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | NUM MUL BOOL { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | NUM DIV BOOL { fprintf(stderr, "No se puede utilizar un booleano en una operacion aritmetica\n"); }
     | NUM GT BOOL { fprintf(stderr, "No se puede comparar con un > utilizando un booleano\n"); }
     | NUM GTE BOOL { fprintf(stderr, "No se puede comparar con un >= utilizando un booleano\n"); }
     | NUM LT BOOL { fprintf(stderr, "No se puede comparar con un > utilizando un booleano\n"); }
     | NUM LTE BOOL { fprintf(stderr, "No se puede comparar con un >= utilizando un booleano\n"); }
     ;

%%

int main(int argc, char *argv[]){
  if(argc == 2) {
    if((yyin = fopen(argv[1], "r")) == NULL)
      exit(1);
  }
  yyparse();
  return 0;
}
