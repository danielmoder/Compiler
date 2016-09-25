# Compiler
A very simple compiler (in progress) written in Turbo Pascal, x86

Working through Jack Crenshaw's "Compiler Building Tutorial" (2012)

- [x] Cradle (basic procedures for reading in characters)
- [x]  Parsing:
  * [x]  Binary Expressions
  * [x]  General Expressions
  * [x]  Multiplication/division
  * [x]  Handling parentheses
  * [x]  Unary minus
- [ ]  More Expressions:
  * [ ]  Variables
  * [ ]  Functions
  * [ ]  Assignment statements
  * [ ]  Multi-character tokens
  * [ ]  White space
- [ ]  Control Constructs
  * [ ]  If
  * [ ]  While
  * [ ] Loop
  * [ ] Repeat-until
  * [ ]  For
  * [ ]  Do
  * [ ]  Break  
- [ ]  Boolean Expressions
- [ ]  Lexical Scanning
... more to come

       
*Parser grammar:*
> digit       ::= [0..9]

> AddOp       ::= [+|-]

> MultOp      ::= [*|/]

> Factor      ::= -?[digit|(Expression)]

> Term        ::= Factor [MultOp Factor]*

> Expression  ::= Term [AddOp Term]*
