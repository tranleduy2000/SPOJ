

uses crt;
var a: array [1..100000] of integer;
        n, i : integer;
Begin
 clrscr;
 randomize;
 n:= random(1001);
 for i:=1 to n do
  begin
   a[i] := random(300);
   write(a[i], ' ');
  end;
  readln
end.