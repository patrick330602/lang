%{
#include <iostream>
using namespace std;

int no_lines = 0;
int counter = 0;
%}

%option noyywrap
DIGIT	[0-9]
NZDIGIT	[1-9]
WORD	[a-zA-Z]
KEYWORD	("if"|"then"|"else"|"while"|"end"|"func"|"print")
HEXN	[ABCDEF0-9]


%%

\#.+\n																						{ no_lines++; }
[ \t]																						;
\n																							{ no_lines++; }
[\+-]?{DIGIT}+																			{cout << "#" << counter << ": TOKEN: INTCONST   LEXEME: " << yytext << endl;counter++;}
([\+-]?{DIGIT}+|0)\.({DIGIT}+)															{cout << "#" << counter << ": TOKEN: DECCONST   LEXEME: " << yytext << endl;counter++;}
([\+-]?{DIGIT}+|0)\.({DIGIT}*)E([\+-]?{DIGIT}+)											{cout << "#" << counter << ": TOKEN: SCICONST   LEXEME: " << yytext << endl;counter++;}
{HEXN}+H																					{cout << "#" << counter << ": TOKEN: HEXCONST   LEXEME: " << yytext << endl;counter++;}
[01]+B																						{cout << "#" << counter << ": TOKEN: BINCONST   LEXEME: " << yytext << endl;counter++;}
(\({DIGIT}{3}\){DIGIT}{3}\-{DIGIT}{4})|((({DIGIT}{3}\.){2}|({DIGIT}{3}\-){2}){DIGIT}{4})	{cout << "#" << counter << ": TOKEN: PHCONST    LEXEME: " << yytext << endl;counter++;}
{KEYWORD}																					{cout << "#" << counter << ": TOKEN: KEYWORD    LEXEME: " << yytext << endl;counter++;}
{WORD}({WORD}|{DIGIT})*																		{cout << "#" << counter << ": TOKEN: IDENT      LEXEME: " << yytext << endl;counter++;}
\"({WORD}|{DIGIT}|[ \t])+\"																	{cout << "#" << counter << ": TOKEN: STRCONST   LEXEME: " << yytext << endl;counter++;}
[\+\-\*/<>=]																				{cout << "#" << counter << ": TOKEN: OPERATOR   LEXEME: " << yytext << endl;counter++;}
.																							{cout << "#" << counter << ": TOKEN: ?          LEXEME: " << yytext << endl;counter++;}

%%

int main()
{
    yylex();
    cout << no_lines << " lines processed." << endl;
    return 0;
}
