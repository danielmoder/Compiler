program Cradle;

{Constants}
const TAB = ^I;

{Variables}
var Look : char;


{Read new characters from input stream}
procedure Getchar;
begin
   Read(Look);
end;


{Report error}
procedure Error(s :  string);
begin
   WriteLn;
   WriteLn(^G, 'Error: ', s, '.');
end;

{Report error and halt}
procedure Abort(s : string);
begin
   Error(s);
   Halt;
end;

{Report what was expected}
procedure Expected(s : string);
begin
   Abort(s + ' expected');
end;

{Match an input character}
procedure Match(x : char);
begin
   if Look = x then GetChar
   else Expected ('''' + x + '''');
end;

{Recognize alpha character}
function IsAlpha(c : char): boolean;
begin
   IsAlpha := upcase(c) in ['A'..'Z'];
end;

{Recognize decimal digit}
function IsDigit(c : char): boolean;
begin
   IsDigit := c in ['0'..'9'];
end;

{Get an identifier}
function GetName: char;
begin
   if not IsAlpha(Look) then Expected('Name');
   GetName := UpCase(Look);
   GetChar;
end;

{Get a number}
function GetNum: char;
begin
   if not IsDigit(Look) then Expected('Integer');
   GetNum := Look;
   GetChar;
end;

{Output string w/ tab}
procedure Emit(s : string);
begin
   Write(TAB, s);
end;

{Output string w/ tab and CRLF}
procedure EmitLn(s : string);
begin
   Emit(s);
   WriteLn;
end;


procedure Expression; Forward;

{Parse and translate a math FACTOR}
procedure Factor;
begin
   if Look = '(' then begin
      Match('(');
      Expression;
      Match(')');
      end
   else if Look = '-' then begin
      GetChar;
      EmitLn('movq $' + GetNum + ', %r12');
      EmitLn('neg %r12');
      end
   else
      EmitLn('movq $' + GetNum + ', %r12');
end;

{Recognize and translate *}
procedure Multiply;
begin
   Match('*');
   Factor;
   EmitLn('popq %r13');
   EmitLn('imulq %r13, %r12');
end;

{Recognize and translate /}
procedure Divide;
begin
   Match('/');
   Factor;
   EmitLn('popq %rax');
   EmitLn('cqto');
   EmitLn('idivq %r12');
end;

{Parse and translate a mult. term}
procedure Term;
begin
   Factor;
   while Look in ['*', '/'] do begin
      EmitLn('pushq %r12');
      case Look of
	'*' : Multiply;
	'/' : Divide;
      else Expected('mult. operation');
      end;
   end;
end;


{Recognize and translate +}
procedure Add;
begin
   Match('+');
   Term;
   EmitLn('popq %r13');
   EmitLn('addq %r13, %r12');
end;

{Recognize and translate -}
procedure Subtract;
begin
   Match('-');
   Term;
   EmitLn('popq %r13');
   EmitLn('subq %r13, %r12');
   EmitLn('neg %r12');
end;


{Parse + translate expression}
procedure Expression;
begin
   Term;
   while Look in ['+', '-'] do begin
      EmitLn('pushq %r12');
      case Look of
	'+' : Add;
	'-' : Subtract;
	else Expected('add operation');
      end;
   end;
end;

{Init}
procedure Init;
begin
   getChar;
end;

{MAIN}

begin
   Init;
   Expression;
end.
