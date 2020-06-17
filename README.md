# Compiler
A very simple compiler written in Turbo Pascal for x86. This exercise is coming from Jack Crenshaw's "Compiler Building Tutorial" (PDF available [here](https://www.stack.nl/~marcov/compiler.pdf))

### Example usage:
`./compile.sh` (input: `2+(-1+5)*1`)

`./final` (output: `6`)


### To Do:

- [x] Cradle (basic procedures for reading in characters)
- [ ] Parsing:
  * [x]  Binary Expressions
  * [x]  General Expressions
  * [ ]  Multiplication/division (fix x86 output for division)
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
