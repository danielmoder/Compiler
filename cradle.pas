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




{Get single mathematical expression TERM}
procedure Term;
begin
   EmitLn('movl $' + GetNum + ', %eax')
end;

{Recognize + translate +}
procedure Add;
begin
   Match('+');
   Term;
   EmitLn('addl %eax, %ebx');
end;

{Recognize + translate -}
procedure Subtract;
begin
   Match('-');
   Term;
   EmitLn('subl %eax, %ebx');
end;


{Parse + translate expression}
procedure Expression;
begin
   Term;
   while Look in ['+', '-'] do begin
      EmitLn('movl %eax, %ebx');
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
