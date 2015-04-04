/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     LT = 258,
     GT = 259,
     AMP = 260,
     LPAREN = 261,
     RPAREN = 262,
     BAR = 263,
     DOT = 264,
     QUOTE = 265,
     SETENV = 266,
     UNSETENV = 267,
     PRINTENV = 268,
     CD = 269,
     BYE = 270,
     ALIAS = 271,
     UNALIAS = 272,
     PWD = 273,
     LS = 274,
     WORD = 275
   };
#endif
/* Tokens.  */
#define LT 258
#define GT 259
#define AMP 260
#define LPAREN 261
#define RPAREN 262
#define BAR 263
#define DOT 264
#define QUOTE 265
#define SETENV 266
#define UNSETENV 267
#define PRINTENV 268
#define CD 269
#define BYE 270
#define ALIAS 271
#define UNALIAS 272
#define PWD 273
#define LS 274
#define WORD 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 24 "parser.y"
{
	int i;
	char* sval;
}
/* Line 1529 of yacc.c.  */
#line 94 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

