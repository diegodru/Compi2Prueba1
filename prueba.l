%{
#include <stdio.h>
#include <stdlib.h>

%}

%option noyywrap

%%

[0-9]+ { return NUM; }
"true" { return BOOL; }
"false" { return BOOL; }
"+" { return ADD; }
"-" { return SUB; } 
"*" { return MUL; }
"/" { return DIV; }
"<" { return LT; }
">" { return GT; } 
">=" { return GTE; }
"<=" { return LTE; }
"==" { return EQ; }

"\n" { return EOL; }
[\r \t] { }
. { fprintf(stderr, "El input %s no es parte del lenguage\n", yytext); exit(1); }

%%
